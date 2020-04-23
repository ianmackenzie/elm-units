module Length exposing
    ( Length, Meters
    , meters, inMeters
    , angstroms, inAngstroms, nanometers, inNanometers, microns, inMicrons, millimeters, inMillimeters, centimeters, inCentimeters, kilometers, inKilometers
    , thou, inThou, inches, inInches, feet, inFeet, yards, inYards, miles, inMiles
    , cssPixels, inCssPixels, points, inPoints, picas, inPicas
    , astronomicalUnits, inAstronomicalUnits, parsecs, inParsecs, lightYears, inLightYears
    , meter, angstrom, nanometer, micron, millimeter, centimeter, kilometer
    , inch, foot, yard, mile
    , astronomicalUnit, parsec, lightYear
    )

{-| A `Length` represents a length in meters, feet, centimeters, miles etc. It
is stored as a number of meters.

@docs Length, Meters


## Metric

@docs meters, inMeters
@docs angstroms, inAngstroms, nanometers, inNanometers, microns, inMicrons, millimeters, inMillimeters, centimeters, inCentimeters, kilometers, inKilometers


## Imperial

@docs thou, inThou, inches, inInches, feet, inFeet, yards, inYards, miles, inMiles


## CSS and typography

@docs cssPixels, inCssPixels, points, inPoints, picas, inPicas


## Astronomical

@docs astronomicalUnits, inAstronomicalUnits, parsecs, inParsecs, lightYears, inLightYears


## Constants

Shorthand for `Length.meters 1`, `Length.feet 1` etc. Can be convenient to use
with [`Quantity.per`](Quantity#per).

Note that `thou` is omitted since it doesn't have separate singular and plural
forms.

@docs meter, angstrom, nanometer, micron, millimeter, centimeter, kilometer
@docs inch, foot, yard, mile
@docs astronomicalUnit, parsec, lightYear

-}

import Constants
import Quantity exposing (Quantity(..))


{-| -}
type Meters
    = Meters


{-| -}
type alias Length =
    Quantity Float Meters


{-| Construct a length from a number of meters.

    height : Length
    height =
        Length.meters 2

-}
meters : Float -> Length
meters numMeters =
    Quantity numMeters


{-| Convert a length to a number of meters.

    Length.feet 1 |> Length.inMeters
    --> 0.3048

-}
inMeters : Length -> Float
inMeters (Quantity numMeters) =
    numMeters


{-| Construct a length from a number of angstroms.

    Length.angstroms 1
    --> Length.meters 1e-10

-}
angstroms : Float -> Length
angstroms numAngstroms =
    meters (1.0e-10 * numAngstroms)


{-| Convert a length to a number of angstroms.

    Length.nanometers 1 |> Length.inAngstroms
    --> 10

-}
inAngstroms : Length -> Float
inAngstroms length =
    1.0e10 * inMeters length


{-| Construct a length from a number of nanometers.

    Length.nanometers 1
    --> Length.meters 1e-9

-}
nanometers : Float -> Length
nanometers numNanometers =
    meters (1.0e-9 * numNanometers)


{-| Convert a length to a number of nanometers.

    Length.microns 1 |> Length.inNanometers
    --> 1000

-}
inNanometers : Length -> Float
inNanometers length =
    1.0e9 * inMeters length


{-| Construct a length from a number of microns (micrometers).

    Length.microns 1
    --> Length.meters 1e-6

-}
microns : Float -> Length
microns numMicrons =
    meters (1.0e-6 * numMicrons)


{-| Convert a length to a number of microns (micrometers).

    Length.millimeters 1 |> Length.inMicrons
    --> 1000

-}
inMicrons : Length -> Float
inMicrons length =
    1.0e6 * inMeters length


{-| Construct a length from number of millimeters.
-}
millimeters : Float -> Length
millimeters numMillimeters =
    meters (0.001 * numMillimeters)


{-| Convert a length to number of millimeters.
-}
inMillimeters : Length -> Float
inMillimeters length =
    1000 * inMeters length


{-| Construct a length from a number of thou (thousandths of an inch).

    Length.thou 5
    --> Length.inches 0.005

-}
thou : Float -> Length
thou numThou =
    meters (Constants.inch * 0.001 * numThou)


{-| Convert a length to a number of thou (thousandths of an inch).

    Length.millimeters 1 |> Length.inThou
    --> 39.37007874015748

-}
inThou : Length -> Float
inThou length =
    inMeters length / (Constants.inch * 0.001)


{-| Construct a length from a number of inches.
-}
inches : Float -> Length
inches numInches =
    meters (Constants.inch * numInches)


{-| Convert a length to a number of inches.
-}
inInches : Length -> Float
inInches length =
    inMeters length / Constants.inch


{-| Construct a length from a number of centimeters.
-}
centimeters : Float -> Length
centimeters numCentimeters =
    meters (0.01 * numCentimeters)


{-| Convert a length to a number of centimeters.
-}
inCentimeters : Length -> Float
inCentimeters length =
    100 * inMeters length


{-| Construct a length from a number of feet.
-}
feet : Float -> Length
feet numFeet =
    meters (Constants.foot * numFeet)


{-| Convert a length to a number of feet.
-}
inFeet : Length -> Float
inFeet length =
    inMeters length / Constants.foot


{-| Construct a length from a number of yards.
-}
yards : Float -> Length
yards numYards =
    meters (Constants.yard * numYards)


{-| Convert a length to a number of yards.
-}
inYards : Length -> Float
inYards length =
    inMeters length / Constants.yard


{-| Construct a length from a number of kilometers.
-}
kilometers : Float -> Length
kilometers numKilometers =
    meters (1000 * numKilometers)


{-| Convert a length to a number of kilometers.
-}
inKilometers : Length -> Float
inKilometers length =
    0.001 * inMeters length


{-| Construct a length from a number of miles.
-}
miles : Float -> Length
miles numMiles =
    meters (Constants.mile * numMiles)


{-| Convert a length to a number of miles.
-}
inMiles : Length -> Float
inMiles length =
    inMeters length / Constants.mile


{-| Construct a length from a number of [CSS pixels](https://drafts.csswg.org/css-values-3/#absolute-lengths),
defined as 1/96 of an inch.

Note the difference between this function and [`Pixels.pixels`](Pixels#pixels).
`Length.cssPixels 1` is equivalent to `Length.inches (1 / 96)` or
approximately `Length.millimeters 0.264583`; it returns a length in _real world_
units equal to the (nominal) physical size of one CSS pixel.

In contrast, `Pixels.pixels 1` simply returns an abstract "1 pixel" value. You
can think of `Length.cssPixels 1` as a shorthand for

    Pixels.pixels 1
        |> Quantity.at_
            (Pixels.pixels 96
                |> Quantity.per (Length.inches 1)
            )

That is, `Length.cssPixels 1` is the size of 1 pixel at a resolution of 96 DPI.

-}
cssPixels : Float -> Length
cssPixels numCssPixels =
    meters (Constants.cssPixel * numCssPixels)


{-| Convert a length to a number of CSS pixels.
-}
inCssPixels : Length -> Float
inCssPixels length =
    inMeters length / Constants.cssPixel


{-| Construct a length from a number of [points](https://en.wikipedia.org/wiki/Point_%28typography%29),
defined as 1/72 of an inch.
-}
points : Float -> Length
points numPoints =
    meters (Constants.point * numPoints)


{-| Convert a length to a number of points.
-}
inPoints : Length -> Float
inPoints length =
    inMeters length / Constants.point


{-| Construct a length from a number of [picas](https://en.wikipedia.org/wiki/Pica_%28typography%29),
defined as 1/6 of an inch.
-}
picas : Float -> Length
picas numPicas =
    meters (Constants.pica * numPicas)


{-| Convert a length to a number of picas.
-}
inPicas : Length -> Float
inPicas length =
    inMeters length / Constants.pica


{-| Construct a length from a number of [astronomical units][au] (AU). One AU is
approximately equal to the average distance of the Earth from the Sun.

[au]: https://en.wikipedia.org/wiki/Astronomical_unit "Astronomical unit"

-}
astronomicalUnits : Float -> Length
astronomicalUnits numAstronomicalUnits =
    meters (149597870700 * numAstronomicalUnits)


{-| Convert a length to a number of astronomical units.
-}
inAstronomicalUnits : Length -> Float
inAstronomicalUnits length =
    inMeters length / 149597870700


{-| Construct a length from a number of [parsecs][parsec].

[parsec]: https://en.wikipedia.org/wiki/Parsec "Parsec"

-}
parsecs : Float -> Length
parsecs numParsecs =
    astronomicalUnits (numParsecs * 648000 / pi)


{-| Convert a length to a number of parsecs.
-}
inParsecs : Length -> Float
inParsecs length =
    inAstronomicalUnits length * pi / 648000


{-| Construct a length from a number of light years. One light year is the
distance traveled when moving at the speed of light for one [Julian year](Duration#julianYear).
-}
lightYears : Float -> Length
lightYears numLightYears =
    meters (9460730472580800 * numLightYears)


{-| Convert a length to a number of light years.
-}
inLightYears : Length -> Float
inLightYears length =
    inMeters length / 9460730472580800


{-| -}
meter : Length
meter =
    meters 1


{-| -}
angstrom : Length
angstrom =
    angstroms 1


{-| -}
nanometer : Length
nanometer =
    nanometers 1


{-| -}
micron : Length
micron =
    microns 1


{-| -}
millimeter : Length
millimeter =
    millimeters 1


{-| -}
centimeter : Length
centimeter =
    centimeters 1


{-| -}
kilometer : Length
kilometer =
    kilometers 1


{-| -}
inch : Length
inch =
    inches 1


{-| -}
foot : Length
foot =
    feet 1


{-| -}
yard : Length
yard =
    yards 1


{-| -}
mile : Length
mile =
    miles 1


{-| -}
astronomicalUnit : Length
astronomicalUnit =
    astronomicalUnits 1


{-| -}
parsec : Length
parsec =
    parsecs 1


{-| -}
lightYear : Length
lightYear =
    lightYears 1
