module Speed
    exposing
        ( Speed
        , SpeedUnits
        , convert
        , feetPerSecond
        , inFeetPerSecond
        , inKilometersPerHour
        , inMetersPerSecond
        , inMilesPerHour
        , inPixelsPerSecond
        , kilometersPerHour
        , metersPerSecond
        , milesPerHour
        , pixelsPerSecond
        )

import Duration exposing (Seconds)
import Length exposing (LengthUnits, OnScreen, RealWorld)
import Quantity exposing (Quantity(..), Quotient, Rate)


type alias SpeedUnits space =
    Quotient (LengthUnits space) Seconds


type alias Speed space =
    Rate (LengthUnits space) Seconds


pixelsPerSecond : Float -> Speed OnScreen
pixelsPerSecond numPixelsPerSecond =
    Quantity numPixelsPerSecond


inPixelsPerSecond : Speed OnScreen -> Float
inPixelsPerSecond (Quantity numPixelsPerSecond) =
    numPixelsPerSecond


metersPerSecond : Float -> Speed RealWorld
metersPerSecond numMetersPerSecond =
    Quantity numMetersPerSecond


inMetersPerSecond : Speed RealWorld -> Float
inMetersPerSecond (Quantity numMetersPerSecond) =
    numMetersPerSecond


feetPerSecond : Float -> Speed RealWorld
feetPerSecond numFeetPerSecond =
    metersPerSecond (0.3048 * numFeetPerSecond)


inFeetPerSecond : Speed RealWorld -> Float
inFeetPerSecond speed =
    inMetersPerSecond speed / 0.3048


kilometersPerHour : Float -> Speed RealWorld
kilometersPerHour numKilometersPerHour =
    metersPerSecond (numKilometersPerHour / 3.6)


inKilometersPerHour : Speed RealWorld -> Float
inKilometersPerHour speed =
    3.6 * inMetersPerSecond speed


milesPerHour : Float -> Speed RealWorld
milesPerHour numMilesPerHour =
    metersPerSecond (numMilesPerHour * 1609.344 / 3600)


inMilesPerHour : Speed RealWorld -> Float
inMilesPerHour speed =
    (3600 / 1609.344) * inMetersPerSecond speed


convert : Length.Conversion sourceSpace destinationSpace -> Speed sourceSpace -> Speed destinationSpace
convert (Quantity rate) (Quantity value) =
    Quantity (rate * value)
