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
import Length exposing (LengthUnits)
import Quantity exposing (Quantity(..), Quotient, Rate)
import Spaces exposing (ScreenSpace, WorldSpace)


type alias SpeedUnits space =
    Quotient (LengthUnits space) Seconds


type alias Speed space =
    Rate (LengthUnits space) Seconds


pixelsPerSecond : Float -> Speed ScreenSpace
pixelsPerSecond numPixelsPerSecond =
    Quantity numPixelsPerSecond


inPixelsPerSecond : Speed ScreenSpace -> Float
inPixelsPerSecond (Quantity numPixelsPerSecond) =
    numPixelsPerSecond


metersPerSecond : Float -> Speed WorldSpace
metersPerSecond numMetersPerSecond =
    Quantity numMetersPerSecond


inMetersPerSecond : Speed WorldSpace -> Float
inMetersPerSecond (Quantity numMetersPerSecond) =
    numMetersPerSecond


feetPerSecond : Float -> Speed WorldSpace
feetPerSecond numFeetPerSecond =
    metersPerSecond (0.3048 * numFeetPerSecond)


inFeetPerSecond : Speed WorldSpace -> Float
inFeetPerSecond speed =
    inMetersPerSecond speed / 0.3048


kilometersPerHour : Float -> Speed WorldSpace
kilometersPerHour numKilometersPerHour =
    metersPerSecond (numKilometersPerHour / 3.6)


inKilometersPerHour : Speed WorldSpace -> Float
inKilometersPerHour speed =
    3.6 * inMetersPerSecond speed


milesPerHour : Float -> Speed WorldSpace
milesPerHour numMilesPerHour =
    metersPerSecond (numMilesPerHour * 1609.344 / 3600)


inMilesPerHour : Speed WorldSpace -> Float
inMilesPerHour speed =
    (3600 / 1609.344) * inMetersPerSecond speed


convert : Length.Conversion sourceSpace destinationSpace -> Speed sourceSpace -> Speed destinationSpace
convert (Quantity rate) (Quantity value) =
    Quantity (rate * value)
