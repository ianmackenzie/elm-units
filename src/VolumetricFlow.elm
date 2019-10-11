module VolumetricFlow exposing
    ( VolumetricFlow, CubicMetersPerSecond
    , cubicMetersPerSecond, inCubicMetersPerSecond
    , litersPerSecond, inLitersPerSecond
    )

{-| VolumetricFlow represents the velocity in seconds of a particular
volume measured in cubic meters, cubic feet, liters, US liquid gallons,
imperial fluid ounces, etc. It is stored as a number of cubic meters per sercond

@docs VolumetricFlow, CubicMetersPerSecond


## Metric

@docs cubicMetersPerSecond, inCubicMetersPerSecond
@docs litersPerSecond, inLitersPerSecond

-}

import Constants
import Duration exposing (Seconds)
import Quantity exposing (Quantity(..), Rate)
import Volume exposing (CubicMeters)


type alias CubicMetersPerSecond =
    Rate CubicMeters Seconds


type alias VolumetricFlow =
    Quantity Float CubicMetersPerSecond


{-| Construct unit of volumetic flow from a number of cubic meters per second.
-}
cubicMetersPerSecond : Float -> VolumetricFlow
cubicMetersPerSecond numCubicMetersPerSecond =
    Quantity numCubicMetersPerSecond


{-| Convert a volumetric flow to a number of cubic meters per second.
-}
inCubicMetersPerSecond : VolumetricFlow -> Float
inCubicMetersPerSecond (Quantity numCubicMetersPerSecond) =
    numCubicMetersPerSecond


{-| Construct unit of volumetric flow from number of liters per second
-}
litersPerSecond : Float -> VolumetricFlow
litersPerSecond numLitersPerSecond =
    cubicMetersPerSecond (Constants.liter * numLitersPerSecond)


{-| Convert a volumetric flow to a number of liters per second.
-}
inLitersPerSecond : VolumetricFlow -> Float
inLitersPerSecond volumetricFlow =
    inCubicMetersPerSecond volumetricFlow / Constants.liter
