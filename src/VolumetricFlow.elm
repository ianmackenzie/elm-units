module VolumetricFlow exposing
    ( VolumetricFlow, CubicMetersPerSecond
    , cubicMetersPerSecond, inCubicMetersPerSecond
    , litersPerSecond, inLitersPerSecond
    , cubicCentimetersPerSecond, cubicFeetPerSecond, imperialGallonsPerMinute, inCubicCentimetersPerSecond, inCubicFeetPerSecond, inImperialGallonsPerMinute, inUsDryGallonsPerMinute, inUsLiquidGallonsPerMinute, usDryGallonsPerMinute, usLiquidGallonsPerMinute
    )

{-| VolumetricFlow represents the velocity in seconds of a particular
volume measured in cubic meters, cubic feet, liters, US liquid gallons,
imperial fluid ounces, etc. It is stored as a number of cubic meters per sercond

Note that since `CubicMetersPerSecond` is defined as `Rate CubicMeters Seconds`,
you can construct `VolumetricFlow` value using `Quantity.per`:

    volumetricFlow =
        volume |> Quantity.per duration

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


{-| Construct unit of volumetic flow from a number of cubic centimeters per second.
-}
cubicCentimetersPerSecond : Float -> VolumetricFlow
cubicCentimetersPerSecond numCubicCentietersPerSecond =
    cubicCentimetersPerSecond (numCubicCentietersPerSecond * 1.0e-2)


{-| Convert a volumetric flow to a number of cubic meters per second.
-}
inCubicCentimetersPerSecond : VolumetricFlow -> Float
inCubicCentimetersPerSecond volumetricFlow =
    inCubicMetersPerSecond volumetricFlow / 1.0e-3


{-| Construct unit of volumetric flow from number of cubic feet per second
-}
cubicFeetPerSecond : Float -> VolumetricFlow
cubicFeetPerSecond numCubicFeetPerSecond =
    cubicMetersPerSecond (Constants.cubicFoot * numCubicFeetPerSecond)


{-| Convert a volumetric flow to a number of liters per second.
-}
inCubicFeetPerSecond : VolumetricFlow -> Float
inCubicFeetPerSecond volumetricFlow =
    inCubicMetersPerSecond volumetricFlow / Constants.cubicFoot


{-| Construct unit of volumetric flow from number of imperial gallons per minute
-}
imperialGallonsPerMinute : Float -> VolumetricFlow
imperialGallonsPerMinute numImperialGallonsPerMinute =
    cubicMetersPerSecond (Constants.imperialGallon * numImperialGallonsPerMinute * 60)


{-| Convert a volumetric flow to a number of imperial gallons per minute.
-}
inImperialGallonsPerMinute : VolumetricFlow -> Float
inImperialGallonsPerMinute volumetricFlow =
    inCubicMetersPerSecond volumetricFlow / Constants.imperialGallon / 60


{-| Construct unit of volumetric flow from number of us liquid gallons per minute
-}
usLiquidGallonsPerMinute : Float -> VolumetricFlow
usLiquidGallonsPerMinute numUsLiquidGallonsPerMinute =
    cubicMetersPerSecond (Constants.usLiquidGallon * numUsLiquidGallonsPerMinute * 60)


{-| Convert a volumetric flow to a number of us liquid gallons per minute.
-}
inUsLiquidGallonsPerMinute : VolumetricFlow -> Float
inUsLiquidGallonsPerMinute volumetricFlow =
    inCubicMetersPerSecond volumetricFlow / Constants.usLiquidGallon / 60


{-| Construct unit of volumetric flow from number of us dry gallons per minute
-}
usDryGallonsPerMinute : Float -> VolumetricFlow
usDryGallonsPerMinute numUsDryGallonsPerMinute =
    cubicMetersPerSecond (Constants.usDryGallon * numUsDryGallonsPerMinute * 60)


{-| Convert a volumetric flow to a number of us dry gallons per minute.
-}
inUsDryGallonsPerMinute : VolumetricFlow -> Float
inUsDryGallonsPerMinute volumetricFlow =
    inCubicMetersPerSecond volumetricFlow / Constants.usDryGallon / 60
