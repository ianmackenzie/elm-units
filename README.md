# elm-units

> Simple, safe and convenient unit types and conversions for Elm

*Note*: This package has not yet been published!

`elm-units` is useful whenever you want to store, pass around, convert between,
compare, or do arithmetic on:

  - Durations (seconds, milliseconds, hours...)
  - Angles (degrees, radians, turns...)
  - Pixel counts (whole or fractional)
  - Lengths (meters, feet, inches, miles, light years...)
  - Temperatures (Celsius, Fahrenheit, kelvins)
  - Speeds (pixels per second, miles per hour...) or any other rate of change
  - Any of the other built-in quantity types: areas, accelerations, masses,
    forces, pressures, currents, voltages...
  - Or even values in your own custom units, such as 'number of tiles' in a
    tile-based game

It allows you to create data types like

```elm
type alias Camera =
    { manufacturer : String
    , fieldOfView : Angle
    , shutterSpeed : Duration
    , minimumOperatingTemperature : Temperature
    }
```

and functions like

```elm
canOperateAt : Temperature -> Camera -> Bool
canOperateAt temperature camera =
    temperature |> Quantity.greaterThan camera.minimumOperatingTemperature

{-| Compute the time necessary to cover a given distance, starting from rest,
with the given acceleration.
-}
timeToCover : Length WorldSpace -> Acceleration WorldSpace -> Duration
timeToCover distance acceleration =
    ...
```

which then let you write readable, type-safe code using whatever units you want,
with any necessary unit conversions happening automatically:

```elm
camera : Camera
camera =
    { manufacturer = "Kodak"
    , fieldOfView = Angle.degrees 60
    , shutterSpeed = Duration.milliseconds 2.5
    , minimumOperatingTemperature = Temperature.celsius -35
    }

isSafe : Bool
isSafe =
    camera |> canOperateAt (Temperature.fahrenheit -10)

quarterMileTime : Float
quarterMileTime =
    timeToCover (Length.miles 0.25) (Acceleration.metersPerSecondSquared 4.5)
        |> Duration.inSeconds
```

