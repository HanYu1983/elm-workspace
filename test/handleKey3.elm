import Keyboard
import Window
import Set


data EntityType = Player | Bullet

game = { 
  onKeyHold = Set.fromList [],
  onKeyUp = Set.fromList [],
  onKeyDown = Set.fromList [],
  entities = [{position = (0.0,0.0), entityType=Player}] 
  }


input = 
  let comp n delta = { keys = (Set.fromList n), dt = delta } in
  comp <~ Keyboard.keysDown ~ (fps 60)
  

updatePlayer game entity list = 
  let 
    handleUp entity = 
      { entity | position <- if | Set.member 38 game.onKeyHold -> let (x,y) = entity.position in (x, y+1)
                                | otherwise -> entity.position }
    handleDown entity = 
      { entity | position <- if | Set.member 40 game.onKeyHold -> let (x,y) = entity.position in (x, y-1)
                                | otherwise -> entity.position }
    handleLeft entity = 
      { entity | position <- if | Set.member 37 game.onKeyHold -> let (x,y) = entity.position in (x-1, y)
                                | otherwise -> entity.position }
    handleRight entity = 
      { entity | position <- if | Set.member 39 game.onKeyHold -> let (x,y) = entity.position in (x+1, y)
                                | otherwise -> entity.position }
                                
    updated = entity |> handleUp >> handleDown >> handleLeft >> handleRight in
  if | Set.member 32 game.onKeyDown -> updated :: {position=entity.position, entityType=Bullet} :: list
     | otherwise -> updated :: list
     
updateBullet game entity list =
  let
    (x,y) = entity.position
    shouldRemove = x > 100 in
  if | shouldRemove -> list
     | otherwise -> 
       let updated = {entity | position <- let (x,y) = entity.position in (x+5, y)} in
       updated :: list

updateEntity game entity list = 
  if | entity.entityType == Player -> updatePlayer game entity list
     | entity.entityType == Bullet -> updateBullet game entity list
     | otherwise -> entity :: list
  
updateEntities game = 
  { game | entities <- foldl (updateEntity game) [] game.entities }

  
updateInput ({keys, dt} as input) game = 
  { game | onKeyHold <- keys,
           onKeyDown <- Set.diff keys game.onKeyHold,
           onKeyUp <- Set.diff game.onKeyHold keys}
  
update input = 
  updateInput input >> updateEntities


-- Display

clearGrey = rgba 111 111 111 0.6

makeObject entity =
  case entity.entityType of
    Player -> filled clearGrey (ngon 5 20) |> move entity.position
    Bullet -> filled clearGrey (ngon 16 5) |> move entity.position

display (w, h) game = 
  layers [ 
    container w h middle <| asText "arrow to move, space to shoot",
    collage w h <| map makeObject game.entities
  ]

main = 
  display <~ Window.dimensions ~ (foldp update game input)