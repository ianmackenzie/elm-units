module Area exposing
    ( Area, SquareMeters
    , squareMeters, inSquareMeters
    , squareMillimeters, inSquareMillimeters, squareCentimeters, inSquareCentimeters, hectares, inHectares, squareKilometers, inSquareKilometers
    , squareInches, inSquareInches, squareFeet, inSquareFeet, squareYards, inSquareYards, acres, inAcres, squareMiles, inSquareMiles
    , squareMeter, squareMillimeter, squareCentimeter, hectare, squareKilometer
    , squareInch, squareFoot, squareYard, acre, squareMile
    )

{-| An `Area` represents an area in square meters, square feet, acres, hectares
etc. It is stored as a number of square meters.

Note that you can construct an `Area` value directly using the functions in this
module, but it also works to call [`Quantity.squared`](Quantity#squared) on a
`Length` or [`Quantity.times`](Quantity#times) on a pair of `Length`s. The
following are all equivalent:

    Area.squareFeet 100

    Quantity.squared (Length.feet 10)

    Length.feet 25 |> Quantity.times (Length.feet 4)

@docs Area, SquareMeters


## Metric

@docs squareMeters, inSquareMeters
@docs squareMillimeters, inSquareMillimeters, squareCentimeters, inSquareCentimeters, hectares, inHectares, squareKilometers, inSquareKilometers


## Imperial

@docs squareInches, inSquareInches, squareFeet, inSquareFeet, squareYards, inSquareYards, acres, inAcres, squareMiles, inSquareMiles


## Constants

Shorthand for `Area.squareMeters 1`, `Area.acres 1` etc. Can be convenient to
use with [`Quantity.per`](Quantity#per).

@docs squareMeter, squareMillimeter, squareCentimeter, hectare, squareKilometer
@docs squareInch, squareFoot, squareYard, acre, squareMile

-}

import Constants
import Length exposing (Meters)
import Quantity exposing (Quantity(..), Squared)


{-| -}
type alias SquareMeters =
    Squared Meters


{-| -}
type alias Area =
    Quantity Float SquareMeters


{-| Construct an area from a number of square meters.
-}
squareMeters : Float -> Area
squareMeters numSquareMeters =
    Quantity numSquareMeters


{-| Convert an area to a number of square meters.
-}
inSquareMeters : Area -> Float
inSquareMeters (Quantity numSquareMeters) =
    numSquareMeters


{-| Construct an area from a number of square millimeters.
-}
squareMillimeters : Float -> Area
squareMillimeters numSquareMillimeters =
    squareMeters (1.0e-6 * numSquareMillimeters)


{-| Convert an area to a number of square millimeters.
-}
inSquareMillimeters : Area -> Float
inSquareMillimeters area =
    1.0e6 * inSquareMeters area


{-| Construct an area from a number of square inches.
-}
squareInches : Float -> Area
squareInches numSquareInches =
    squareMeters (Constants.squareInch * numSquareInches)


{-| Convert an area to a number of square inches.
-}
inSquareInches : Area -> Float
inSquareInches area =
    inSquareMeters area / Constants.squareInch


{-| Construct an area from a number of square centimeters.
-}
squareCentimeters : Float -> Area
squareCentimeters numSquareCentimeters =
    squareMeters (1.0e-4 * numSquareCentimeters)


{-| Convert an area to a number of square centimeters.
-}
inSquareCentimeters : Area -> Float
inSquareCentimeters area =
    1.0e4 * inSquareMeters area


{-| Construct an area from a number of square feet.
-}
squareFeet : Float -> Area
squareFeet numSquareFeet =
    squareMeters (Constants.squareFoot * numSquareFeet)


{-| Convert an area to a number of square feet.
-}
inSquareFeet : Area -> Float
inSquareFeet area =
    inSquareMeters area / Constants.squareFoot


{-| Construct an area from a number of square yards.
-}
squareYards : Float -> Area
squareYards numSquareYards =
    squareMeters (Constants.squareYard * numSquareYards)


{-| Convert an area to a number of square yards.
-}
inSquareYards : Area -> Float
inSquareYards area =
    inSquareMeters area / Constants.squareYard


{-| Construct an area from a number of hectares.
-}
hectares : Float -> Area
hectares numHectares =
    squareMeters (1.0e4 * numHectares)


{-| Convert an area to a number of hectares.
-}
inHectares : Area -> Float
inHectares area =
    1.0e-4 * inSquareMeters area


{-| Construct an area from a number of square kilometers.
-}
squareKilometers : Float -> Area
squareKilometers numSquareKilometers =
    squareMeters (1.0e6 * numSquareKilometers)


{-| Convert an area to a number of square kilometers.
-}
inSquareKilometers : Area -> Float
inSquareKilometers area =
    1.0e-6 * inSquareMeters area


{-| Construct an area from a number of acres.
-}
acres : Float -> Area
acres numAcres =
    squareMeters (Constants.acre * numAcres)


{-| Convert an area to a number of acres.
-}
inAcres : Area -> Float
inAcres area =
    inSquareMeters area / Constants.acre


{-| Construct an area from a number of square miles.
-}
squareMiles : Float -> Area
squareMiles numSquareMiles =
    squareMeters (Constants.squareMile * numSquareMiles)


{-| Convert an area to a number of square miles.
-}
inSquareMiles : Area -> Float
inSquareMiles area =
    inSquareMeters area / Constants.squareMile


{-| -}
squareMeter : Area
squareMeter =
    squareMeters 1


{-| -}
squareMillimeter : Area
squareMillimeter =
    squareMillimeters 1


{-| -}
squareCentimeter : Area
squareCentimeter =
    squareCentimeters 1


{-| -}
hectare : Area
hectare =
    hectares 1


{-| -}
squareKilometer : Area
squareKilometer =
    squareKilometers 1


{-| -}
squareInch : Area
squareInch =
    squareInches 1


{-| -}
squareFoot : Area
squareFoot =
    squareFeet 1


{-| -}
squareYard : Area
squareYard =
    squareYards 1


{-| -}
acre : Area
acre =
    acres 1


{-| -}
squareMile : Area
squareMile =
    squareMiles 1
