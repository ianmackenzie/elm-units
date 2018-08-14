module Length
    exposing
        ( Conversion
        , Length
        , LengthUnits
        , Meters
        , Pixels
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

{-| A `Length space` refers to a length in a particular [space](Spaces). For
example, a `Length WorldSpace` refers to a length/distance in the real world
(measured in meters, feet, light years or some other physical unit) and a
`Length ScreenSpace` refers to a length/distance in screen coordinates (measured
in pixels).

@docs Length


# Units

Length in a particular space is stored as a [`Fractional`](Quantity#Fractional)
number of base length units in that space; each space will generally have a
different associated base length unit. For example, the base length unit in
world space is meters, so the type `Length WorldSpace` is equivalent to
`Fractional Meters`. Similarly, the base length unit in screen space is pixels,
so `Length ScreenSpace` is equivalent to `Fractional Pixels`.

@docs LengthUnits, Meters, Pixels


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
import Spaces exposing (ScreenSpace, WorldSpace)


{-| -}
type alias Length space =
    Fractional (LengthUnits space)


{-| `LengthUnits space` refers to the base length units associated with a given
space. It is unlikely you will need to write code that refers to `LengthUnits`
directly, but you may see it pop up in compiler error messages.
-}
type LengthUnits space
    = LengthUnits Never


{-| Meters are the base length unit in world space, so

    Length WorldSpace

and

    Fractional Meters

are equivalent because they both expand to

    Fractional (LengthUnits WorldSpace)

-}
type alias Meters =
    LengthUnits WorldSpace


{-| Pixels are the base length unit in screen space, so

    Length ScreenSpace

and

    Fractional Pixels

are equivalent because they both expand to

    Fractional (LengthUnits ScreenSpace)

-}
type alias Pixels =
    LengthUnits ScreenSpace


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


meters : Float -> Length WorldSpace
meters numMeters =
    Quantity numMeters


inMeters : Length WorldSpace -> Float
inMeters (Quantity numMeters) =
    numMeters


millimeters : Float -> Length WorldSpace
millimeters numMillimeters =
    meters (0.001 * numMillimeters)


inMillimeters : Length WorldSpace -> Float
inMillimeters length =
    1000 * inMeters length


inches : Float -> Length WorldSpace
inches numInches =
    meters (0.0254 * numInches)


inInches : Length WorldSpace -> Float
inInches length =
    inMeters length / 0.0254


centimeters : Float -> Length WorldSpace
centimeters numCentimeters =
    meters (0.01 * numCentimeters)


inCentimeters : Length WorldSpace -> Float
inCentimeters length =
    100 * inMeters length


feet : Float -> Length WorldSpace
feet numFeet =
    meters (0.3048 * numFeet)


inFeet : Length WorldSpace -> Float
inFeet length =
    inMeters length / 0.3048


yards : Float -> Length WorldSpace
yards numYards =
    meters (0.9144 * numYards)


inYards : Length WorldSpace -> Float
inYards length =
    inMeters length / 0.9144


kilometers : Float -> Length WorldSpace
kilometers numKilometers =
    meters (1000 * numKilometers)


inKilometers : Length WorldSpace -> Float
inKilometers length =
    0.001 * inMeters length


miles : Float -> Length WorldSpace
miles numMiles =
    meters (1609.344 * numMiles)


inMiles : Length WorldSpace -> Float
inMiles length =
    inMeters length / 1609.344


astronomicalUnits : Float -> Length WorldSpace
astronomicalUnits numAstronomicalUnits =
    meters (149597870700 * numAstronomicalUnits)


inAstronomicalUnits : Length WorldSpace -> Float
inAstronomicalUnits length =
    inMeters length / 149597870700


parsecs : Float -> Length WorldSpace
parsecs numParsecs =
    astronomicalUnits (numParsecs * 648000 / pi)


inParsecs : Length WorldSpace -> Float
inParsecs length =
    inAstronomicalUnits length * pi / 648000


lightYears : Float -> Length WorldSpace
lightYears numLightYears =
    meters (9460730472580800 * numLightYears)


inLightYears : Length WorldSpace -> Float
inLightYears length =
    inMeters length / 9460730472580800


convert : Conversion sourceSpace destinationSpace -> Length sourceSpace -> Length destinationSpace
convert rate length =
    length |> Quantity.at rate
