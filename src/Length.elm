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
        , inYards
        , inches
        , kilometers
        , meters
        , miles
        , millimeters
        , yards
        )


type Length
    = Length Float -- stored as meters


meters : Float -> Length
meters numMeters =
    Length numMeters


inMeters : Length -> Float
inMeters (Length numMeters) =
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
