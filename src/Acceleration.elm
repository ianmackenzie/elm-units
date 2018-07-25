module Acceleration
    exposing
        ( Acceleration
        , feetPerSecondSquared
        , inFeetPerSecondSquared
        , inMetersPerSecondSquared
        , metersPerSecondSquared
        )

import Quantity exposing (AccelerationUnits, Quantity(..), ScreenSpace, WorldSpace)


type alias Acceleration space =
    -- Meters per second squared for WorldSpace
    -- Pixels per second squared for ScreenSpace
    Quantity (AccelerationUnits space)


metersPerSecondSquared : Float -> Acceleration WorldSpace
metersPerSecondSquared numMetersPerSecondSquared =
    Quantity numMetersPerSecondSquared


inMetersPerSecondSquared : Acceleration WorldSpace -> Float
inMetersPerSecondSquared (Quantity numMetersPerSecondSquared) =
    numMetersPerSecondSquared


feetPerSecondSquared : Float -> Acceleration WorldSpace
feetPerSecondSquared numFeetPerSecondSquared =
    metersPerSecondSquared (0.3048 * numFeetPerSecondSquared)


inFeetPerSecondSquared : Acceleration WorldSpace -> Float
inFeetPerSecondSquared acceleration =
    inMetersPerSecondSquared acceleration / 0.3048
