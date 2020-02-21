module Volume exposing
    ( Volume, CubicMeters
    , cubicMeters, inCubicMeters
    , milliliters, inMilliliters, liters, inLiters
    , cubicInches, inCubicInches, cubicFeet, inCubicFeet, cubicYards, inCubicYards
    , usLiquidGallons, inUsLiquidGallons, usDryGallons, inUsDryGallons, imperialGallons, inImperialGallons
    , usLiquidQuarts, inUsLiquidQuarts, usDryQuarts, inUsDryQuarts, imperialQuarts, inImperialQuarts
    , usLiquidPints, inUsLiquidPints, usDryPints, inUsDryPints, imperialPints, inImperialPints
    , usFluidOunces, inUsFluidOunces, imperialFluidOunces, inImperialFluidOunces
    , cubicMeter, milliliter, liter
    , cubicInch, cubicFoot, cubicYard
    , usLiquidGallon, usDryGallon, imperialGallon
    , usLiquidQuart, usDryQuart, imperialQuart
    , usLiquidPint, usDryPint, imperialPint
    , usFluidOunce, imperialFluidOunce
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


## Constants

Shorthand for `Volume.cubicMeters 1`, `Volume.imperialGallons 1` etc. Can be
convenient to use with [`Quantity.per`](Quantity#per).

@docs cubicMeter, milliliter, liter
@docs cubicInch, cubicFoot, cubicYard
@docs usLiquidGallon, usDryGallon, imperialGallon
@docs usLiquidQuart, usDryQuart, imperialQuart
@docs usLiquidPint, usDryPint, imperialPint
@docs usFluidOunce, imperialFluidOunce

-}

import Constants
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
    cubicMeters (Constants.cubicInch * numCubicInches)


{-| Convert a volume to a number of cubic inches.
-}
inCubicInches : Volume -> Float
inCubicInches volume =
    inCubicMeters volume / Constants.cubicInch


{-| Construct a volume from a number of cubic feet.
-}
cubicFeet : Float -> Volume
cubicFeet numCubicFeet =
    cubicMeters (Constants.cubicFoot * numCubicFeet)


{-| Convert a volume to a number of cubic feet.
-}
inCubicFeet : Volume -> Float
inCubicFeet volume =
    inCubicMeters volume / Constants.cubicFoot


{-| Construct a volume from a number of cubic yards.
-}
cubicYards : Float -> Volume
cubicYards numCubicYards =
    cubicMeters (Constants.cubicYard * numCubicYards)


{-| Convert a volume to a number of cubic yards.
-}
inCubicYards : Volume -> Float
inCubicYards volume =
    inCubicMeters volume / Constants.cubicYard


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
    cubicMeters (numUsLiquidGallons * Constants.usLiquidGallon)


{-| Convert a volume to a number of U.S. liquid gallons.
-}
inUsLiquidGallons : Volume -> Float
inUsLiquidGallons volume =
    inCubicMeters volume / Constants.usLiquidGallon


{-| Construct a volume from a number of U.S. dry gallons.
-}
usDryGallons : Float -> Volume
usDryGallons numUsDryGallons =
    cubicMeters (numUsDryGallons * Constants.usDryGallon)


{-| Convert a volume to a number of U.S. dry gallons.
-}
inUsDryGallons : Volume -> Float
inUsDryGallons volume =
    inCubicMeters volume / Constants.usDryGallon


{-| Construct a volume from a number of imperial gallons.
-}
imperialGallons : Float -> Volume
imperialGallons numImperialGallons =
    cubicMeters (numImperialGallons * Constants.imperialGallon)


{-| Convert a volume to a number of imperial gallons.
-}
inImperialGallons : Volume -> Float
inImperialGallons volume =
    inCubicMeters volume / Constants.imperialGallon


{-| Construct a volume from a number of U.S. liquid quarts.
-}
usLiquidQuarts : Float -> Volume
usLiquidQuarts numUsLiquidQuarts =
    cubicMeters (numUsLiquidQuarts * Constants.usLiquidQuart)


{-| Convert a volume to a number of U.S. liquid quarts.
-}
inUsLiquidQuarts : Volume -> Float
inUsLiquidQuarts volume =
    inCubicMeters volume / Constants.usLiquidQuart


{-| Construct a volume from a number of U.S. dry quarts.
-}
usDryQuarts : Float -> Volume
usDryQuarts numUsDryQuarts =
    cubicMeters (numUsDryQuarts * Constants.usDryQuart)


{-| Convert a volume to a number of U.S. dry quarts.
-}
inUsDryQuarts : Volume -> Float
inUsDryQuarts volume =
    inCubicMeters volume / Constants.usDryQuart


{-| Construct a volume from a number of imperial quarts.
-}
imperialQuarts : Float -> Volume
imperialQuarts numImperialQuarts =
    cubicMeters (numImperialQuarts * Constants.imperialQuart)


{-| Convert a volume to a number of imperial quarts.
-}
inImperialQuarts : Volume -> Float
inImperialQuarts volume =
    inCubicMeters volume / Constants.imperialQuart


{-| Construct a volume from a number of U.S. liquid pints.
-}
usLiquidPints : Float -> Volume
usLiquidPints numUsLiquidPints =
    cubicMeters (numUsLiquidPints * Constants.usLiquidPint)


{-| Convert a volume to a number of U.S. liquid pints.
-}
inUsLiquidPints : Volume -> Float
inUsLiquidPints volume =
    inCubicMeters volume / Constants.usLiquidPint


{-| Construct a volume from a number of U.S. dry pints.
-}
usDryPints : Float -> Volume
usDryPints numUsDryPints =
    cubicMeters (numUsDryPints * Constants.usDryPint)


{-| Convert a volume to a number of U.S. dry pints.
-}
inUsDryPints : Volume -> Float
inUsDryPints volume =
    inCubicMeters volume / Constants.usDryPint


{-| Construct a volume from a number of imperial pints.
-}
imperialPints : Float -> Volume
imperialPints numImperialPints =
    cubicMeters (numImperialPints * Constants.imperialPint)


{-| Convert a volume to a number of imperial pints.
-}
inImperialPints : Volume -> Float
inImperialPints volume =
    inCubicMeters volume / Constants.imperialPint


{-| Construct a volume from a number of U.S. fluid ounces.
-}
usFluidOunces : Float -> Volume
usFluidOunces numUsFluidOunces =
    cubicMeters (numUsFluidOunces * Constants.usFluidOunce)


{-| Convert a volume to a number of U.S. fluid ounces.
-}
inUsFluidOunces : Volume -> Float
inUsFluidOunces volume =
    inCubicMeters volume / Constants.usFluidOunce


{-| Construct a volume from a number of imperial fluid ounces.
-}
imperialFluidOunces : Float -> Volume
imperialFluidOunces numImperialFluidOunces =
    cubicMeters (numImperialFluidOunces * Constants.imperialFluidOunce)


{-| Convert a volume to a number of imperial fluid ounces.
-}
inImperialFluidOunces : Volume -> Float
inImperialFluidOunces volume =
    inCubicMeters volume / Constants.imperialFluidOunce


{-| -}
cubicMeter : Volume
cubicMeter =
    cubicMeters 1


{-| -}
milliliter : Volume
milliliter =
    milliliters 1


{-| -}
liter : Volume
liter =
    liters 1


{-| -}
cubicInch : Volume
cubicInch =
    cubicInches 1


{-| -}
cubicFoot : Volume
cubicFoot =
    cubicFeet 1


{-| -}
cubicYard : Volume
cubicYard =
    cubicYards 1


{-| -}
usLiquidGallon : Volume
usLiquidGallon =
    usLiquidGallons 1


{-| -}
usDryGallon : Volume
usDryGallon =
    usDryGallons 1


{-| -}
imperialGallon : Volume
imperialGallon =
    imperialGallons 1


{-| -}
usLiquidQuart : Volume
usLiquidQuart =
    usLiquidQuarts 1


{-| -}
usDryQuart : Volume
usDryQuart =
    usDryQuarts 1


{-| -}
imperialQuart : Volume
imperialQuart =
    imperialQuarts 1


{-| -}
usLiquidPint : Volume
usLiquidPint =
    usLiquidPints 1


{-| -}
usDryPint : Volume
usDryPint =
    usDryPints 1


{-| -}
imperialPint : Volume
imperialPint =
    imperialPints 1


{-| -}
usFluidOunce : Volume
usFluidOunce =
    usFluidOunces 1


{-| -}
imperialFluidOunce : Volume
imperialFluidOunce =
    imperialFluidOunces 1
