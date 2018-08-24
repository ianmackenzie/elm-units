module Velocity2d exposing
    ( Velocity2d
    , convert
    )

import Length
import Speed exposing (Speed, SpeedUnits)
import Vector2d exposing (Vector2d)


type alias Velocity2d space =
    Vector2d (SpeedUnits space)


convert : Length.Conversion sourceSpace destinationSpace -> Velocity2d sourceSpace -> Velocity2d destinationSpace
convert sourceToDestination velocity =
    let
        ( xSpeed, ySpeed ) =
            Vector2d.components velocity
    in
    Vector2d.fromComponents
        ( Speed.convert sourceToDestination xSpeed
        , Speed.convert sourceToDestination ySpeed
        )
