module Length
    exposing
        ( Length
        , LengthUnits
        , astronomicalUnits
        , centimeters
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
        , inYards
        , inches
        , kilometers
        , lightYears
        , meters
        , miles
        , millimeters
        , parsecs
        , perAstronomicalUnit
        , perCentimeter
        , perFoot
        , perInch
        , perKilometer
        , perLightYear
        , perMeter
        , perMile
        , perMillimeter
        , perParsec
        , perYard
        , yards
        )

import Quantity exposing (Quantity(..), Rate)


type LengthUnits
    = Meters


type alias Length =
    Quantity LengthUnits


meters : Float -> Length
meters numMeters =
    Quantity numMeters


inMeters : Length -> Float
inMeters (Quantity numMeters) =
    numMeters


millimeters : Float -> Length
millimeters numMillimeters =
    meters (0.001 * numMillimeters)


inMillimeters : Length -> Float
inMillimeters length =
    1000 * inMeters length


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


perMillimeter : Quantity units -> Quantity (Rate units LengthUnits)
perMillimeter quantity =
    Quantity.per (millimeters 1) quantity


perCentimeter : Quantity units -> Quantity (Rate units LengthUnits)
perCentimeter quantity =
    Quantity.per (centimeters 1) quantity


perMeter : Quantity units -> Quantity (Rate units LengthUnits)
perMeter quantity =
    Quantity.per (meters 1) quantity


perKilometer : Quantity units -> Quantity (Rate units LengthUnits)
perKilometer quantity =
    Quantity.per (kilometers 1) quantity


perInch : Quantity units -> Quantity (Rate units LengthUnits)
perInch quantity =
    Quantity.per (inches 1) quantity


perFoot : Quantity units -> Quantity (Rate units LengthUnits)
perFoot quantity =
    Quantity.per (feet 1) quantity


perYard : Quantity units -> Quantity (Rate units LengthUnits)
perYard quantity =
    Quantity.per (yards 1) quantity


perMile : Quantity units -> Quantity (Rate units LengthUnits)
perMile quantity =
    Quantity.per (miles 1) quantity


perAstronomicalUnit : Quantity units -> Quantity (Rate units LengthUnits)
perAstronomicalUnit quantity =
    Quantity.per (astronomicalUnits 1) quantity


perParsec : Quantity units -> Quantity (Rate units LengthUnits)
perParsec quantity =
    Quantity.per (parsecs 1) quantity


perLightYear : Quantity units -> Quantity (Rate units LengthUnits)
perLightYear quantity =
    Quantity.per (lightYears 1) quantity
