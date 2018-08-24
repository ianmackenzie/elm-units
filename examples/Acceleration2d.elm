module Acceleration2d exposing
    ( Acceleration2d
    , convert
    )

import Acceleration exposing (Acceleration, AccelerationUnits)
import Length
import Vector2d exposing (Vector2d)


type alias Acceleration2d space =
    Vector2d (AccelerationUnits space)


convert : Length.Conversion sourceSpace destinationSpace -> Acceleration2d sourceSpace -> Acceleration2d destinationSpace
convert sourceToDestination acceleration =
    let
        ( xAcceleration, yAcceleration ) =
            Vector2d.components acceleration
    in
    Vector2d.fromComponents
        ( Acceleration.convert sourceToDestination xAcceleration
        , Acceleration.convert sourceToDestination yAcceleration
        )
