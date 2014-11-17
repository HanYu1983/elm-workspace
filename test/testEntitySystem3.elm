import Keyboard
import Maybe
import Set

-- data

data Component = 
  Position (Float, Float) | 
  Velocity (Float, Float) 

data Team = TeamUnknown | TeamLeft | TeamRight

leftPosition = Position (-150, 0)
rightPosition = Position (150, 0)

emptyEntity = 
  {
    position = Nothing,
    velocity = Nothing,
    team = TeamUnknown,
    isRemove = False
  }

monster team = 
  { emptyEntity | position <- if team == TeamLeft then Just <| leftPosition else Just <| rightPosition,
                  velocity <- Just <| Velocity (100, 0),
                  team <- team }

-- system

removeSystem input game entity list = 
  if entity.isRemove then list else entity :: list

adminSystem (dt, ks) game entity list = 
  if | Set.member 37 ks.onKeyUp -> monster TeamLeft :: game.entities
     | Set.member 39 ks.onKeyUp -> monster TeamRight :: game.entities
     | otherwise -> game.entities
  

attackSystem input game entity list = 
  entity :: list
  
moveSystem (t, ks) game entity list =
  let isActive = all Maybe.isJust [entity.position, entity.velocity]
  in
    if isActive then 
      let
        dt = game.elapsedTime
        (Position (x,y)) = Maybe.maybe (Position (0,0)) identity entity.position
        (Velocity (vx, vy)) = Maybe.maybe (Velocity (0,0)) identity entity.velocity
        (nx, ny) = if entity.team == TeamRight then (x-vx*dt, y+vy*dt) else (x+vx*dt, y+vy*dt)
        isRemove = x < -160 || y > 160
      in 
        {entity | isRemove <- isRemove, position <- Just <| (Position (nx, ny)) } :: list
    else
      entity :: list

-- game init

game = { 
  currTime = 0.0,
  elapsedTime = 0.0,
  entities = [monster TeamLeft] 
  }

display game = 
  let
    showMonster entity = 
      let hasPos = Maybe.isJust entity.position in
      let (Position pos) = Maybe.maybe (Position (0,0)) identity entity.position in
      filled (rgba 111 111 111 0.6) (ngon 5 20) |> move pos
  in
    collage 300 300 (map showMonster game.entities)

-- input
update ((t, ks) as input) game=
  let                 
    updateElapsedTime game = 
      { game | currTime <- t,
               elapsedTime <- (t - game.currTime) }
    newEntities = 
      foldr (removeSystem input game) [] <<
      foldr (moveSystem input game) [] <<
      foldr (attackSystem input game) [] <<
      foldr (adminSystem input game) [] << .entities <| game

    game2 = updateElapsedTime game
  in { game2 | entities <- newEntities }
  
fpsSignal = fps 60
input = (,) <~ (timer fpsSignal) ~ (keysStatus fpsSignal)

main =
  display <~ foldp update game input


-- tool
timer timeSigal = foldp (+) 0 (inSeconds <~ timeSigal)

keysStatus timeSigal =
  let 
    currStatus = { onKeyHold = Set.fromList [],
                   onKeyDown = Set.fromList [],
                   onKeyUp = Set.fromList [] }
    handle (keys, _) currStatus =
      { currStatus | onKeyHold <- Set.fromList keys,
                     onKeyDown <- Set.diff (Set.fromList keys) currStatus.onKeyHold,
                     onKeyUp <- Set.diff currStatus.onKeyHold (Set.fromList keys) }
  in foldp handle currStatus ((,) <~ Keyboard.keysDown ~ timeSigal)

