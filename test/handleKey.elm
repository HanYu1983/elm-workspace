import Keyboard
import Window
import Set

clearGrey : Color
clearGrey = rgba 111 111 111 0.6

game = { 
  onKeyHold = Set.fromList [],
  onKeyUp = Set.fromList [],
  onKeyDown = Set.fromList [],
  entities = [{position = (0.0,0.0)}, {position = (10.0, 0.0)}] 
  }


input = 
  let comp n delta = { keys = (Set.fromList n), dt = delta } in
  comp <~ Keyboard.keysDown ~ (fps 30)
  
  
updateInput ({keys, dt} as input) game = 
  { game | onKeyHold <- keys,
           onKeyDown <- Set.diff keys game.onKeyHold,
           onKeyUp <- Set.diff game.onKeyHold keys}
  
update input = 
  updateInput input

displayPlayer {position} = 
  filled clearGrey (ngon 4 60) |> move position

display game = 
  collage 300 300 <| map displayPlayer game.entities

main = 
  asText <~ (foldp update game input)