module Pressure exposing
    ( Pascals
    , Pressure
    , atmospheres
    , inAtmospheres
    , inKilopascals
    , inMegapascals
    , inPascals
    , inPoundsPerSquareInch
    , kilopascals
    , megapascals
    , pascals
    , poundsPerSquareInch
    )

import Area exposing (SquareMeters)
import Force exposing (Newtons)
import Quantity exposing (Fractional, Quantity(..), Quotient)


type alias Pascals =
    Quotient Newtons SquareMeters


type alias Pressure =
    Fractional Pascals


pascals : Float -> Pressure
pascals numPascals =
    Quantity numPascals


inPascals : Pressure -> Float
inPascals (Quantity numPascals) =
    numPascals


kilopascals : Float -> Pressure
kilopascals numKilopascals =
    pascals (1000 * numKilopascals)


inKilopascals : Pressure -> Float
inKilopascals pressure =
    inPascals pressure / 1000


megapascals : Float -> Pressure
megapascals numMegapascals =
    pascals (1.0e6 * numMegapascals)


inMegapascals : Pressure -> Float
inMegapascals pressure =
    inPascals pressure / 1.0e6


poundsPerSquareInch : Float -> Pressure
poundsPerSquareInch value =
    Force.pounds value |> Quantity.per (Area.squareInches 1)


inPoundsPerSquareInch : Pressure -> Float
inPoundsPerSquareInch pressure =
    pressure |> Quantity.times (Area.squareInches 1) |> Force.inPounds


atmospheres : Float -> Pressure
atmospheres numAtmospheres =
    pascals (101325 * numAtmospheres)


inAtmospheres : Pressure -> Float
inAtmospheres pressure =
    inPascals pressure / 101325
