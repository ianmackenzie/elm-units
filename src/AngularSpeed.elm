module AngularSpeed exposing
    ( AngularSpeed, RadiansPerSecond
    , radiansPerSecond, inRadiansPerSecond, degreesPerSecond, inDegreesPerSecond
    , turnsPerSecond, inTurnsPerSecond, turnsPerMinute, inTurnsPerMinute
    , revolutionsPerSecond, inRevolutionsPerSecond, revolutionsPerMinute, inRevolutionsPerMinute
    )

{-| An `AngularSpeed` represents a rotation rate in radians per second, degrees
per second, turns (revolutions) per second or turns (revolutions) per minute.
It is stored as a number of radians per second.

Note that since `RadiansPerSecond` is defined as `Rate Radians Seconds` (angle
per unit time), you can construct an `AngularSpeed` value using `Quantity.per`:

    angularSpeed =
        angle |> Quantity.per duration

You can also do rate-related calculations with `AngularSpeed` values to compute
`Angle` or `Duration`:

    angle =
        angularSpeed |> Quantity.for duration

    alsoAngle =
        duration |> Quantity.at angularSpeed

    duration =
        angle |> Quantity.at_ angularSpeed

@docs AngularSpeed, RadiansPerSecond


## Conversions

@docs radiansPerSecond, inRadiansPerSecond, degreesPerSecond, inDegreesPerSecond
@docs turnsPerSecond, inTurnsPerSecond, turnsPerMinute, inTurnsPerMinute


## Aliases for `turns` as `revolutions`

The Elm core `Basics` module uses `turns` in its [Angle Conversions](https://package.elm-lang.org/packages/elm-lang/core/latest/Basics#angle-conversions).
To be consistent, this module also uses `turns`, however since 'revolutions per
minute' (RPM) is in common usage, several aliases are provided.

@docs revolutionsPerSecond, inRevolutionsPerSecond, revolutionsPerMinute, inRevolutionsPerMinute

-}

import Angle exposing (Radians)
import Duration exposing (Seconds)
import Quantity exposing (Quantity(..), Rate)


{-| -}
type alias RadiansPerSecond =
    Rate Radians Seconds


{-| -}
type alias AngularSpeed =
    Quantity Float RadiansPerSecond


{-| Construct an angular speed from a number of radians per second.
-}
radiansPerSecond : Float -> AngularSpeed
radiansPerSecond numRadiansPerSecond =
    Quantity numRadiansPerSecond


{-| Convert an angular speed to a number of radians per second.
-}
inRadiansPerSecond : AngularSpeed -> Float
inRadiansPerSecond (Quantity numRadiansPerSecond) =
    numRadiansPerSecond


{-| Construct an angular speed from a number of degrees per second.
-}
degreesPerSecond : Float -> AngularSpeed
degreesPerSecond numDegreesPerSecond =
    radiansPerSecond (pi / 180 * numDegreesPerSecond)


{-| Convert an angular speed to a number of degrees per second.
-}
inDegreesPerSecond : AngularSpeed -> Float
inDegreesPerSecond angularSpeed =
    inRadiansPerSecond angularSpeed / (pi / 180)


{-| Construct an angular speed from a number of turns per second.
-}
turnsPerSecond : Float -> AngularSpeed
turnsPerSecond numTurnsPerSecond =
    radiansPerSecond (2 * pi * numTurnsPerSecond)


{-| Convert an angular speed to a number of turns per second.
-}
inTurnsPerSecond : AngularSpeed -> Float
inTurnsPerSecond angularSpeed =
    inRadiansPerSecond angularSpeed / (2 * pi)


{-| Construct an angular speed from a number of turns per minute.
-}
turnsPerMinute : Float -> AngularSpeed
turnsPerMinute numTurnsPerMinute =
    radiansPerSecond ((2 * pi * numTurnsPerMinute) / 60)


{-| Convert an angular speed to a number of turns per minute.
-}
inTurnsPerMinute : AngularSpeed -> Float
inTurnsPerMinute angularSpeed =
    inRadiansPerSecond angularSpeed / ((2 * pi) / 60)



---------- FUNCTION ALIASES ----------


{-| Alias for `turnsPerSecond`.
-}
revolutionsPerSecond : Float -> AngularSpeed
revolutionsPerSecond =
    turnsPerSecond


{-| Alias for `inTurnsPerSecond`.
-}
inRevolutionsPerSecond : AngularSpeed -> Float
inRevolutionsPerSecond =
    inTurnsPerSecond


{-| Alias for `turnsPerMinute`.
-}
revolutionsPerMinute : Float -> AngularSpeed
revolutionsPerMinute =
    turnsPerMinute


{-| Alias for `inTurnsPerMinute`.
-}
inRevolutionsPerMinute : AngularSpeed -> Float
inRevolutionsPerMinute =
    inTurnsPerMinute
