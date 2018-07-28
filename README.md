# elm-units

This package provides a convenient, flexible, safe and zero-overhead way to pass
around and work with quantities like "five pixels", "three minutes", "ten
meters" or "60 miles per hour". At its simplest, you can use the provided types
to make your own code more type-safe. For example, if you've ever accidentally
taken the value returned from an animation frame subscription and treated it as
seconds instead of milliseconds (I certainly have!), then you could wrap the
subscription to return `Duration` values instead of raw `Float`s:

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
import Temperature exposing (celsius, inFahrenheit)

feet 10 |> inMeters
--> 3.048

hours 3 |> inSeconds
--> 10800

milesPerHour 60 |> inMetersPerSecond
--> 26.8224

celsius 30 |> inFahrenheit
--> 86
```

If you try to do a conversion that doesn't make sense, you'll get a compile
error:

```elm
celsius 30 |> inMeters
-- TYPE MISMATCH ----------------------------------------------------------- elm

This function cannot handle the argument sent through the (|>) pipe:

19|   celsius 30 |> inMeters
                    ^^^^^^^^
The argument is:

    Temperature

But (|>) is piping it a function that expects:

    Length
```

You can do basic math with units, including calculations involving rates of
change:

```elm
import Quantity as Qty
import Length exposing (feet, inches, kilometers, miles, astronomicalUnits, lightYears, inMeters)
import Duration exposing (seconds, years, inSeconds, inMinutes, perMinute, perYear)
import Speed exposing (metersPerSecond, kilometersPerHour, milesPerHour, inMetersPerSecond, inKilometersPerHour)
import Angle exposing (radians, degrees, inTurns)
import Area exposing (inSquareInches)

-- 6 feet 3 inches, converted to meters
feet 6 |> Qty.plus (inches 3) |> inMeters
--> 1.9050000000000002

-- pi radians plus 45 degrees is 5/8 of a full turn
Qty.sum [ radians pi, degrees 45 ] |> inTurns
--> 0.625

-- Area of a triangle with base of 2 feet and height of 8 inches
Qty.product (feet 2) (inches 8) |> Qty.scaleBy 0.5 |> inSquareInches
--> 96

-- How long do we travel in 10 seconds at 100 km/h?
seconds 10 |> Qty.at (kilometersPerHour 100) |> inMeters
--> 277.77777777777777

-- How long will it take to travel 20 km if we're driving at 60 mph?
kilometers 20 |> Qty.at_ (milesPerHour 60) |> inMinutes
--> 12.427423844746679

-- How fast is "a mile a minute", in kilometers per hour?
miles 1 |> perMinute |> inKilometersPerHour
--> 96.56064

-- Reverse engineer the speed of light from defined lengths/durations
speedOfLight =
    lightYears 1 |> perYear

-- One astronomical unit is the (average) distance from the Sun to the Earth
-- How long does it take light to reach the Earth from the Sun?
astronomicalUnits 1 |> Qty.at_ speedOfLight |> inMinutes
--> 8.316746397269274
```
