import Maybe
import Touch

data Component = 
  Position (Float, Float) | 
  Velocity (Float, Float) |
  PlayerController
  
  
type Entity = { 
  position: Maybe Component, 
  velocity: Maybe Component,
  playerController : Maybe Component
  }

emptyEntity = 
  {
    position = Nothing,
    velocity = Nothing,
    playerController = Nothing
  }
  
createPlayer pos vel =
  let car = createCar pos vel
  in { car | playerController <- Just <| PlayerController }

createCar : (Float, Float) -> (Float, Float) -> Entity
createCar pos vel = 
  { emptyEntity | position <- Just <| Position pos, 
                  velocity <- Just <| Velocity vel }
   
createStone : (Float, Float) -> Entity
createStone pos =
  { emptyEntity | position <- Just <| Position pos }


playerControllerSystem : ({x:Int, y:Int}, Float) -> [Entity] -> Entity -> [Entity] -> [Entity]
playerControllerSystem ({x,y}, dt) entities entity list = 
  let
    hasPlayerController = all Maybe.isJust [entity.position, entity.playerController]
  in
    if hasPlayerController
      then {entity | position <- Just <| Position(toFloat x,toFloat y) } :: list
      else entity :: list

velocitySystem : ({x:Int, y:Int}, Float) -> [Entity] -> Entity -> [Entity] -> [Entity]
velocitySystem input entities entity list =
  let
    hasPosAndVel = all Maybe.isJust [entity.position, entity.velocity]
  in
    if hasPosAndVel then 
      let
        (Velocity (vx,vy)) = Maybe.maybe (Velocity(0,0)) identity entity.velocity
        (Position (x,y)) = Maybe.maybe (Position(0,0)) identity entity.position
        newEntity = { entity | position <- Just <| Position(x+vx,y+vy) }
      in
        newEntity :: list
    else
      entity :: list


updateEntities : ({x:Int, y:Int}, Float) -> [Entity] -> [Entity]
updateEntities input entities = 
  foldr (velocitySystem input entities) [] << 
  foldr (playerControllerSystem input entities) [] <| entities
  
update : ({x:Int, y:Int}, Float) -> [Entity] -> [Entity]
update input =
  updateEntities input
  
input = 
  let
    fn touches dt = 
      if length touches == 0
        -- playerController entity position is (1,0) because here
        then ({x=0, y=0}, dt)
        else
          let [{x,y}] = take 1 touches
          in ({x=x,y=y}, dt)
  in 
    fn <~ Touch.touches ~ (fps 1)

main = 
  asText <~ (foldp update [createPlayer (0,0) (1,0), createCar (0,0) (1,2), createStone (1,1)] input)