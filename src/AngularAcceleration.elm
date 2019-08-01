module AngularAcceleration exposing
    ( AngularAcceleration, RadiansPerSecondSquared
    , radiansPerSecondSquared, inRadiansPerSecondSquared, degreesPerSecondSquared, inDegreesPerSecondSquared
    , turnsPerSecondSquared, inTurnsPerSecondSquared
    )

{-| An `AngularAcceleration` represents an angular acceleration in radians per
second squared, degrees per second squared, and turns per second squared. It is
stored as a number of radians per second squared.

Note that since `RadiansPerSecondSquared` is defined as `Rate RadiansPerSecond
Seconds` (change in angular speed per unit time), you can construct an
`AngularAcceleration` value using `Quantity.per`:

    angularAcceleration =
        changeInAngularSpeed |> Quantity.per duration

You can also do rate-related calculations with `AngularAcceleration` values to
compute `AngularSpeed` or `Duration`:

    changeInAngularSpeed =
        angularAcceleration |> Quantity.for duration

    alsoChangeInAngularSpeed =
        duration |> Quantity.at angularAcceleration

    duration =
        changeInAngularSpeed |> Quantity.at_ angularAcceleration

@docs AngularAcceleration, RadiansPerSecondSquared


## Conversions

@docs radiansPerSecondSquared, inRadiansPerSecondSquared, degreesPerSecondSquared, inDegreesPerSecondSquared
@docs turnsPerSecondSquared, inTurnsPerSecondSquared

-}

import Angle exposing (Radians)
import AngularSpeed exposing (RadiansPerSecond)
import Duration exposing (Seconds)
import Quantity exposing (Quantity(..), Rate)


{-| -}
type alias RadiansPerSecondSquared =
    Rate RadiansPerSecond Seconds


{-| -}
type alias AngularAcceleration =
    Quantity Float RadiansPerSecondSquared


{-| Construct an angular acceleration from a number of radians per second squared.
-}
radiansPerSecondSquared : Float -> AngularAcceleration
radiansPerSecondSquared numRadiansPerSecondSquared =
    Quantity numRadiansPerSecondSquared


{-| Convert an angular acceleration to a number of radians per second squared.
-}
inRadiansPerSecondSquared : AngularAcceleration -> Float
inRadiansPerSecondSquared (Quantity numRadiansPerSecondSquared) =
    numRadiansPerSecondSquared


{-| Construct an angular acceleration from a number of degrees per second squared.
-}
degreesPerSecondSquared : Float -> AngularAcceleration
degreesPerSecondSquared numDegreesPerSecondSquared =
    radiansPerSecondSquared (pi / 180 * numDegreesPerSecondSquared)


{-| Convert an angular acceleration to a number of degrees per second squared.
-}
inDegreesPerSecondSquared : AngularAcceleration -> Float
inDegreesPerSecondSquared angularAcceleration =
    inRadiansPerSecondSquared angularAcceleration / (pi / 180)


{-| Construct an angular acceleration from a number of turns per second squared.
-}
turnsPerSecondSquared : Float -> AngularAcceleration
turnsPerSecondSquared numTurnsPerSecondSquared =
    radiansPerSecondSquared (2 * pi * numTurnsPerSecondSquared)


{-| Convert an angular acceleration to a number of turns per second squared.
-}
inTurnsPerSecondSquared : AngularAcceleration -> Float
inTurnsPerSecondSquared angularAcceleration =
    inRadiansPerSecondSquared angularAcceleration / (2 * pi)
