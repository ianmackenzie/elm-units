module Acceleration
    exposing
        ( Acceleration
        , AccelerationUnits
        , convert
        , feetPerSecondSquared
        , inFeetPerSecondSquared
        , inMetersPerSecondSquared
        , inPixelsPerSecondSquared
        , metersPerSecondSquared
        , pixelsPerSecondSquared
        )

import Duration exposing (Seconds)
import Length exposing (OnScreen, RealWorld)
import Quantity exposing (Quantity(..), Quotient, Rate)
import Speed exposing (SpeedUnits)


type alias AccelerationUnits space =
    Quotient (SpeedUnits space) Seconds


type alias Acceleration space =
    Rate (SpeedUnits space) Seconds


pixelsPerSecondSquared : Float -> Acceleration OnScreen
pixelsPerSecondSquared numPixelsPerSecondSquared =
    Quantity numPixelsPerSecondSquared


inPixelsPerSecondSquared : Acceleration OnScreen -> Float
inPixelsPerSecondSquared (Quantity numPixelsPerSecondSquared) =
    numPixelsPerSecondSquared


metersPerSecondSquared : Float -> Acceleration RealWorld
metersPerSecondSquared numMetersPerSecondSquared =
    Quantity numMetersPerSecondSquared


inMetersPerSecondSquared : Acceleration RealWorld -> Float
inMetersPerSecondSquared (Quantity numMetersPerSecondSquared) =
    numMetersPerSecondSquared


feetPerSecondSquared : Float -> Acceleration RealWorld
feetPerSecondSquared numFeetPerSecondSquared =
    metersPerSecondSquared (0.3048 * numFeetPerSecondSquared)


inFeetPerSecondSquared : Acceleration RealWorld -> Float
inFeetPerSecondSquared acceleration =
    inMetersPerSecondSquared acceleration / 0.3048


convert : Length.Conversion sourceSpace destinationSpace -> Acceleration sourceSpace -> Acceleration destinationSpace
convert (Quantity rate) (Quantity value) =
    Quantity (rate * value)
