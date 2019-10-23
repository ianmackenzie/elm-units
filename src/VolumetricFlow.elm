module VolumetricFlow exposing
    ( VolumetricFlow, CubicMetersPerSecond
    , cubicMetersPerSecond, inCubicMetersPerSecond
    , litersPerSecond, inLitersPerSecond, cubicCentimetersPerSecond, inCubicCentimetersPerSecond
    , cubicFeetPerSecond, inCubicFeetPerSecond, imperialGallonsPerMinute, inImperialGallonsPerMinute
    , usLiquidGallonsPerMinute, inUsLiquidGallonsPerMinute, usDryGallonsPerMinute, inUsDryGallonsPerMinute
    )

{-| A `VolumetricFlow` represents a flow rate of volume per unit time measured
in cubic meters per second, cubic feet per second, liters per second, US liquid
gallons per minute, etc. It is stored as a number of cubic meters per second.

Note that since `CubicMetersPerSecond` is defined as `Rate CubicMeters Seconds`,
you can construct `VolumetricFlow` values using `Quantity.per`:

    volumetricFlow =
        volume |> Quantity.per duration

@docs VolumetricFlow, CubicMetersPerSecond


## Metric

@docs cubicMetersPerSecond, inCubicMetersPerSecond
@docs litersPerSecond, inLitersPerSecond, cubicCentimetersPerSecond, inCubicCentimetersPerSecond


## Imperial

@docs cubicFeetPerSecond, inCubicFeetPerSecond, imperialGallonsPerMinute, inImperialGallonsPerMinute


## US Custom

@docs usLiquidGallonsPerMinute, inUsLiquidGallonsPerMinute, usDryGallonsPerMinute, inUsDryGallonsPerMinute

-}

import Constants
import Duration exposing (Seconds)
import Quantity exposing (Quantity(..), Rate)
import Volume exposing (CubicMeters)


{-| -}
type alias CubicMetersPerSecond =
    Rate CubicMeters Seconds


{-| -}
type alias VolumetricFlow =
    Quantity Float CubicMetersPerSecond



----- CONSTANTS -----


oneUsLiquidGallonPerMinute : Float
oneUsLiquidGallonPerMinute =
    Constants.usLiquidGallon / Constants.minute



----- CONVERSIONS -----


{-| Construct a volumetric flow from a number of cubic meters per second.
-}
cubicMetersPerSecond : Float -> VolumetricFlow
cubicMetersPerSecond numCubicMetersPerSecond =
    Quantity numCubicMetersPerSecond


{-| Convert a volumetric flow to a number of cubic meters per second.
-}
inCubicMetersPerSecond : VolumetricFlow -> Float
inCubicMetersPerSecond (Quantity numCubicMetersPerSecond) =
    numCubicMetersPerSecond


{-| Construct a volumetric flow from a number of liters per second.
-}
litersPerSecond : Float -> VolumetricFlow
litersPerSecond numLitersPerSecond =
    cubicMetersPerSecond (Constants.liter * numLitersPerSecond)


{-| Convert a volumetric flow to a number of liters per second.
-}
inLitersPerSecond : VolumetricFlow -> Float
inLitersPerSecond volumetricFlow =
    inCubicMetersPerSecond volumetricFlow / Constants.liter


{-| Construct a volumetric flow from a number of cubic centimeters per second.
-}
cubicCentimetersPerSecond : Float -> VolumetricFlow
cubicCentimetersPerSecond numCubicCentietersPerSecond =
    cubicCentimetersPerSecond (numCubicCentietersPerSecond * 1.0e-2)


{-| Convert a volumetric flow to a number of cubic centimeters per second.
-}
inCubicCentimetersPerSecond : VolumetricFlow -> Float
inCubicCentimetersPerSecond volumetricFlow =
    inCubicMetersPerSecond volumetricFlow / 1.0e-3


{-| Construct a volumetric flow from a number of cubic feet per second.
-}
cubicFeetPerSecond : Float -> VolumetricFlow
cubicFeetPerSecond numCubicFeetPerSecond =
    cubicMetersPerSecond (Constants.cubicFoot * numCubicFeetPerSecond)


{-| Convert a volumetric flow to a number of cubic feet per second.
-}
inCubicFeetPerSecond : VolumetricFlow -> Float
inCubicFeetPerSecond volumetricFlow =
    inCubicMetersPerSecond volumetricFlow / Constants.cubicFoot


{-| Construct a volumetric flow from a number of Imperial gallons per minute.
-}
imperialGallonsPerMinute : Float -> VolumetricFlow
imperialGallonsPerMinute numImperialGallonsPerMinute =
    cubicMetersPerSecond (Constants.imperialGallon * numImperialGallonsPerMinute * 60)


{-| Convert a volumetric flow to a number of Imperial gallons per minute.
-}
inImperialGallonsPerMinute : VolumetricFlow -> Float
inImperialGallonsPerMinute volumetricFlow =
    inCubicMetersPerSecond volumetricFlow / Constants.imperialGallon / 60


{-| Construct a volumetric flow from a number of US liquid gallons per minute.
-}
usLiquidGallonsPerMinute : Float -> VolumetricFlow
usLiquidGallonsPerMinute numUsLiquidGallonsPerMinute =
    cubicMetersPerSecond
        (numUsLiquidGallonsPerMinute * oneUsLiquidGallonPerMinute)


{-| Convert a volumetric flow to a number of US liquid gallons per minute.
-}
inUsLiquidGallonsPerMinute : VolumetricFlow -> Float
inUsLiquidGallonsPerMinute volumetricFlow =
    inCubicMetersPerSecond volumetricFlow / oneUsLiquidGallonPerMinute


{-| Construct a volumetric flow from a number of US dry gallons per minute.
-}
usDryGallonsPerMinute : Float -> VolumetricFlow
usDryGallonsPerMinute numUsDryGallonsPerMinute =
    cubicMetersPerSecond (Constants.usDryGallon * numUsDryGallonsPerMinute * 60)


{-| Convert a volumetric flow to a number of US dry gallons per minute.
-}
inUsDryGallonsPerMinute : VolumetricFlow -> Float
inUsDryGallonsPerMinute volumetricFlow =
    inCubicMetersPerSecond volumetricFlow / Constants.usDryGallon / 60
