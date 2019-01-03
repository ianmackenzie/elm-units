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

{-| A `Volume` represents a volume in cubic meters, cubic feet, liters, US
liquid gallons, imperial fluid ounces etc. It is stored as a number of cubic
meters.

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



---------- CONVERSION FACTOR CONSTANTS  -----------


{-| The number of US liquid gallons in a cubic meter.
-}
usLiquidGallonsPerCubicMeter : Float
usLiquidGallonsPerCubicMeter =
    264.17205235814845


{-| The number of US dry gallons in a cubic meter.
-}
usDryGallonsPerCubicMeter : Float
usDryGallonsPerCubicMeter =
    227.02074606721396


{-| The number of imperial gallons in a cubic meter.
-}
imperialGallonsPerCubicMeter : Float
imperialGallonsPerCubicMeter =
    219.96924829908778



---------- CONVERSIONS -----------


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


{-| Construct a volume from a number of U.S. liquid gallon.
-}
usLiquidGallons : Float -> Volume
usLiquidGallons numUsLiquidGallons =
    cubicMeters (numUsLiquidGallons / usLiquidGallonsPerCubicMeter)


{-| Convert a volume to a number of U.S. liquid gallons.
-}
inUsLiquidGallons : Volume -> Float
inUsLiquidGallons volume =
    usLiquidGallonsPerCubicMeter * inCubicMeters volume


{-| Construct a volume from a number of U.S. dry gallons.
-}
usDryGallons : Float -> Volume
usDryGallons numUsDryGallons =
    cubicMeters (numUsDryGallons / usDryGallonsPerCubicMeter)


{-| Convert a volume to a number of U.S. dry gallons.
-}
inUsDryGallons : Volume -> Float
inUsDryGallons volume =
    usDryGallonsPerCubicMeter * inCubicMeters volume


{-| Construct a volume from a number of imperial gallons.
-}
imperialGallons : Float -> Volume
imperialGallons numImperialGallons =
    cubicMeters (numImperialGallons / imperialGallonsPerCubicMeter)


{-| Convert a volume to a number of imperial gallons.
-}
inImperialGallons : Volume -> Float
inImperialGallons volume =
    imperialGallonsPerCubicMeter * inCubicMeters volume


{-| Construct a volume from a number of U.S. liquid quarts.
-}
usLiquidQuarts : Float -> Volume
usLiquidQuarts numUsLiquidQuarts =
    cubicMeters ((numUsLiquidQuarts / 4) / usLiquidGallonsPerCubicMeter)


{-| Convert a volume to a number of U.S. liquid quarts.
-}
inUsLiquidQuarts : Volume -> Float
inUsLiquidQuarts volume =
    4 * usLiquidGallonsPerCubicMeter * inCubicMeters volume


{-| Construct a volume from a number of U.S. dry quarts.
-}
usDryQuarts : Float -> Volume
usDryQuarts numUsDryQuarts =
    cubicMeters ((numUsDryQuarts / 4) / usDryGallonsPerCubicMeter)


{-| Convert a volume to a number of U.S. dry quarts.
-}
inUsDryQuarts : Volume -> Float
inUsDryQuarts volume =
    4 * usDryGallonsPerCubicMeter * inCubicMeters volume


{-| Construct a volume from a number of imperial quarts.
-}
imperialQuarts : Float -> Volume
imperialQuarts numImperialQuarts =
    cubicMeters ((numImperialQuarts / 4) / imperialGallonsPerCubicMeter)


{-| Convert a volume to a number of imperial quarts.
-}
inImperialQuarts : Volume -> Float
inImperialQuarts volume =
    4 * imperialGallonsPerCubicMeter * inCubicMeters volume


{-| Construct a volume from a number of U.S. liquid pints.
-}
usLiquidPints : Float -> Volume
usLiquidPints numUsLiquidPints =
    cubicMeters ((numUsLiquidPints / 8) / usLiquidGallonsPerCubicMeter)


{-| Convert a volume to a number of U.S. liquid pints.
-}
inUsLiquidPints : Volume -> Float
inUsLiquidPints volume =
    8 * usLiquidGallonsPerCubicMeter * inCubicMeters volume


{-| Construct a volume from a number of U.S. dry pints.
-}
usDryPints : Float -> Volume
usDryPints numUsDryPints =
    cubicMeters ((numUsDryPints / 8) / usDryGallonsPerCubicMeter)


{-| Convert a volume to a number of U.S. dry pints.
-}
inUsDryPints : Volume -> Float
inUsDryPints volume =
    8 * usDryGallonsPerCubicMeter * inCubicMeters volume


{-| Construct a volume from a number of imperial pints.
-}
imperialPints : Float -> Volume
imperialPints numImperialPints =
    cubicMeters ((numImperialPints / 8) / imperialGallonsPerCubicMeter)


{-| Convert a volume to a number of imperial pints.
-}
inImperialPints : Volume -> Float
inImperialPints volume =
    8 * imperialGallonsPerCubicMeter * inCubicMeters volume


{-| Construct a volume from a number of U.S. fluid ounces.
-}
usFluidOunces : Float -> Volume
usFluidOunces numUsFluidOunces =
    cubicMeters ((numUsFluidOunces / 128) / usLiquidGallonsPerCubicMeter)


{-| Convert a volume to a number of U.S. fluid ounces.
-}
inUsFluidOunces : Volume -> Float
inUsFluidOunces volume =
    128 * usLiquidGallonsPerCubicMeter * inCubicMeters volume


{-| Construct a volume from a number of imperial fluid ounces.
-}
imperialFluidOunces : Float -> Volume
imperialFluidOunces numImperialFluidOunces =
    cubicMeters ((numImperialFluidOunces / 160) / imperialGallonsPerCubicMeter)


{-| Convert a volume to a number of imperial fluid ounces.
-}
inImperialFluidOunces : Volume -> Float
inImperialFluidOunces volume =
    160 * imperialGallonsPerCubicMeter * inCubicMeters volume
