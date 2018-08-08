module Speed
    exposing
        ( Speed
        , SpeedUnits
        , feetPerSecond
        , inFeetPerSecond
        , inKilometersPerHour
        , inMetersPerSecond
        , inMilesPerHour
        , kilometersPerHour
        , metersPerSecond
        , milesPerHour
        )

import Duration exposing (TimeUnits)
import Length exposing (LengthUnits)
import Quantity exposing (Quantity(..), Rate)


type alias SpeedUnits =
    Rate LengthUnits TimeUnits


type alias Speed =
    Quantity Float SpeedUnits


metersPerSecond : Float -> Speed
metersPerSecond numMetersPerSecond =
    Quantity numMetersPerSecond


inMetersPerSecond : Speed -> Float
inMetersPerSecond (Quantity numMetersPerSecond) =
    numMetersPerSecond


feetPerSecond : Float -> Speed
feetPerSecond numFeetPerSecond =
    metersPerSecond (0.3048 * numFeetPerSecond)


inFeetPerSecond : Speed -> Float
inFeetPerSecond speed =
    inMetersPerSecond speed / 0.3048


kilometersPerHour : Float -> Speed
kilometersPerHour numKilometersPerHour =
    metersPerSecond (numKilometersPerHour / 3.6)


inKilometersPerHour : Speed -> Float
inKilometersPerHour speed =
    3.6 * inMetersPerSecond speed


milesPerHour : Float -> Speed
milesPerHour numMilesPerHour =
    metersPerSecond (numMilesPerHour * 1609.344 / 3600)


inMilesPerHour : Speed -> Float
inMilesPerHour speed =
    (3600 / 1609.344) * inMetersPerSecond speed