## Table of Contents

  - [Background](#background)
  - [Install](#install)
  - [Usage](#usage)
    - [Fundamentals](#fundamentals)
    - [Arithmetic and Comparison](#arithmetic-and-comparison)
    - [Rates of Change](#rates-of-change)
    - [Spaces](#spaces)
    - [Custom Functions](#custom-functions)
    - [Custom Units](#custom-units)
    - [Understanding Quantity Types](#understanding-quantity-types)
  - [Getting Help](#getting-help)
  - [API](#api)
  - [Contribute](#contribute)
  - [License](#license)

## Background

Have you ever taken a `Float` value that is a number of milliseconds and
accidentally treated it as a number of seconds, or vice versa? How about angles
in degrees versus radians? Have you ever documented a function as accepting a
length in meters, and then just crossed your fingers and hoped that everyone
read the documentation carefully and never accidentally passed a length in feet
instead?

This package is meant to make it impossible to accidentally mix up units in
these ways, while allowing different parts of a codebase (perhaps in different
packages!) to work in whatever units they find most convenient. This lets you
code in terms of higher-level concepts like 'duration', 'angle', 'length' and
'speed' etc. without having to worry about units.

`elm-units` is somewhat similar to Haskell's [`units` package](http://hackage.haskell.org/package/units)
and F#'s [built-in unit support](https://fsharpforfunandprofit.com/posts/units-of-measure/),
but is designed from the ground up for Elm.

## Install

TODO

## Usage

### Fundamentals

To take code that currently uses raw `Float` values and convert it to using
`elm-units` types, there are three basic steps:

  - Wherever you store a `Float`, such as in your model or in a message, switch
    to storing a `Duration` or `Angle` or `Temperature` etc. value instead.
  - Whenever you *have* a `Float` (from an external package, JSON decoder etc.),
    use a function such as `Duration.seconds`, `Angle.degrees` or
    `Temperature.fahrenheit` to turn it into a type-safe value.
  - Whenever you *need* a `Float` (to pass to an external package, encode as
    JSON etc.), use a function such as `Duration.inMillliseconds`,
    `Angle.inRadians` or `Temperature.inCelsius` to extract the value in
    whatever units you want.

Let's see what that looks like in practice! A pretty common pattern in Elm apps
is to have a `Tick Float` message that contains a number of milliseconds since
the last animation frame, but it's very easy to accidentally treat that `Float`
as a number of seconds, leading to things like way-too-fast animations. Let's
modify the code to use a `Duration` value instead.

First, define the `Tick` message to store a `Duration` value instead of a
`Float`, then take the value returned by the `onAnimationFrameDelta`
subscription and convert it to a `Duration` using the `milliseconds` function:

```elm
import Browser.Events
import Duration exposing (Duration)

type Msg
    = Tick Duration

subscriptions model =
    -- Convert the Float value to a Duration using the
    -- 'milliseconds' function, then store in a Tick message
    Browser.Events.onAnimationFrameDelta (Duration.milliseconds >> Tick)
```

Later on, when you handle the `Tick` message, you can extract the duration value
in whatever units you want. Perhaps you want to keep track of how many frames
per second your application is running at:

```elm
update message model =
    case message of
        Tick duration ->
            -- Extract the duration as a number of seconds
            ( { model | fps = 1 / Duration.inSeconds duration }
            , Cmd.none
            )
```

Note that any necessary conversion is done automatically - you create a
`Duration` from a `Float` by specifying what kind of units you *have*, and then
later extract a `Float` value by specifying what kind of units you *want*. This,
incidentally, means you can skip the 'store the value in a message' step and
just use the provided functions to do unit conversions:

```elm
Duration.hours 3 |> Duration.inSeconds
--> 10800

Length.feet 10 |> Length.inMeters
--> 3.048

Speed.milesPerHour 60 |> Speed.inMetersPerSecond
--> 26.8224

Temperature.celsius 30 |> Temperature.inFahrenheit
--> 86
```

If you try to do a conversion that doesn't make sense, you'll get a compile
error:

```elm
Duration.seconds 30 |> Length.inMeters
-- TYPE MISMATCH ----------------------------------------------------------- elm

This function cannot handle the argument sent through the (|>) pipe:

1|   Duration.seconds 30 |> Length.inMeters
                            ^^^^^^^^^^^^^^^
The argument is:

    Duration

But (|>) is piping it a function that expects:

    Length WorldSpace
```

(We'll get to exactly what `WorldSpace` means a bit later, but basically it
indicates "a length in real-world coordinates" as opposed to "a length in screen
coordinates" or a length in some other unrelated coordinate system.)

### Arithmetic and Comparison

You can do basic math with units:

```elm
-- 6 feet 3 inches, converted to meters
Length.feet 6 |> Quantity.add (Length.inches 3) |> Length.inMeters
--> 1.9050000000000002

-- pi radians plus 45 degrees is 5/8 of a full turn
Quantity.sum [ Angle.radians pi, Angle.degrees 45 ] |> Angle.inTurns
--> 0.625

-- Area of a triangle with base of 2 feet and height of 8 inches
Quantity.product (Length.feet 2) (Length.inches 8)
    |> Quantity.scaleBy 0.5
    |> Area.inSquareInches
--> 96
```

### Rates of Change

Special support is provided for calculations involving rates of change:

```elm
-- How long do we travel in 10 seconds at 100 km/h?
Duration.seconds 10
    |> Quantity.at (Speed.kilometersPerHour 100)
    |> Length.inMeters
--> 277.77777777777777

-- How long will it take to travel 20 km if we're driving at 60 mph?
Length.kilometers 20
    |> Quantity.at_ (Speed.milesPerHour 60)
    |> Duration.inMinutes
--> 12.427423844746679

-- How fast is "a mile a minute", in kilometers per hour?
Length.miles 1 |> Quantity.per (Duration.minutes 1) |> Speed.inKilometersPerHour
--> 96.56064

-- Reverse engineer the speed of light from defined lengths/durations
speedOfLight =
    Length.lightYears 1 |> Quantity.per (Duration.years 1)

speedOfLight |> Speed.inMetersPerSecond
--> 299792458

-- One astronomical unit is the (average) distance from the Sun to the Earth
-- Roughly how long does it take light to reach the Earth from the Sun?
Length.astronomicalUnits 1 |> Quantity.at_ speedOfLight |> Duration.inMinutes
--> 8.316746397269274
```

Note that the various functions above are not restricted to speed (length per
unit time) - any units work:

```elm
pixelsPerInch =
    Length.pixels 96 |> Quantity.per (Length.inches 1)

Length.centimeters 3 |> Quantity.at pixelsPerInch |> Length.inPixels
--> 113.38582677165354
```

(Although defined in the same module, `Length.pixels` and `Length.inches`
produce values of different types, so you need an explicit conversion ratio like
the above if you want to convert between the two.)

### Spaces

TODO

### Custom Functions

TODO (ideal gas law example)

### Custom Units

TODO (currencies? game tiles?)

### Understanding Quantity Types

TODO

The following types are all equivalent:

```elm
-- Length in world space
Length WorldSpace

-- Fractional number of length units in world space
Fractional (LengthUnits WorldSpace)

-- Fractional number of meters
Fractional Meters

-- Float-valued quantity of meters
Quantity Float Meters

-- Float-valued quantity of length units in world space
Quantity Float (LengthUnits WorldSpace)
```

So are all the following:

```elm
Speed WorldSpace
Fractional (SpeedUnits WorldSpace)
Fractional (Quotient (LengthUnits WorldSpace) Seconds)
Quantity Float (Quotient (LengthUnits WorldSpace) Seconds)
Quantity Float (Quotient Meters Seconds)
Rate Meters Seconds
```

## Getting Help

For general questions about using `elm-units`, try asking in the [Elm Slack](http://elmlang.herokuapp.com/)
or posting on the [Elm Discourse forums](https://discourse.elm-lang.org/) or the
[Elm subreddit](https://www.reddit.com/r/elm/). I'm **@ianmackenzie** on all
three platforms =)

## API

Full API documentation will be available on the Elm package web site once this
package is published.

## Contribute

TODO

## License

[BSD-3-Clause © Ian Mackenzie](LICENSE)
