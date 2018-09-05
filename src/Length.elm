module Length exposing
    ( Meters, Length
    , meters, inMeters
    , microns, inMicrons, millimeters, inMillimeters, centimeters, inCentimeters, kilometers, inKilometers
    , thou, inThou, inches, inInches, feet, inFeet, yards, inYards, miles, inMiles
    , astronomicalUnits, inAstronomicalUnits, parsecs, inParsecs, lightYears, inLightYears
    )

{-|

@docs Meters, Length


## Metric

@docs meters, inMeters
@docs microns, inMicrons, millimeters, inMillimeters, centimeters, inCentimeters, kilometers, inKilometers


## Imperial

@docs thou, inThou, inches, inInches, feet, inFeet, yards, inYards, miles, inMiles


## Astronomical

@docs astronomicalUnits, inAstronomicalUnits, parsecs, inParsecs, lightYears, inLightYears

-}

import Quantity exposing (Fractional, Quantity(..), Rate)


{-| Meters are the standard units of length.
-}
type Meters
    = Meters


{-| A length is a fractional number of meters.
-}
type alias Length =
    Fractional Meters


meters : Float -> Length
meters numMeters =
    Quantity numMeters


inMeters : Length -> Float
inMeters (Quantity numMeters) =
    numMeters


microns : Float -> Length
microns numMicrons =
    meters (1.0e-6 * numMicrons)


inMicrons : Length -> Float
inMicrons length =
    1.0e6 * inMeters length


millimeters : Float -> Length
millimeters numMillimeters =
    meters (0.001 * numMillimeters)


inMillimeters : Length -> Float
inMillimeters length =
    1000 * inMeters length


thou : Float -> Length
thou numThou =
    meters (0.0000254 * numThou)


inThou : Length -> Float
inThou length =
    inMeters length / 0.0000254


inches : Float -> Length
inches numInches =
    meters (0.0254 * numInches)


inInches : Length -> Float
inInches length =
    inMeters length / 0.0254


centimeters : Float -> Length
centimeters numCentimeters =
    meters (0.01 * numCentimeters)


inCentimeters : Length -> Float
inCentimeters length =
    100 * inMeters length


feet : Float -> Length
feet numFeet =
    meters (0.3048 * numFeet)


inFeet : Length -> Float
inFeet length =
    inMeters length / 0.3048


yards : Float -> Length
yards numYards =
    meters (0.9144 * numYards)


inYards : Length -> Float
inYards length =
    inMeters length / 0.9144


kilometers : Float -> Length
kilometers numKilometers =
    meters (1000 * numKilometers)


inKilometers : Length -> Float
inKilometers length =
    0.001 * inMeters length


miles : Float -> Length
miles numMiles =
    meters (1609.344 * numMiles)


inMiles : Length -> Float
inMiles length =
    inMeters length / 1609.344


astronomicalUnits : Float -> Length
astronomicalUnits numAstronomicalUnits =
    meters (149597870700 * numAstronomicalUnits)


inAstronomicalUnits : Length -> Float
inAstronomicalUnits length =
    inMeters length / 149597870700


parsecs : Float -> Length
parsecs numParsecs =
    astronomicalUnits (numParsecs * 648000 / pi)


inParsecs : Length -> Float
inParsecs length =
    inAstronomicalUnits length * pi / 648000


lightYears : Float -> Length
lightYears numLightYears =
    meters (9460730472580800 * numLightYears)


inLightYears : Length -> Float
inLightYears length =
    inMeters length / 9460730472580800
