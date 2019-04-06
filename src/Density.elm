module Density exposing
    ( Density, KilogramsPerCubicMeter
    , kilogramsPerCubicMeter, inKilogramsPerCubicMeter, gramsPerCubicCentimeter, inGramsPerCubicCentimeter
    , poundsPerCubicInch, inPoundsPerCubicInch, poundsPerCubicFoot, inPoundsPerCubicFoot
    )

{-| A `Density` value represents a density in grams per cubic centimeter, pounds
per cubic inch, etc. It is stored as a number of kilograms per cubic meter.

Note that since `KilogramsPerCubicMeter` is defined as `Rate Kilograms
CubicMeters` (mass per unit volume), you can construct a `Density` value using
`Quantity.per`:

    density =
        mass |> Quantity.per volume

You can also do rate-related calculations with `Density` values to compute
`Mass` or `Volume`:

    mass =
        volume |> Quantity.at density

    volume =
        mass |> Quantity.at_ density

@docs Density, KilogramsPerCubicMeter


## Metric

@docs kilogramsPerCubicMeter, inKilogramsPerCubicMeter, gramsPerCubicCentimeter, inGramsPerCubicCentimeter


## Imperial

@docs poundsPerCubicInch, inPoundsPerCubicInch, poundsPerCubicFoot, inPoundsPerCubicFoot

-}

import Constants
import Mass exposing (Kilograms)
import Quantity exposing (Quantity(..), Rate)
import Volume exposing (CubicMeters)


{-| -}
type alias KilogramsPerCubicMeter =
    Rate Kilograms CubicMeters


{-| -}
type alias Density =
    Quantity Float KilogramsPerCubicMeter


{-| Construct a density from a number of kilograms per cubic meter.
-}
kilogramsPerCubicMeter : Float -> Density
kilogramsPerCubicMeter numKilogramsPerCubicMeter =
    Quantity numKilogramsPerCubicMeter


{-| Convert a density to a number of kilograms per cubic meter.
-}
inKilogramsPerCubicMeter : Density -> Float
inKilogramsPerCubicMeter (Quantity numKilogramsPerCubicMeter) =
    numKilogramsPerCubicMeter


{-| Construct a density from a number of grams per cubic centimeter.
-}
gramsPerCubicCentimeter : Float -> Density
gramsPerCubicCentimeter numGramsPerCubicCentimeter =
    kilogramsPerCubicMeter (1000 * numGramsPerCubicCentimeter)


{-| Convert a density to a number of grams per cubic centimeter.
-}
inGramsPerCubicCentimeter : Density -> Float
inGramsPerCubicCentimeter density =
    inKilogramsPerCubicMeter density / 1000


{-| Construct a density from a number of pounds per cubic inch.
-}
poundsPerCubicInch : Float -> Density
poundsPerCubicInch numPoundsPerCubicInch =
    kilogramsPerCubicMeter (Constants.pound / Constants.cubicInch * numPoundsPerCubicInch)


{-| Convert a density to a number of pounds per cubic inch.
-}
inPoundsPerCubicInch : Density -> Float
inPoundsPerCubicInch density =
    inKilogramsPerCubicMeter density / (Constants.pound / Constants.cubicInch)


{-| Construct a density from a number of pounds per cubic foot.
-}
poundsPerCubicFoot : Float -> Density
poundsPerCubicFoot numPoundsPerCubicFoot =
    kilogramsPerCubicMeter (Constants.pound / Constants.cubicFoot * numPoundsPerCubicFoot)


{-| Convert a density to a number of pounds per cubic foot.
-}
inPoundsPerCubicFoot : Density -> Float
inPoundsPerCubicFoot density =
    inKilogramsPerCubicMeter density / (Constants.pound / Constants.cubicFoot)
