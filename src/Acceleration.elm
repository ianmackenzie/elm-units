module Acceleration exposing
    ( Acceleration
    , MetersPerSecondSquared
    , feetPerSecondSquared
    , inFeetPerSecondSquared
    , inMetersPerSecondSquared
    , metersPerSecondSquared
    )

import Duration exposing (Seconds)
import Length exposing (Meters)
import Quantity exposing (Fractional, Quantity(..), Quotient)
import Speed exposing (MetersPerSecond)


type alias MetersPerSecondSquared =
    Quotient MetersPerSecond Seconds


type alias Acceleration =
    Fractional MetersPerSecondSquared


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
