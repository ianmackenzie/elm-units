module Speed exposing
    ( Speed, MetersPerSecond
    , metersPerSecond, inMetersPerSecond, feetPerSecond, inFeetPerSecond
    , kilometersPerHour, inKilometersPerHour, milesPerHour, inMilesPerHour
    )

{-| A `Speed` value represents a speed in meters per second, miles per hour etc.
It is stored as a number of meters per second.

Note that since `MetersPerSecond` is defined as `Rate Meters Seconds` (length
per unit time), you can construct a `Speed` value using `Quantity.per`:

    speed =
        length |> Quantity.per duration

You can also do rate-related calculations with `Speed` values to compute
`Length` or `Duration`:

    length =
        speed |> Quantity.for duration

    alsoLength =
        duration |> Quantity.at speed

    duration =
        length |> Quantity.at_ speed

@docs Speed, MetersPerSecond

@docs metersPerSecond, inMetersPerSecond, feetPerSecond, inFeetPerSecond
@docs kilometersPerHour, inKilometersPerHour, milesPerHour, inMilesPerHour

-}

import Constants
import Duration exposing (Seconds)
import Length exposing (Meters)
import Quantity exposing (Quantity(..), Rate)


{-| -}
type alias MetersPerSecond =
    Rate Meters Seconds


{-| -}
type alias Speed =
    Quantity Float MetersPerSecond


{-| Construct a speed from a number of meters per second.
-}
metersPerSecond : Float -> Speed
metersPerSecond numMetersPerSecond =
    Quantity numMetersPerSecond


{-| Convert a speed to a number of meters per second.
-}
inMetersPerSecond : Speed -> Float
inMetersPerSecond (Quantity numMetersPerSecond) =
    numMetersPerSecond


{-| Construct a speed from a number of feet per second.
-}
feetPerSecond : Float -> Speed
feetPerSecond numFeetPerSecond =
    metersPerSecond (Constants.foot * numFeetPerSecond)


{-| Convert a speed to a number of feet per second.
-}
inFeetPerSecond : Speed -> Float
inFeetPerSecond speed =
    inMetersPerSecond speed / Constants.foot


{-| Construct a speed from a number of kilometers per hour.
-}
kilometersPerHour : Float -> Speed
kilometersPerHour numKilometersPerHour =
    metersPerSecond (numKilometersPerHour / 3.6)


{-| Convert a speed to a number of kilometers per hour.
-}
inKilometersPerHour : Speed -> Float
inKilometersPerHour speed =
    3.6 * inMetersPerSecond speed


{-| Construct a speed from a number of miles per hour.
-}
milesPerHour : Float -> Speed
milesPerHour numMilesPerHour =
    metersPerSecond (numMilesPerHour * Constants.mile / 3600)


{-| Convert a speed to a number of miles per hour.
-}
inMilesPerHour : Speed -> Float
inMilesPerHour speed =
    (3600 / Constants.mile) * inMetersPerSecond speed
