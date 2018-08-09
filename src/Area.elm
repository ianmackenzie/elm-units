module Area
    exposing
        ( Area
        , acres
        , convert
        , hectares
        , inAcres
        , inHectares
        , inSquareCentimeters
        , inSquareFeet
        , inSquareInches
        , inSquareKilometers
        , inSquareMeters
        , inSquareMiles
        , inSquareMillimeters
        , inSquarePixels
        , inSquareYards
        , squareCentimeters
        , squareFeet
        , squareInches
        , squareKilometers
        , squareMeters
        , squareMiles
        , squareMillimeters
        , squarePixels
        , squareYards
        )

import Length exposing (LengthUnits)
import Quantity exposing (Fractional, Quantity(..), Squared)
import Spaces exposing (ScreenSpace, WorldSpace)


{-| The area units for a particular space are the squared length units for that
space.
-}
type alias AreaUnits space =
    Squared (LengthUnits space)


{-| A generic 'area' in a particular space is a fractional number of area units
in that space.
-}
type alias Area space =
    Fractional (AreaUnits space)


squarePixels : number -> Quantity number (AreaUnits ScreenSpace)
squarePixels numSquarePixels =
    Quantity numSquarePixels


inSquarePixels : Quantity number (AreaUnits ScreenSpace) -> number
inSquarePixels (Quantity numSquarePixels) =
    numSquarePixels


squareMeters : Float -> Area WorldSpace
squareMeters numSquareMeters =
    Quantity numSquareMeters


inSquareMeters : Area WorldSpace -> Float
inSquareMeters (Quantity numSquareMeters) =
    numSquareMeters


squareMillimeters : Float -> Area WorldSpace
squareMillimeters numSquareMillimeters =
    squareMeters (1.0e-6 * numSquareMillimeters)


inSquareMillimeters : Area WorldSpace -> Float
inSquareMillimeters area =
    1.0e6 * inSquareMeters area


squareInches : Float -> Area WorldSpace
squareInches numSquareInches =
    squareMeters (0.0254 * 0.0254 * numSquareInches)


inSquareInches : Area WorldSpace -> Float
inSquareInches area =
    inSquareMeters area / (0.0254 * 0.0254)


squareCentimeters : Float -> Area WorldSpace
squareCentimeters numSquareCentimeters =
    squareMeters (1.0e-4 * numSquareCentimeters)


inSquareCentimeters : Area WorldSpace -> Float
inSquareCentimeters area =
    1.0e4 * inSquareMeters area


squareFeet : Float -> Area WorldSpace
squareFeet numSquareFeet =
    squareMeters (0.3048 * 0.3048 * numSquareFeet)


inSquareFeet : Area WorldSpace -> Float
inSquareFeet area =
    inSquareMeters area / (0.3048 * 0.3048)


squareYards : Float -> Area WorldSpace
squareYards numSquareYards =
    squareMeters (0.9144 * 0.9144 * numSquareYards)


inSquareYards : Area WorldSpace -> Float
inSquareYards area =
    inSquareMeters area / (0.9144 * 0.9144)


hectares : Float -> Area WorldSpace
hectares numHectares =
    squareMeters (1.0e4 * numHectares)


inHectares : Area WorldSpace -> Float
inHectares area =
    1.0e-4 * inSquareMeters area


squareKilometers : Float -> Area WorldSpace
squareKilometers numSquareKilometers =
    squareMeters (1.0e6 * numSquareKilometers)


inSquareKilometers : Area WorldSpace -> Float
inSquareKilometers area =
    1.0e-6 * inSquareMeters area


acres : Float -> Area WorldSpace
acres numAcres =
    squareMeters (4046.8564224 * numAcres)


inAcres : Area WorldSpace -> Float
inAcres area =
    inSquareMeters area / 4046.8564224


squareMiles : Float -> Area WorldSpace
squareMiles numSquareMiles =
    squareMeters (1609.344 * 1609.344 * numSquareMiles)


inSquareMiles : Area WorldSpace -> Float
inSquareMiles area =
    inSquareMeters area / (1609.344 * 1609.344)


convert : Length.Conversion sourceSpace destinationSpace -> Area sourceSpace -> Area destinationSpace
convert (Quantity rate) (Quantity value) =
    Quantity (rate * rate * value)
