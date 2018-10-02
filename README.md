# elm-units

*Note*: This package has not yet been published!

`elm-units` is useful if you want to store, pass around, convert between,
compare, or do arithmetic on:

  - Durations (seconds, milliseconds, hours...)
  - Angles (degrees, radians, turns...)
  - Lengths (meters, feet, inches, miles, light years...)
  - Temperatures (Celsius, Fahrenheit, kelvins)
  - Pixels (whole or partial)
  - Speeds (pixels per second, miles per hour...) or any other rate of change
  - Any of the other built-in quantity types: areas, accelerations, masses,
    forces, pressures, currents, voltages...
  - Or even values in your own custom units, such as 'number of tiles' in a
    tile-based game

It is aimed especially at engineering/scientific/technical appliations but is
designed to be generic enough to work well for other fields such as games and
finance. The core of the package consists of types like `Length`, `Duration`,
`Temperature`, `Speed` and `Pixels`, and functions like

```elm
Length.meters : Float -> Length
Length.feet : Float -> Length
Duration.seconds : Float -> Duration
Duration.milliseconds : Float -> Duration

Length.inMeters : Length -> Float
Length.inFeet : Length -> Float
Duration.inSeconds : Duration -> Float
Duration.inMilliseconds : Duration -> Float
```

You can use these functions to do simple unit conversions:

```elm
Duration.hours 3 |> Duration.inSeconds
--> 10800

Length.feet 10 |> Length.inMeters
--> 3.048

Speed.milesPerHour 60 |> Speed.inMetersPerSecond
--> 26.8224

Temperature.degreesCelsius 30
    |> Temperature.inDegreesFahrenheit
--> 86
```

Additionally, types like `Length` are actually of type `Quantity number units`
(`Length` is `Quantity Float Meters`, for example), and there are several
generic functions which let you work directly with any kind of `Quantity`
values:

```elm
Duration.hours 2
  |> Quantity.plus (Duration.minutes 30)
  |> Duration.inSeconds
--> 9000

Quantity.sort
    [ Length.feet 1
    , Length.inches 1
    , Length.meters 1
    ]
--> [ Length.inches 1
--> , Length.feet 1
--> , Length.meters 1
--> ]

Quantity.sort
    [ Duration.seconds 100
    , Duration.minutes 1
    , Duration.hours 0.1
    ]
--> [ Duration.minutes 1
--> , Duration.seconds 100
--> , Duration.hours 0.1
--> ]

-- How far do we go if we drive for 2 minutes
-- at 15 meters per second?
Duration.minutes 2
  |> Quantity.at (Speed.metersPerSecond 15)
  |> Length.inKilometers
--> 1.8
```

Perhaps most importantly, values like `Length`s and `Duration`s work very well
as as record fields or function arguments, since they help ensure that the math
will always work out correctly even if different parts of a codebase work in
different units:

```elm
import Angle exposing (Angle)
import Duration exposing (Duration)
import Temperature exposing (Temperature)

type alias Camera =
    { fieldOfView : Angle
    , shutterSpeed : Duration
    , minimumOperatingTemperature : Temperature
    }

camera : Camera
camera =
    { fieldOfView = Angle.degrees 60
    , shutterSpeed = Duration.milliseconds 2.5
    , minimumOperatingTemperature =
        Temperature.degreesCelsius -25
    }

canOperateAt : Temperature -> Camera -> Bool
canOperateAt temperature camera =
    temperature
        |> Temperature.greaterThan
            camera.minimumOperatingTemperature

camera |> canOperateAt (Temperature.degreesFahrenheit -20)
--> False

camera |> canOperateAt (Temperature.degreesFahrenheit -10)
--> True

camera.fieldOfView |> Angle.inRadians
--> pi / 3
```

