module Volume exposing
    ( Volume, CubicMeters
    , cubicMeters, inCubicMeters
    , milliliters, inMilliliters, liters, inLiters
    , cubicInches, inCubicInches, cubicFeet, inCubicFeet, cubicYards, inCubicYards
    , usLiquidGallons, inUsLiquidGallons, usDryGallons, inUsDryGallons, imperialGallons, inImperialGallons
    , usLiquidQuarts, inUsLiquidQuarts, usDryQuarts, inUsDryQuarts, imperialQuarts, inImperialQuarts
    , usLiquidPints, inUsLiquidPints, usDryPints, inUsDryPints, imperialPints, inImperialPints
    , usFluidOunces, inUsFluidOunces, imperialFluidOunces, inImperialFluidOunces
    )

{-| A `Volume` represents a volume in cubic meters, cubic feet, liters,
US liquid gallons, imperial fluid ounces etc. It is stored as a number of cubic meters.

@docs Volume, CubicMeters


## Metric

@docs cubicMeters, inCubicMeters
@docs milliliters, inMilliliters, liters, inLiters


## Imperial

@docs cubicInches, inCubicInches, cubicFeet, inCubicFeet, cubicYards, inCubicYards
@docs usLiquidGallons, inUsLiquidGallons, usDryGallons, inUsDryGallons, imperialGallons, inImperialGallons
@docs usLiquidQuarts, inUsLiquidQuarts, usDryQuarts, inUsDryQuarts, imperialQuarts, inImperialQuarts
@docs usLiquidPints, inUsLiquidPints, usDryPints, inUsDryPints, imperialPints, inImperialPints
@docs usFluidOunces, inUsFluidOunces, imperialFluidOunces, inImperialFluidOunces

-}

import Length exposing (Meters)
import Quantity exposing (Cubed, Quantity(..))


{-| -}
type alias CubicMeters =
    Cubed Meters


{-| -}
type alias Volume =
    Quantity Float CubicMeters


{-| Construct a volume from a number of cubic meters.
-}
cubicMeters : Float -> Volume
cubicMeters numCubicMeters =
    Quantity numCubicMeters


{-| Convert a volume to a number of cubic meters.
-}
inCubicMeters : Volume -> Float
inCubicMeters (Quantity numCubicMeters) =
    numCubicMeters


{-| Construct a volume from a number of cubic inches.
-}
cubicInches : Float -> Volume
cubicInches numCubicInches =
    cubicMeters (0.0254 * 0.0254 * 0.0254 * numCubicInches)


{-| Convert a volume to a number of cubic inches.
-}
inCubicInches : Volume -> Float
inCubicInches volume =
    inCubicMeters volume / (0.0254 * 0.0254 * 0.0254)


{-| Construct a volume from a number of cubic feet.
-}
cubicFeet : Float -> Volume
cubicFeet numCubicFeet =
    cubicMeters (0.3048 * 0.3048 * 0.3048 * numCubicFeet)


{-| Convert a volume to a number of cubic feet.
-}
inCubicFeet : Volume -> Float
inCubicFeet volume =
    inCubicMeters volume / (0.3048 * 0.3048 * 0.3048)


{-| Construct a volume from a number of cubic yards.
-}
cubicYards : Float -> Volume
cubicYards numCubicYards =
    cubicMeters (0.9144 * 0.9144 * 0.9144 * numCubicYards)


{-| Convert a volume to a number of cubic yards.
-}
inCubicYards : Volume -> Float
inCubicYards volume =
    inCubicMeters volume / (0.9144 * 0.9144 * 0.9144)


{-| Construct a volume from a number of milliliters.
-}
milliliters : Float -> Volume
milliliters numMilliliters =
    cubicMeters (1.0e-6 * numMilliliters)


{-| Convert a volume to a number of milliliters.
-}
inMilliliters : Volume -> Float
inMilliliters volume =
    1.0e6 * inCubicMeters volume


{-| Construct a volume from a number of liters.
-}
liters : Float -> Volume
liters numLiters =
    cubicMeters (0.001 * numLiters)


{-| Convert a volume to a number of liters.
-}
inLiters : Volume -> Float
inLiters volume =
    1000 * inCubicMeters volume


{-| Construct a volume from a number of usLiquidGallons.
-}
usLiquidGallons : Float -> Volume
usLiquidGallons numUsLiquidGallons =
    cubicMeters (numUsLiquidGallons / 264.17220000000003)


