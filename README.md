# elm-units

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

It is aimed especially at engineering/scientific/technical applications but is
designed to be generic enough to work well for other fields such as games and
finance. The core of the package consists of types like `Length`, `Duration`,
`Temperature`, `Speed` and `Pixels`, which you can use to add some nice type
safety to data types and function signatures:

```elm
type alias Camera =
    { fieldOfView : Angle
    , shutterSpeed : Duration
    , minimumOperatingTemperature : Temperature
    }

canOperateAt : Temperature -> Camera -> Bool
canOperateAt temperature camera =
    temperature
        |> Temperature.greaterThan
            camera.minimumOperatingTemperature
```

You can construct values of these types from any units you want, using provided
functions such as:

```elm
Length.feet : Float -> Length
Length.meters :  Float -> Length
Duration.seconds : Float -> Duration
Angle.degrees : Float -> Angle
Temperature.degreesFahrenheit : Float -> Temperature
```

You can later convert back to plain numeric values, also in any units you want
(which do not have to be the same units used when initially constructing the
value!):

```elm
Length.inCentimeters : Length -> Float
Length.inMiles : Length -> Float
Duration.inHours : Duration -> Float
Angle.inRadians : Angle -> Float
Temperature.inDegreesCelsius : Temperature -> Float
```

This means that (among other things!) you can use these functions to do simple
unit conversions:

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
(`Length` is `Quantity Float Meters`, for example, meaning that it is internally
stored as a number of meters), and there are several generic functions which let
you work directly with any kind of `Quantity` values:

```elm
Length.feet 3
    |> Quantity.lessThan (Length.meters 1)
--> True

Duration.hours 2
  |> Quantity.plus (Duration.minutes 30)
  |> Duration.inSeconds
--> 9000

-- Some functions can actually convert between units!
Quantity.product
    (Length.centimeters 60)
    (Length.centimeters 80)
--> Area.squareMeters 0.48

Quantity.sort
    [ Angle.radians 1
    , Angle.degrees 10
    , Angle.turns 0.5
    ]
--> [ Angle.degrees 10 , Angle.radians 1 , Angle.turns 0.5 ]
```

Ultimately, what this does is let you pass around and manipulate `Length`,
`Duration` or `Temperature` etc. values without having to worry about units.
When you initially construct a `Length`, you need to specify what units you're
using, but once that is done you can:

  - Store the length inside a data structure
  - Pass it around between different functions
  - Compare it to other lengths
  - Add and subtract it to other lengths
  - Multiply it by another length to get an area, or divide by a duration to
    get a speed

...and much more, all without having to care about units at all. All
calculations will be done in an internally consistent way, and when you finally
need to actually display a value on screen or encode to JSON, you can extract
the final result in whatever units you want.

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

Assuming you have [installed Elm](https://guide.elm-lang.org/install.html) and
started a new project, you can install `elm-units` by running

```
elm install ianmackenzie/elm-units
```

in a command prompt inside your project directory.

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

Special support is provided for working with rates of change:

```elm
-- How far do we go if we drive for 2 minutes
-- at 15 meters per second?

-- Divide length by duration to get speed
-- (equivalent to 'Speed.metersPerSecond 15')
speed =
    Length.meters 30 |> Quantity.per (Duration.seconds 2)

-- Multiply duration by speed to get length (distance)
Duration.minutes 2 -- duration
  |> Quantity.at speed -- length per duration
  |> Length.inKilometers -- gives us a length!
--> 1.8

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

-- Reverse engineer the speed of light from defined
-- lengths/durations ('one light year per year')
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
pixelDensity =
    Pixels.pixels 96 |> Quantity.per (Length.inches 1)

Length.centimeters 3 -- length
    |> Quantity.at pixelDensity -- pixels per length
    |> Pixels.inPixels -- gives us pixels!
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
    an independent quantity value to get a dependent quantity value; for example,
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
**@ianmackenzie** on all three =)

## API

[Full API documentation][10] is available.

## Contributing

Yes please! One of the best ways to contribute is to add a module for a new
quantity type; see [issue #6][7] for details. I'll add a proper CONTRIBUTING.md
at some point, but some brief guidelines in the meantime:

  - Open a pull request by forking this repository, creating a new branch in
    your fork, making all changes in that branch, then opening a pull request
    from that branch.
  - Format code with [`elm-format`][8] 0.8.0.
  - Git commit messages should follow [the seven rules of a great Git commit
    message][9], although I'm not strict about the 50 or 72 character rules.

## License

[BSD-3-Clause © Ian Mackenzie][2]

[1]: https://github.com/ianmackenzie/elm-units/blob/master/doc/CustomUnits.md
[2]: https://github.com/ianmackenzie/elm-units/blob/master/LICENSE
[3]: http://elmlang.herokuapp.com/
[4]: https://discourse.elm-lang.org/
[5]: https://www.reddit.com/r/elm/
[6]: https://en.wikipedia.org/wiki/International_System_of_Units
[7]: https://github.com/ianmackenzie/elm-units/issues/6
[8]: https://github.com/avh4/elm-format
[9]: https://chris.beams.io/posts/git-commit/#seven-rules
[10]: https://package.elm-lang.org/packages/ianmackenzie/elm-units/1.0.0/
