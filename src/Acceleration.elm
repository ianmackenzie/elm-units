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
import Length
import Quantity exposing (Quantity(..), Quotient, Rate)
import Spaces exposing (ScreenSpace, WorldSpace)
import Speed exposing (SpeedUnits)


type alias AccelerationUnits space =
    Quotient (SpeedUnits space) Seconds


type alias Acceleration space =
    Rate (SpeedUnits space) Seconds


pixelsPerSecondSquared : Float -> Acceleration ScreenSpace
pixelsPerSecondSquared numPixelsPerSecondSquared =
    Quantity numPixelsPerSecondSquared


inPixelsPerSecondSquared : Acceleration ScreenSpace -> Float
inPixelsPerSecondSquared (Quantity numPixelsPerSecondSquared) =
    numPixelsPerSecondSquared


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


convert : Length.Conversion sourceSpace destinationSpace -> Acceleration sourceSpace -> Acceleration destinationSpace
convert (Quantity rate) (Quantity value) =
    Quantity (rate * value)
