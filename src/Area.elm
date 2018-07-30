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
        , inSquareYards
        , squareCentimeters
        , squareFeet
        , squareInches
        , squareKilometers
        , squareMeters
        , squareMiles
        , squareMillimeters
        , squareYards
        )

import Length exposing (Meters)
import Quantity exposing (Quantity(..), Squared)


type alias Area =
    Quantity (Squared Meters)


squareMeters : Float -> Area
squareMeters numSquareMeters =
    Quantity numSquareMeters


inSquareMeters : Area -> Float
inSquareMeters (Quantity numSquareMeters) =
    numSquareMeters


squareMillimeters : Float -> Area
squareMillimeters numSquareMillimeters =
    squareMeters (1.0e-6 * numSquareMillimeters)


inSquareMillimeters : Area -> Float
inSquareMillimeters area =
    1.0e6 * inSquareMeters area


squareInches : Float -> Area
squareInches numSquareInches =
    squareMeters (0.0254 * 0.0254 * numSquareInches)


inSquareInches : Area -> Float
inSquareInches area =
    inSquareMeters area / (0.0254 * 0.0254)


squareCentimeters : Float -> Area
squareCentimeters numSquareCentimeters =
    squareMeters (1.0e-4 * numSquareCentimeters)


inSquareCentimeters : Area -> Float
inSquareCentimeters area =
    1.0e4 * inSquareMeters area


squareFeet : Float -> Area
squareFeet numSquareFeet =
    squareMeters (0.3048 * 0.3048 * numSquareFeet)


inSquareFeet : Area -> Float
inSquareFeet area =
    inSquareMeters area / (0.3048 * 0.3048)


squareYards : Float -> Area
squareYards numSquareYards =
    squareMeters (0.9144 * 0.9144 * numSquareYards)


inSquareYards : Area -> Float
inSquareYards area =
    inSquareMeters area / (0.9144 * 0.9144)


hectares : Float -> Area
hectares numHectares =
    squareMeters (1.0e4 * numHectares)


inHectares : Area -> Float
inHectares area =
    1.0e-4 * inSquareMeters area


squareKilometers : Float -> Area
squareKilometers numSquareKilometers =
    squareMeters (1.0e6 * numSquareKilometers)


inSquareKilometers : Area -> Float
inSquareKilometers area =
    1.0e-6 * inSquareMeters area


acres : Float -> Area
acres numAcres =
    squareMeters (4046.8564224 * numAcres)


inAcres : Area -> Float
inAcres area =
    inSquareMeters area / 4046.8564224


squareMiles : Float -> Area
squareMiles numSquareMiles =
    squareMeters (1609.344 * 1609.344 * numSquareMiles)


inSquareMiles : Area -> Float
inSquareMiles area =
    inSquareMeters area / (1609.344 * 1609.344)
