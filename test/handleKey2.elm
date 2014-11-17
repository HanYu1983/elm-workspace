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
  comp <~ Keyboard.keysDown ~ (fps 1)
  

updatePlayer game entity list = 
  let updated = {entity | position <- if | Set.member 38 game.onKeyHold  -> let (x,y) = entity.position in (x, y+1)
                                         | Set.member 40 game.onKeyHold  -> let (x,y) = entity.position in (x, y-1)
                                         | Set.member 37 game.onKeyHold  -> let (x,y) = entity.position in (x-1, y)
                                         | Set.member 39 game.onKeyHold  -> let (x,y) = entity.position in (x+1, y)
                                         | otherwise -> entity.position } in
  if | Set.member 32 game.onKeyDown -> updated :: {position=(0.0,0.0), entityType=Bullet} :: list
     | otherwise -> updated :: list
     
updateBullet game entity list =
  let updated = {entity | position <- let (x,y) = entity.position in (x+1, y)} in
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


main = 
  asText <~ (foldp update game input)