## Table of Contents

  - [Installation](#installation)
  - [Usage](#usage)
    - [Fundamentals](#fundamentals)
    - [The `Quantity` Type](#the-quantity-type)
    - [Arithmetic and Comparison](#arithmetic-and-comparison)
    - [Custom Functions](#custom-functions)
    - [Custom Units](#custom-units)
    - [Understanding Quantity Types](#understanding-quantity-types)
  - [Getting Help](#getting-help)
  - [API](#api)
  - [Contributing](#contributing)
  - [License](#license)

## Installation

Once this package is published, you will be able to install it with

```
elm install ianmackenzie/elm-units
```

## Usage

### Fundamentals

To take code that currently uses raw `Float` values and convert it to using
`elm-units` types, there are three basic steps:

  - Wherever you store a `Float`, such as in your model or in a message, switch
    to storing a `Duration` or `Angle` or `Temperature` etc. value instead.
  - Whenever you *have* a `Float` (from an external package, JSON decoder etc.),
    use a function such as `Duration.seconds`, `Angle.degrees` or
    `Temperature.degreesFahrenheit` to turn it into a type-safe value.
  - Whenever you *need* a `Float` (to pass to an external package, encode as
    JSON etc.), use a function such as `Duration.inMillliseconds`,
    `Angle.inRadians` or `Temperature.inDegreesCelsius` to extract the value in
    whatever units you want.

### The `Quantity` Type

All values produced by this package (with the exception of `Temperature`, which
is a bit of a special case) are actually values of type `Quantity`, defined as

```elm
type Quantity number units
    = Quantity number
```

For example, `Length` is defined as

```elm
type alias Length =
    Quantity Float Meters
```

This means that a `Length` is internally stored as a `Float` number of `Meters`,
but the choice of internal units can mostly be treated as an implementation
detail.

Having a common `Quantity` type means that it is possible to define generic
arithmetic and comparison operations that work on any kind of quantity; read on!

### Arithmetic and Comparison

You can do basic math with `Quantity` values:

```elm
-- 6 feet 3 inches, converted to meters
Length.feet 6
    |> Quantity.plus (Length.inches 3)
    |> Length.inMeters
--> 1.9050000000000002

-- pi radians plus 45 degrees is 5/8 of a full turn
Quantity.sum [ Angle.radians pi, Angle.degrees 45 ]
    |> Angle.inTurns
--> 0.625

-- Area of a triangle with base of 2 feet and
-- height of 8 inches
Quantity.product (Length.feet 2) (Length.inches 8)
    |> Quantity.scaleBy 0.5
    |> Area.inSquareInches
--> 96
```

Special support is provided for calculations involving rates of change:

```elm
-- How long do we travel in 10 seconds at 100 km/h?
Duration.seconds 10
    |> Quantity.at (Speed.kilometersPerHour 100)
    |> Length.inMeters
--> 277.77777777777777

-- How long will it take to travel 20 km
-- if we're driving at 60 mph?
Length.kilometers 20
    |> Quantity.at_ (Speed.milesPerHour 60)
    |> Duration.inMinutes
--> 12.427423844746679

-- How fast is "a mile a minute", in kilometers per hour?
Length.miles 1
    |> Quantity.per (Duration.minutes 1)
    |> Speed.inKilometersPerHour
--> 96.56064

-- Reverse engineer the speed of light
-- from defined lengths/durations
speedOfLight =
    Length.lightYears 1
        |> Quantity.per (Duration.julianYears 1)

speedOfLight |> Speed.inMetersPerSecond
--> 299792458

-- One astronomical unit is the (average) distance from the
-- Sun to the Earth. Roughly how long does it take light to
-- reach the Earth from the Sun?
Length.astronomicalUnits 1
    |> Quantity.at_ speedOfLight
    |> Duration.inMinutes
--> 8.316746397269274
```

Note that the various functions above are not restricted to speed (length per
unit time) - any units work:

```elm
pixelsPerInch =
    Pixels.pixels 96 |> Quantity.per (Length.inches 1)

Length.centimeters 3
    |> Quantity.at pixelsPerInch
    |> Pixels.inPixels
--> 113.38582677165354
```

Finally, `Quantity` values can be compared/sorted:

```elm
Length.meters 1 |> Quantity.greaterThan (Length.feet 3)
--> True

Quantity.compare (Length.meters 1) (Length.feet 3)
--> GT

Quantity.max (Length.meters 1) (Length.feet 3)
--> Length.meters 1

Quantity.maximum [ Length.meters 1, Length.feet 3 ]
--> Just (Length.meters 1)

Quantity.sort [ Length.meters 1, Length.feet 3 ]
--> [ Length.feet 3, Length.meters 1 ]
```

#### Multiplication

There are actually three different multiplication functions in `elm-units`, used
for different kinds of multiplication:

  - [`Quantity.product`](Quantity#product) is used to multiply two quantities
    with the same `units` together, resulting in a quantity in `Squared units`;
    this can be used to multiply two lengths together to get an area, for
    example
  - [`Quantity.scaleBy`](Quantity#scaleBy) is used to multiply a quantity by
    a plain `Float` or `Int` scaling factor
  - [`Quantity.times`](Quantity#times) is used to multiply a rate of change by
    an indepent quantity value to get a dependent quantity value; for example,
    multiplying a `Speed` by a `Duration` to get a `Length`, or a `Pressure` by
    an `Area` to get a `Force`

#### Argument order

Note that `Quantity.minus`, `Quantity.lessThan` and `Quantity.greaterThan` (and
their `Temperature` equivalents) "take the second argument first"; for example,

```elm
Quantity.lessThan x y
```

means `y < x`, *not* `x < y`. This is done for a couple of reasons. First, so
that use with `|>` works naturally; for example,

```elm
x |> Quantity.lessThan y
```

_does_ mean `x < y`. The 'reversed' argument order also means that things like

```elm
List.map (Quantity.minus x) [ a, b, c ]
```

will work as expected - it will result in

```elm
[ a - x, b - x, c - x ]
```

instead of

```elm
[ x - a, x - b, x - c ]
```

which is what you would get if `Quantity.minus` took arguments in the 'normal'
order.

### Custom Functions

Some calculations cannot be expressed using the built-in `Quantity` functions.
Take kinetic energy `E_k = 1/2 * m * v^2`, for example - the `elm-units` type
system is not sophisticated enough to work out the units properly. Instead,
you'd need to create a custom function like

```elm
kineticEnergy : Mass -> Speed -> Energy
kineticEnergy (Quantity m) (Quantity v) =
    Quantity (0.5 * m * v^2)
```

In the _implementation_ of `kineticEnergy`, you're working with raw `Float`
values so you need to be careful to make sure the units actually do work out.
(The values will be in [SI units][6] - meters, seconds etc.) Once the function
has been implemented, though, it can be used in a completely type-safe way -
callers can supply arguments using whatever units they have, and extract results
in whatever units they want:

```elm
kineticEnergy (Mass.tonnes 1.5) (Speed.milesPerHour 60)
    |> Energy.inKilowattHours
--> 0.14988357119999998
```

### Custom Units

`elm-units` defines many standard unit types, but you can easily define your
own! See [CustomUnits][1] for an example.

### Understanding Quantity Types

The same quantity type can often be expressed in multiple different ways. Take
the `Speed` type as an example. It is an alias for

```elm
Quantity Float MetersPerSecond
```

but expanding the `MetersPerSecond` type alias, this is equivalent to

```elm
Quantity Float (Rate Meters Seconds)
```

and you may see any one of these three forms pop up in error messages.

## Getting Help

For general questions about using `elm-units`, try asking in the [Elm Slack][3]
or posting on the [Elm Discourse forums][4] or the [Elm subreddit][5]. I'm
**@ianmackenzie** on all three platforms =)

## API

Full API documentation will be available on the Elm package web site once this
package is published.

## Contributing

TODO

## License

[BSD-3-Clause © Ian Mackenzie][2]

[1]: https://github.com/ianmackenzie/elm-units/blob/master/doc/CustomUnits.md
[2]: https://github.com/ianmackenzie/elm-units/blob/master/LICENSE
[3]: http://elmlang.herokuapp.com/
[4]: https://discourse.elm-lang.org/
[5]: https://www.reddit.com/r/elm/
[6]: https://en.wikipedia.org/wiki/International_System_of_Units