{-| Convert a volume to a number of usLiquidGallons.
-}
inUsLiquidGallons : Volume -> Float
inUsLiquidGallons volume =
    264.17220000000003 * inCubicMeters volume


{-| Construct a volume from a number of usDryGallons.
-}
usDryGallons : Float -> Volume
usDryGallons numUsDryGallons =
    cubicMeters (numUsDryGallons / 227.0208)


{-| Convert a volume to a number of usDryGallons.
-}
inUsDryGallons : Volume -> Float
inUsDryGallons volume =
    227.0208 * inCubicMeters volume


{-| Construct a volume from a number of imperialGallons.
-}
imperialGallons : Float -> Volume
imperialGallons numImperialGallons =
    cubicMeters (numImperialGallons / 219.969157)


{-| Convert a volume to a number of imperialGallons.
-}
inImperialGallons : Volume -> Float
inImperialGallons volume =
    219.969157 * inCubicMeters volume


{-| Construct a volume from a number of usLiquidQuarts.
-}
usLiquidQuarts : Float -> Volume
usLiquidQuarts numUsLiquidQuarts =
    cubicMeters ((numUsLiquidQuarts / 4) / 264.17220000000003)


{-| Convert a volume to a number of usLiquidQuarts.
-}
inUsLiquidQuarts : Volume -> Float
inUsLiquidQuarts volume =
    4 * 264.17220000000003 * inCubicMeters volume


{-| Construct a volume from a number of usDryQuarts.
-}
usDryQuarts : Float -> Volume
usDryQuarts numUsDryQuarts =
    cubicMeters ((numUsDryQuarts / 4) / 227.0208)


{-| Convert a volume to a number of usDryQuarts.
-}
inUsDryQuarts : Volume -> Float
inUsDryQuarts volume =
    4 * 227.0208 * inCubicMeters volume


{-| Construct a volume from a number of imperialQuarts.
-}
imperialQuarts : Float -> Volume
imperialQuarts numImperialQuarts =
    cubicMeters ((numImperialQuarts / 4) / 219.969157)


{-| Convert a volume to a number of imperialQuarts.
-}
inImperialQuarts : Volume -> Float
inImperialQuarts volume =
    4 * 219.969157 * inCubicMeters volume


{-| Construct a volume from a number of usLiquidPints.
-}
usLiquidPints : Float -> Volume
usLiquidPints numUsLiquidPints =
    cubicMeters ((numUsLiquidPints / 8) / 264.17220000000003)


{-| Convert a volume to a number of usLiquidPints.
-}
inUsLiquidPints : Volume -> Float
inUsLiquidPints volume =
    8 * 264.17220000000003 * inCubicMeters volume


{-| Construct a volume from a number of usDryPints.
-}
usDryPints : Float -> Volume
usDryPints numUsDryPints =
    cubicMeters ((numUsDryPints / 8) / 227.0208)


{-| Convert a volume to a number of usDryPints.
-}
inUsDryPints : Volume -> Float
inUsDryPints volume =
    8 * 227.0208 * inCubicMeters volume


{-| Construct a volume from a number of imperialPints.
-}
imperialPints : Float -> Volume
imperialPints numImperialPints =
    cubicMeters ((numImperialPints / 8) / 219.969157)


{-| Convert a volume to a number of imperialPints.
-}
inImperialPints : Volume -> Float
inImperialPints volume =
    8 * 219.969157 * inCubicMeters volume


{-| Construct a volume from a number of usFluidOunces.
-}
usFluidOunces : Float -> Volume
usFluidOunces numUsFluidOunces =
    cubicMeters ((numUsFluidOunces / 128) / 264.17220000000003)


{-| Convert a volume to a number of usFluidOunces.
-}
inUsFluidOunces : Volume -> Float
inUsFluidOunces volume =
    128 * 264.17220000000003 * inCubicMeters volume


{-| Construct a volume from a number of imperialFluidOunces.
-}
imperialFluidOunces : Float -> Volume
imperialFluidOunces numImperialFluidOunces =
    cubicMeters ((numImperialFluidOunces / 160) / 219.969157)


{-| Convert a volume to a number of imperialFluidOunces.
-}
inImperialFluidOunces : Volume -> Float
inImperialFluidOunces volume =
    160 * 219.969157 * inCubicMeters volume
