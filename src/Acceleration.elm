module Acceleration
    exposing
        ( feetPerSecondSquared
        , inFeetPerSecondSquared
        , inMetersPerSecondSquared
        , metersPerSecondSquared
        )


type Acceleration
    = Acceleration Float -- stored as meters per second squared


metersPerSecondSquared : Float -> Acceleration
metersPerSecondSquared numMetersPerSecondSquared =
    Acceleration numMetersPerSecondSquared


inMetersPerSecondSquared : Acceleration -> Float
inMetersPerSecondSquared (Acceleration numMetersPerSecondSquared) =
    numMetersPerSecondSquared


feetPerSecondSquared : Float -> Acceleration
feetPerSecondSquared numFeetPerSecondSquared =
    metersPerSecondSquared (0.3048 * numFeetPerSecondSquared)


inFeetPerSecondSquared : Acceleration -> Float
inFeetPerSecondSquared acceleration =
    inMetersPerSecondSquared acceleration / 0.3048
