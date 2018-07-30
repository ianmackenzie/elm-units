module Acceleration
    exposing
        ( Acceleration
        , feetPerSecondSquared
        , inFeetPerSecondSquared
        , inMetersPerSecondSquared
        , metersPerSecondSquared
        )

import Duration exposing (Seconds)
import Length exposing (Meters)
import Quantity exposing (Quantity(..), Rate)


type alias Acceleration =
    Quantity (Rate (Rate Meters Seconds) Seconds)


metersPerSecondSquared : Float -> Acceleration
metersPerSecondSquared numMetersPerSecondSquared =
    Quantity numMetersPerSecondSquared


inMetersPerSecondSquared : Acceleration -> Float
inMetersPerSecondSquared (Quantity numMetersPerSecondSquared) =
    numMetersPerSecondSquared


feetPerSecondSquared : Float -> Acceleration
feetPerSecondSquared numFeetPerSecondSquared =
    metersPerSecondSquared (0.3048 * numFeetPerSecondSquared)


inFeetPerSecondSquared : Acceleration -> Float
inFeetPerSecondSquared acceleration =
    inMetersPerSecondSquared acceleration / 0.3048
