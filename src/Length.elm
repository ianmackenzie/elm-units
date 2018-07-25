module Length
    exposing
        ( Length
        , centimeters
        , feet
        , inCentimeters
        , inFeet
        , inInches
        , inKilometers
        , inMeters
        , inMiles
        , inMillimeters
        , inPixels
        , inYards
        , inches
        , kilometers
        , meters
        , miles
        , millimeters
        , pixels
        , yards
        )

import Quantity exposing (LengthUnits, Quantity(..), ScreenSpace, WorldSpace)


type alias Length space =
    -- Meters for WorldSpace
    -- Pixels for ScreenSpace
    Quantity (LengthUnits space)


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


pixels : Float -> Length ScreenSpace
pixels numPixels =
    Quantity numPixels


inPixels : Length ScreenSpace -> Float
inPixels (Quantity numPixels) =
    numPixels
