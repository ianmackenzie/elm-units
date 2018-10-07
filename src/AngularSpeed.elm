module AngularSpeed exposing
    ( AngularSpeed, RadiansPerSecond
    --, radiansPerSecond, inRadiansPerSecond, degreesPerSecond, inDegreesPerSecond
    --, turnsPerSecond, inTurnsPerSecond, revolutionsPerMinute, inRevolutionsPerMinute
    )

{-| An `AngularSpeed` represents an acceleration in radians per second,
degrees per second, turns per second and revolutions (turns) per minute.
It is stored as a number of radians per second.

@docs AngularSpeed, RadiansPerSecond

--@docs radiansPerSecond, inRadiansPerSecond, degreesPerSecond, inDegreesPerSecond
--@docs turnsPerSecond, inTurnsPerSecond, revolutionsPerMinute, inRevolutionsPerMinute

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
