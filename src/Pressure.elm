module Pressure exposing
    ( Pressure, Pascals
    , pascals, inPascals, kilopascals, inKilopascals, megapascals, inMegapascals
    , poundsPerSquareInch, inPoundsPerSquareInch
    , atmospheres, inAtmospheres
    )

{-| A `Pressure` value represents a pressure in kilopascals, pounds per square
inch, [atmospheres][1] etc. It is stored as a number of pascals.

Note that since `Pascals` is defined as `Rate Newtons SquareMeters` (force per
unit area), you can construct a `Pressure` value using `Quantity.per`:

    pressure =
        force |> Quantity.per area

You can also do rate-related calculations with `Pressure` values to compute
`Force` or `Area`:

    force =
        area |> Quantity.at pressure

    area =
        force |> Quantity.at_ pressure

[1]: https://en.wikipedia.org/wiki/Atmosphere_(unit)

@docs Pressure, Pascals


## Metric

@docs pascals, inPascals, kilopascals, inKilopascals, megapascals, inMegapascals


## Imperial

@docs poundsPerSquareInch, inPoundsPerSquareInch


## Atmospheric

@docs atmospheres, inAtmospheres

-}

import Area exposing (SquareMeters)
import Force exposing (Newtons)
import Quantity exposing (Quantity(..), Rate)


{-| -}
type alias Pascals =
    Rate Newtons SquareMeters


{-| -}
type alias Pressure =
    Quantity Float Pascals


{-| Construct a pressure from a number of pascals.
-}
pascals : Float -> Pressure
pascals numPascals =
    Quantity numPascals


{-| Convert a pressure to a number of pascals.
-}
inPascals : Pressure -> Float
inPascals (Quantity numPascals) =
    numPascals


{-| Construct a pressure from a number of kilopascals.
-}
kilopascals : Float -> Pressure
kilopascals numKilopascals =
    pascals (1000 * numKilopascals)


{-| Convert a pressure to a number of kilopascals.
-}
inKilopascals : Pressure -> Float
inKilopascals pressure =
    inPascals pressure / 1000


{-| Construct a pressure from a number of megapascals.
-}
megapascals : Float -> Pressure
megapascals numMegapascals =
    pascals (1.0e6 * numMegapascals)


{-| Convert a pressure to a number of megapascals.
-}
inMegapascals : Pressure -> Float
inMegapascals pressure =
    inPascals pressure / 1.0e6


{-| Construct a pressure from a number of pounds per square inch.
-}
poundsPerSquareInch : Float -> Pressure
poundsPerSquareInch value =
    Force.pounds value |> Quantity.per (Area.squareInches 1)


{-| Convert a pressure to a number of pounds per square inch.
-}
inPoundsPerSquareInch : Pressure -> Float
inPoundsPerSquareInch pressure =
    Area.squareInches 1 |> Quantity.at pressure |> Force.inPounds


{-| Construct a pressure from a number of [atmospheres][1].

[1]: https://en.wikipedia.org/wiki/Atmosphere_(unit)

-}
atmospheres : Float -> Pressure
atmospheres numAtmospheres =
    pascals (101325 * numAtmospheres)


{-| Convert a pressure to a number of atmospheres.
-}
inAtmospheres : Pressure -> Float
inAtmospheres pressure =
    inPascals pressure / 101325
