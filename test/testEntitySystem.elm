import Maybe

data Component = Position (Float, Float) | Velocity (Float, Float)

type Entity = 
  {
    position : Maybe Component,
    velocity : Maybe Component
  }
  
emptyEntity = 
  {
    position = Nothing,
    velocity = Nothing
  }

createCar : (Float, Float) -> (Float, Float)-> Entity
createCar pos vel = 
  { emptyEntity | position <- Just <| Position pos, 
                  velocity <- Just <| Velocity vel }
                  
createStone pos =
  { emptyEntity | position <- Just <| Position pos }


updateCar entities entity list =
  let
    hasPosAndVel = all Maybe.isJust [entity.position, entity.velocity]
    (Velocity (vx,vy)) = Maybe.maybe (Velocity(0,0)) identity entity.velocity
    (Position (x,y)) = Maybe.maybe (Position(0,0)) identity entity.position
    newEntity = { entity | position <- Just <| Position(x+vx,y+vy) }
  in
    newEntity :: list

  
updateEntities entities = 
  foldl (updateCar entities) [] entities


main = 
  asText <| updateEntities [createCar (0.0, 0.0) (1.0,2.0), createStone (5,5)]