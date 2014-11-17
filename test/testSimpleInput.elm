
import Touch
import Window
import Keyboard


game = { page = 0, selection = 0 }

input = (,) <~ Keyboard.arrows ~ Keyboard.keysDown

handlePageChange ({x,y}, keys) g = 
  { g | page <- if | x > 0 -> g.page+1
                   | x < 0 -> g.page-1
                   | otherwise -> g.page,
        selection <- if | y > 0 -> g.selection + 1 
                        | y < 0 -> g.selection - 1
                        | otherwise -> g.selection }
                   
handle input = handlePageChange input

display game =
  asText game

main = display <~ foldp handle game input