module Area
    exposing
        ( Area
        , SquarePixels
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

import Length exposing (InWorld, LengthUnits, OnScreen)
import Quantity exposing (Fractional, Quantity(..), Squared, Whole)


{-| The area units for a particular space are the squared length units for that
space.
-}
type alias AreaUnits space =
    Squared (LengthUnits space)


type alias SquarePixels =
    AreaUnits OnScreen


{-| A generic 'area' in a particular space is a fractional number of area units
in that space.
-}
type alias Area space =
    Fractional (AreaUnits space)


squarePixels : number -> Quantity number (AreaUnits OnScreen)
squarePixels numSquarePixels =
    Quantity numSquarePixels


inSquarePixels : Quantity number (AreaUnits OnScreen) -> number
inSquarePixels (Quantity numSquarePixels) =
    numSquarePixels


roundToNearestSquarePixel : Fractional SquarePixels -> Whole SquarePixels
roundToNearestSquarePixel (Quantity numSquarePixels) =
    Quantity (round numSquarePixels)


squareMeters : Float -> Area InWorld
squareMeters numSquareMeters =
    Quantity numSquareMeters


inSquareMeters : Area InWorld -> Float
inSquareMeters (Quantity numSquareMeters) =
    numSquareMeters


squareMillimeters : Float -> Area InWorld
squareMillimeters numSquareMillimeters =
    squareMeters (1.0e-6 * numSquareMillimeters)


inSquareMillimeters : Area InWorld -> Float
inSquareMillimeters area =
    1.0e6 * inSquareMeters area


squareInches : Float -> Area InWorld
squareInches numSquareInches =
    squareMeters (0.0254 * 0.0254 * numSquareInches)


inSquareInches : Area InWorld -> Float
inSquareInches area =
    inSquareMeters area / (0.0254 * 0.0254)


squareCentimeters : Float -> Area InWorld
squareCentimeters numSquareCentimeters =
    squareMeters (1.0e-4 * numSquareCentimeters)


inSquareCentimeters : Area InWorld -> Float
inSquareCentimeters area =
    1.0e4 * inSquareMeters area


squareFeet : Float -> Area InWorld
squareFeet numSquareFeet =
    squareMeters (0.3048 * 0.3048 * numSquareFeet)


inSquareFeet : Area InWorld -> Float
inSquareFeet area =
    inSquareMeters area / (0.3048 * 0.3048)


squareYards : Float -> Area InWorld
squareYards numSquareYards =
    squareMeters (0.9144 * 0.9144 * numSquareYards)


inSquareYards : Area InWorld -> Float
inSquareYards area =
    inSquareMeters area / (0.9144 * 0.9144)


hectares : Float -> Area InWorld
hectares numHectares =
    squareMeters (1.0e4 * numHectares)


inHectares : Area InWorld -> Float
inHectares area =
    1.0e-4 * inSquareMeters area


squareKilometers : Float -> Area InWorld
squareKilometers numSquareKilometers =
    squareMeters (1.0e6 * numSquareKilometers)


inSquareKilometers : Area InWorld -> Float
inSquareKilometers area =
    1.0e-6 * inSquareMeters area


acres : Float -> Area InWorld
acres numAcres =
    squareMeters (4046.8564224 * numAcres)


inAcres : Area InWorld -> Float
inAcres area =
    inSquareMeters area / 4046.8564224


squareMiles : Float -> Area InWorld
squareMiles numSquareMiles =
    squareMeters (1609.344 * 1609.344 * numSquareMiles)


inSquareMiles : Area InWorld -> Float
inSquareMiles area =
    inSquareMeters area / (1609.344 * 1609.344)


convert : Length.Conversion sourceSpace destinationSpace -> Area sourceSpace -> Area destinationSpace
convert (Quantity rate) (Quantity value) =
    Quantity (rate * rate * value)
