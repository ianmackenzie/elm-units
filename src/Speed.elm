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


{-| Construct a `Speed` from a given number of meters per second, for example:

    speed =
        Speed.metersPerSecond
            (Length.inMeters length
                / Duration.inSeconds duration
            )

Note that the above would still work properly even if `length` and `duration`
were initially constructed using different units such as

    length =
        Length.feet 10

    time =
        Time.milliseconds 2500

but you do have to have to be careful not to write nonsense code like

    speed =
        Speed.metersPerSecond
            (Length.inInches length
                / Duration.inHours duration
            )

I recommend using SI units (meters, seconds, kilograms etc.) everywhere, but
everything will still work if you use other units as long as you're consistent.
For example, the following will work properly:

    speed =
        Speed.milesPerHour
            (Length.inMiles length
                / Duration.inHours duration
            )

-}
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
