module Volume exposing
    ( Volume, CubicMeters
    , cubicMeters, inCubicMeters
    , cubicMillimeters, inCubicMillimeters, cubicCentimeters, inCubicCentimeters
    , cubicInches, inCubicInches, cubicFeet, inCubicFeet, cubicYards, inCubicYards
    --, milliliter, liter, deciliter
    --, usLiquidGallons, usDryGallons, imperialGallons
    --, usLiquidQuarts, usDryQuarts, imperialQuarts
    --, usLiquidPints, usDryPints, imperialPints
    --, usFluidOunces, imperialFluidOunces
    )

{-| A `Volume` represents a volume in cubic meters, cubic feet, liters,
US liquid gallons, imperial fluid ounces etc. It is stored as a number of cubic meters.

@docs Volume, CubicMeters


## Metric

@docs cubicMeters, inCubicMeters
@docs cubicMillimeters, inCubicMillimeters, cubicCentimeters, inCubicCentimeters
@docs --@docs milliliters, inMilliliters, liters, etc


## Imperial

@docs cubicInches, inCubicInches, cubicFeet, inCubicFeet, cubicYards, inCubicYards
@docs --@docs usLiquidGallons, usDryGallons, imperialGallons
@docs --@docs usLiquidQuarts, usDryQuarts, imperialQuarts
@docs --@docs usLiquidPints, usDryPints, imperialPints
@docs --@docs usFluidOunces, imperialFluidOunces

-}

import Length exposing (Meters)
import Quantity exposing (Quantity(..))


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


{-| Construct a volume from a number of cubic millimeters.
-}
cubicMillimeters : Float -> Volume
cubicMillimeters numCubicMillimeters =
    cubicMeters (1.0e-9 * numCubicMillimeters)


{-| Convert a volume to a number of cubic millimeters.
-}
inCubicMillimeters : Volume -> Float
inCubicMillimeters volume =
    1.0e9 * inCubicMeters volume


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


{-| Construct a volume from a number of cubic centimeters.
-}
cubicCentimeters : Float -> Volume
cubicCentimeters numCubicCentimeters =
    cubicMeters (1.0e-6 * numCubicCentimeters)


{-| Convert a volume to a number of cubic centimeters.
-}
inCubicCentimeters : Volume -> Float
inCubicCentimeters volume =
    1.0e6 * inCubicMeters volume


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
