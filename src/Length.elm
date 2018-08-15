module Length
    exposing
        ( Conversion
        , Length
        , LengthUnits
        , Meters
        , OnScreen
        , Pixels
        , RealWorld
        , astronomicalUnits
        , centimeters
        , convert
        , feet
        , inAstronomicalUnits
        , inCentimeters
        , inFeet
        , inInches
        , inKilometers
        , inLightYears
        , inMeters
        , inMiles
        , inMillimeters
        , inParsecs
        , inPixels
        , inYards
        , inches
        , kilometers
        , lightYears
        , meters
        , miles
        , millimeters
        , parsecs
        , pixels
        , roundToNearestPixel
        , yards
        )

{-|

@docs Length


# Spaces

This module includes a couple of predefined spaces, but you can also [define
your own](https://github.com/ianmackenzie/elm-units/blob/master/docs/CustomSpaces.md).

@docs RealWorld, OnScreen


# Units

Length in a particular space is stored as a [`Fractional`](Quantity#Fractional)
number of base length units in that space; each space will generally have a
different associated base length unit. For example, the base length unit in
world space is meters, so the type `Length RealWorld` is equivalent to
`Fractional Meters`. Similarly, the base length unit in screen space is pixels,
so `Length OnScreen` is equivalent to `Fractional Pixels`.

@docs LengthUnits, Pixels, Meters


# Screen space

@docs pixels, inPixels, roundToNearestPixel


# World space


## Construction

@docs meters, millimeters, centimeters, kilometers
@docs inches, feet, yards, miles
@docs astronomicalUnits, parsecs, lightYears


## Conversion

@docs inMeters, inMillimeters, inCentimeters, inKilometers
@docs inInches, inFeet, inYards, inMiles
@docs inAstronomicalUnits, inParsecs, inLightYears

-}

import Quantity exposing (Fractional, Quantity(..), Rate, Whole)


{-| A `Length space` refers to a length in a particular _space_. For example,
`Length.meters 3` is a `Length RealWorld` and refers to a length/distance in the
real, physical world. `Length.pixels 5` is instead a `Length OnScreen`. The
distinction makes it impossible to do nonsensical things like add a length in
pixels to a length in meters, while allowing for things that _do_ make sense
like adding length in meters to a length in feet.
-}
type alias Length space =
    Fractional (LengthUnits space)


{-| The `RealWorld` space refers to lengths in the real, physical world.
-}
type RealWorld
    = RealWorld Never


{-| The `OnScreen` space refers to lengths on a computer screen.
-}
type OnScreen
    = OnScreen Never


{-| `LengthUnits space` refers to the base length units associated with a given
space. It is unlikely you will need to write code that refers to `LengthUnits`
directly, but you may see it pop up in compiler error messages.
-}
type LengthUnits space
    = LengthUnits Never


{-| Pixels are the base length unit in screen space, so

    Length OnScreen

is equivalent to

    Fractional Pixels

because they both expand to

    Fractional (LengthUnits OnScreen)

Therefore you could take a `Length RealWorld`, [`convert`](#convert) it into a
`Length OnScreen`, then pass the result to a function that accepted an argument
of type `Fractional Pixels`. If instead that function only accepted `Whole
Pixels`, then you would have to call [`roundToNearestPixel`](#roundToNearestPixel)
first!

-}
type alias Pixels =
    LengthUnits OnScreen


{-| Meters are the base length unit in world space, so

    Length RealWorld

is equivalent to

    Fractional Meters

because they both expand to

    Fractional (LengthUnits RealWorld)

This is, however, less useful than `Pixels` because it rarely makes sense to
restrict a value to a whole number of meters.

-}
type alias Meters =
    LengthUnits RealWorld


type alias Conversion sourceSpace destinationSpace =
    Rate (LengthUnits destinationSpace) (LengthUnits sourceSpace)


pixels : number -> Quantity number Pixels
pixels numPixels =
    Quantity numPixels


inPixels : Quantity number Pixels -> number
inPixels (Quantity numPixels) =
    numPixels


roundToNearestPixel : Fractional Pixels -> Whole Pixels
roundToNearestPixel (Quantity numPixels) =
    Quantity (round numPixels)


meters : Float -> Length RealWorld
meters numMeters =
    Quantity numMeters


inMeters : Length RealWorld -> Float
inMeters (Quantity numMeters) =
    numMeters


millimeters : Float -> Length RealWorld
millimeters numMillimeters =
    meters (0.001 * numMillimeters)


inMillimeters : Length RealWorld -> Float
inMillimeters length =
    1000 * inMeters length


inches : Float -> Length RealWorld
inches numInches =
    meters (0.0254 * numInches)


inInches : Length RealWorld -> Float
inInches length =
    inMeters length / 0.0254


centimeters : Float -> Length RealWorld
centimeters numCentimeters =
    meters (0.01 * numCentimeters)


inCentimeters : Length RealWorld -> Float
inCentimeters length =
    100 * inMeters length


feet : Float -> Length RealWorld
feet numFeet =
    meters (0.3048 * numFeet)


inFeet : Length RealWorld -> Float
inFeet length =
    inMeters length / 0.3048


yards : Float -> Length RealWorld
yards numYards =
    meters (0.9144 * numYards)


inYards : Length RealWorld -> Float
inYards length =
    inMeters length / 0.9144


kilometers : Float -> Length RealWorld
kilometers numKilometers =
    meters (1000 * numKilometers)


inKilometers : Length RealWorld -> Float
inKilometers length =
    0.001 * inMeters length


miles : Float -> Length RealWorld
miles numMiles =
    meters (1609.344 * numMiles)


inMiles : Length RealWorld -> Float
inMiles length =
    inMeters length / 1609.344


astronomicalUnits : Float -> Length RealWorld
astronomicalUnits numAstronomicalUnits =
    meters (149597870700 * numAstronomicalUnits)


inAstronomicalUnits : Length RealWorld -> Float
inAstronomicalUnits length =
    inMeters length / 149597870700


parsecs : Float -> Length RealWorld
parsecs numParsecs =
    astronomicalUnits (numParsecs * 648000 / pi)


inParsecs : Length RealWorld -> Float
inParsecs length =
    inAstronomicalUnits length * pi / 648000


lightYears : Float -> Length RealWorld
lightYears numLightYears =
    meters (9460730472580800 * numLightYears)


inLightYears : Length RealWorld -> Float
inLightYears length =
    inMeters length / 9460730472580800


convert : Conversion sourceSpace destinationSpace -> Length sourceSpace -> Length destinationSpace
convert rate length =
    length |> Quantity.at rate
