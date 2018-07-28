# elm-units

This package provides a convenient, flexible, bulletproof and zero-overhead way
to pass around and work with quantities like "five pixels", "three minutes",
"ten meters" or "60 miles per hour". At its simplest, you can use the provided
types to make your own code more type-safe. For example, if you've ever
accidentally taken the value returned from an animation frame subscription and
treated it as seconds instead of milliseconds (I certainly have!), then you
could wrap the subscription to return `Duration` values instead of raw `Float`s:

```elm
import Browser.Events
import Duration exposing (Duration, milliseconds, inSeconds)

type Msg
    = Tick Duration

subscriptions model =
    -- Convert the Float value to a Duration using the
    -- 'milliseconds' function, then store in a Tick message
    Browser.Events.onAnimationFrameDelta (milliseconds >> Tick)
```

Later on when you handle the `Tick` message, you can extract the duration value
in whatever units you want, with any necessary conversion being done for you
automatically. Perhaps you want to keep track of how many frames per second your
application is running at:

```elm
update message model =
    case message of
        Tick duration ->
            -- Extract the duration as a number of seconds
            ( { model | fps = 1 / inSeconds duration }
            , Cmd.none
            )
```

You can also use the provided functions for convenient unit conversions:

```elm
import Length exposing (feet, inMeters)
import Duration exposing (hours, inSeconds)
import Speed exposing (milesPerHour, inMetersPerSecond)

feet 10 |> inMeters
--> 3.048

hours 3 |> inSeconds
--> 10800

milesPerHour 60 |> inMetersPerSecond
--> 26.8224
```

You can also easily write your own type-safe functions that automatically work
with any desired units:

```elm
import Length exposing (Length, kilometers, astronomicalUnits, lightYears, inMeters)
import Duration exposing (Duration, seconds, years, inSeconds, inMinutes)
import Speed exposing (Speed, milesPerHour, metersPerSecond, inMetersPerSecond)

timeToTravel : Length -> Speed -> Duration
timeToTravel distance speed =
    seconds (inMeters distance / inMetersPerSecond speed)

-- How long will it take to travel 20 km if we're driving at 60 mph?
timeToTravel (kilometers 20) (milesPerHour 60) |> inMinutes
--> 12.427423844746679

-- Reverse engineer the speed of light from defined lengths/durations
speedOfLight =
    metersPerSecond (inMeters (lightYears 1) / inSeconds (years 1))

-- One astronomical unit is the (average) distance from the Sun to the Earth
-- How long does it take light to reach the Earth from the Sun?
timeToTravel (astronomicalUnits 1) speedOfLight |> inMinutes
--> 8.316746397269274
```

Note how the implementation of `timeToTravel` chose to work in standard SI units
(meters, seconds) but the caller can supply values in any appropriate units, and
extract the result in any appropriate units, with all necessary conversions
happening automatically.

## Doing math with units

In the above `timeToTravel` example, the _implementation_ of the function had to
be careful to be consistent with units. For example, the following
implementation would be wrong since the `Float` value passed to `minutes` is in
fact a number of seconds, so the result would be off by a factor of 60:

```elm
timeToTravel : Length -> Speed -> Duration
timeToTravel distance speed =
    minutes (inMeters distance / inMetersPerSecond speed)
```

(As long as the implementation is correct, though, there's no way to _call_ the
function improperly. The danger is only inside the function, where you are
temporarily dealing with raw `Float` values.)

In many cases, it's possible to work directly with length, speed, duration etc.
values _without_ converting to `Float` values first.
