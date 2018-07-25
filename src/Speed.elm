module Speed
    exposing
        ( Speed
        , feetPerSecond
        , inFeetPerSecond
        , inKilometersPerHour
        , inMetersPerSecond
        , inMilesPerHour
        , inPixelsPerMillisecond
        , inPixelsPerSecond
        , kilometersPerHour
        , metersPerSecond
        , milesPerHour
        , pixelsPerMillisecond
        , pixelsPerSecond
        )

import Quantity exposing (Quantity(..), ScreenSpace, SpeedUnits, WorldSpace)


type alias Speed space =
    -- Meters per second for WorldSpace
    -- Pixels per second for ScreenSpace
    Quantity (SpeedUnits space)


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


pixelsPerSecond : Float -> Speed ScreenSpace
pixelsPerSecond numPixelsPerSecond =
    Quantity numPixelsPerSecond


inPixelsPerSecond : Speed ScreenSpace -> Float
inPixelsPerSecond (Quantity numPixelsPerSecond) =
    numPixelsPerSecond


pixelsPerMillisecond : Float -> Speed ScreenSpace
pixelsPerMillisecond numPixelsPerMillisecond =
    pixelsPerSecond (1000 * numPixelsPerMillisecond)


inPixelsPerMillisecond : Speed ScreenSpace -> Float
inPixelsPerMillisecond speed =
    0.001 * inPixelsPerSecond speed
