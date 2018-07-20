module Speed
    exposing
        ( Speed
        , feetPerSecond
        , inFeetPerSecond
        , inKilometersPerHour
        , inMetersPerSecond
        , inMilesPerHour
        , kilometersPerHour
        , metersPerSecond
        , milesPerHour
        )


type Speed
    = Speed Float -- stored as meters per second


metersPerSecond : Float -> Speed
metersPerSecond numMetersPerSecond =
    Speed numMetersPerSecond


inMetersPerSecond : Speed -> Float
inMetersPerSecond (Speed numMetersPerSecond) =
    numMetersPerSecond


feetPerSecond : Float -> Speed
feetPerSecond numFeetPerSecond =
    metersPerSecond (0.3048 * numFeetPerSecond)


inFeetPerSecond : Speed -> Float
inFeetPerSecond speed =
    inMetersPerSecond speed / 0.3048


kilometersPerHour : Float -> Speed
kilometersPerHour numKilometersPerHour =
    metersPerSecond (numKilometersPerHour / 3.6)


inKilometersPerHour : Speed -> Float
inKilometersPerHour speed =
    3.6 * inMetersPerSecond speed


milesPerHour : Float -> Speed
milesPerHour numMilesPerHour =
    metersPerSecond (numMilesPerHour * 1609.344 / 3600)


inMilesPerHour : Speed -> Float
inMilesPerHour speed =
    (3600 / 1609.344) * inMetersPerSecond speed
