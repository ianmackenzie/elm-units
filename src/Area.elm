module Area
    exposing
        ( Area
        , acres
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

import Quantity exposing (Quantity(..), ScreenSpace, WorldSpace)


type alias Area space =
    Quantity.Area space


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


squarePixels : Float -> Area ScreenSpace
squarePixels numSquarePixels =
    Quantity numSquarePixels


inSquarePixels : Area ScreenSpace -> Float
inSquarePixels (Quantity numSquarePixels) =
    numSquarePixels
