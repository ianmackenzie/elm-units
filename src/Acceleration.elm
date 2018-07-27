module Acceleration
    exposing
        ( Acceleration
        , feetPerSecondSquared
        , inFeetPerSecondSquared
        , inMetersPerSecondSquared
        , metersPerSecondSquared
        )

import Quantity exposing (Quantity(..), ScreenSpace, WorldSpace)


type alias Acceleration space =
    Quantity.Acceleration space


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
