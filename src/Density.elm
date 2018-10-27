module Density exposing
    ( Density, KilogramsPerCubicMeter
    --, units tbc 
    )

{-| A `Density` value represents a density in .... etc.
It is stored as a number of kilograms per cubic meter.

Note that since `KilogramsPerCubicMeter` is defined as `Rate Kilograms CubicMeters` (mass per
unit volume), you can construct a `Density` value using `Quantity.per`:

    density =
        mass |> Quantity.per volume

You can also do rate-related calculations with `Density` values to compute
`Mass` or `Volume`:

    mass =
        density |> Quantity.times volume

    alsoMass =
        volume |> Quantity.at density

    volume =
        mass |> Quantity.at_ density

[1]: https://en.wikipedia.org/wiki/Density

@docs Density, KilogramsPerCubicMeter

@docs TODO

-}

import Volume exposing (CubicMeters)
import Mass exposing (Kilograms)
import Quantity exposing (Quantity(..), Rate)


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
