module Quantity exposing
    ( Quantity(..)
    , Squared, Rate
    , zero, infinity, positiveInfinity, negativeInfinity
    , lessThan, greaterThan, compare, equalWithin, max, min, isNaN, isInfinite
    , negate, plus, minus, product, ratio, scaleBy, divideBy, abs, clamp, squared, sqrt
    , round, floor, ceiling, truncate
    , sum, minimum, maximum, sort
    , per, times, at, at_, invert
    , map
    , Unitless, int, toInt, float, toFloat
    )

{-|

@docs Quantity


# Unit types

The `Squared` and `Rate` units types allow you to build up and work with
composite units in a fairly flexible way.

@docs Squared, Rate


# Constants

@docs zero, infinity, positiveInfinity, negativeInfinity


# Comparison

@docs lessThan, greaterThan, compare, equalWithin, max, min, isNaN, isInfinite


# Arithmetic

@docs negate, plus, minus, product, ratio, scaleBy, divideBy, abs, clamp, squared, sqrt


# Rounding

These functions only really make sense for quantities in units like pixels,
cents or game tiles where an `Int` number of units is meaningful. For quantities
like `Length` or `Duration`, it doesn't really make sense to round to an `Int`
value since the underyling base unit is pretty arbitrary - should `round`ing a
`Duration` give you an `Int` number of seconds, milliseconds, or something else?

@docs round, floor, ceiling, truncate


# List functions

These functions act just like the corresponding functions in the built-in `List`
module. They're necessary because the built-in `List.sum` only supports `List
Int` and `List Float`, and `minimum`/`maximum`/`sort` only support built-in
comparable types like `Int`, `Float`, `String` and tuples.

@docs sum, minimum, maximum, sort


# Working with rates

@docs per, times, at, at_, invert


# Mapping

@docs map


# Unitless quantities

It is sometimes be useful to be able to represent _unitless_ quantities,
especially when working with generic code (in most other cases, it is likely
simpler and easier to just use `Int` or `Float` values directly). All the
conversions in this section simply wrap or unwrap a `Float` or `Int` value into
a `Quantity` value, and so should get compiled away entirely when using `elm
make --optimize`.

@docs Unitless, int, toInt, float, toFloat

-}


{-| A `Quantity` is effectively a `number` (an `Int` or `Float`) tagged with a
`units` type. So a

    Quantity Float Meters

is a `Float` number of `Meters` and a

    Quantity Int Pixels

is an `Int` number of `Pixels`. When compiling with `elm make --optimize` the
`Quantity` wrapper type will be compiled away, so the runtime performance should
be comparable to using a raw `Float` or `Int`.

-}
type Quantity number units
    = Quantity number



---------- UNIT TYPES ----------


{-| Represents a units type that is the square of some other units type; for
example, `Meters` is one units type (the units type of a `Length`) and `Squared
Meters` is another (the units type of an `Area`). This is useful because some
functions in this module (specifically [`product`](Quantity#product),
[`squared`](Quantity#squared), and [`sqrt`](Quantity#sqrt)) "know" about the
`Squared` type and how to work with it.
-}
type Squared units
    = Squared units


{-| Represents a rate or quotient such as a speed (`Rate Meters Seconds`) or a
pressure (`Rate Newtons SquareMeters`). As with `Squared`, there are several
functions that "know" about the `Rate` type and how to work with it - see
[Working with rates](Quantity#working-with-rates) for details.
-}
type Rate dependentUnits independentUnits
    = Rate dependentUnits independentUnits



---------- CONSTANTS ----------


{-| A generic zero value. This can be treated as either an `Int` or `Float`
quantity in any units type, similar to how `Nothing` can be treated as any kind
of `Maybe` type and `[]` can be treated as any kind of `List`.
-}
zero : Quantity number units
zero =
    Quantity 0


{-| Alias for `positiveInfinity`.
-}
infinity : Quantity Float units
infinity =
    positiveInfinity


{-| A generic positive infinity value.
-}
positiveInfinity : Quantity Float units
positiveInfinity =
    Quantity (1 / 0)


{-| A generic negative infinity value.
-}
negativeInfinity : Quantity Float units
negativeInfinity =
    Quantity (-1 / 0)



---------- COMPARISON ----------


{-| Check if one quantity is less than another. Note the [argument order](/#argument-order)!

    oneMeter =
        Length.meters 1

    Length.feet 1 |> Quantity.lessThan oneMeter
    --> True

    -- Same as:
    Quantity.lessThan oneMeter (Length.feet 1)
    --> True

    List.filter (Quantity.lessThan oneMeter)
        [ Length.feet 1
        , Length.parsecs 1
        , Length.yards 1
        , Length.lightYears 1
        ]
    --> [ Length.feet 1, Length.yards 1 ]

-}
lessThan : Quantity number units -> Quantity number units -> Bool
lessThan (Quantity y) (Quantity x) =
    x < y


{-| Check if one quantity is greater than another. Note the [argument order](/#argument-order)!

    oneMeter =
        Length.meters 1

    Length.feet 1 |> Quantity.greaterThan oneMeter
    --> False

    -- Same as:
    Quantity.greaterThan oneMeter (Length.feet 1)
    --> False

    List.filter (Quantity.greaterThan oneMeter)
        [ Length.feet 1
        , Length.parsecs 1
        , Length.yards 1
        , Length.lightYears 1
        ]
    --> [ Length.parsecs 1, Length.lightYears 1 ]

-}
greaterThan : Quantity number units -> Quantity number units -> Bool
greaterThan (Quantity y) (Quantity x) =
    x > y


{-| Compare two quantities, returning an [`Order`](https://package.elm-lang.org/packages/elm/core/latest/Basics#Order)
value indicating whether the first is less than, equal to or greater than the
second.

    Quantity.compare (Duration.minutes 90) (Duration.hours 1)
    --> GT

    Quantity.compare (Duration.minutes 60) (Duration.hours 1)
    --> EQ

-}
compare : Quantity number units -> Quantity number units -> Order
compare (Quantity x) (Quantity y) =
    Basics.compare x y


{-| Check if two quantities are equal within a given absolute tolerance. The
given tolerance must be greater than or equal to zero - if it is negative, then
the result will always be false.

    -- 3 feet is 91.44 centimeters or 0.9144 meters

    Quantity.equalWithin (Length.centimeters 10)
        (Length.meters 1)
        (Length.feet 3)
    --> True

    Quantity.equalWithin (Length.centimeters 5)
        (Length.meters 1)
        (Length.feet 3)
    --> False

-}
equalWithin : Quantity number units -> Quantity number units -> Quantity number units -> Bool
equalWithin (Quantity tolerance) (Quantity x) (Quantity y) =
    Basics.abs (x - y) <= tolerance


{-| Find the maximum of two quantities.

    Quantity.max (Duration.hours 2) (Duration.minutes 100)
    --> Duration.hours 2

-}
max : Quantity number units -> Quantity number units -> Quantity number units
max (Quantity x) (Quantity y) =
    Quantity (Basics.max x y)


{-| Find the minimum of two quantities.

    Quantity.min (Duration.hours 2) (Duration.minutes 100)
    --> Duration.minutes 100

-}
min : Quantity number units -> Quantity number units -> Quantity number units
min (Quantity x) (Quantity y) =
    Quantity (Basics.min x y)


{-| Check if a quantity is positive or negative infinity.

    Quantity.isInfinite
        (Length.meters 1
            |> Quantity.per (Duration.seconds 0)
        )
    --> True

    Quantity.isInfinite Quantity.negativeInfinity
    --> True

-}
isInfinite : Quantity Float units -> Bool
isInfinite (Quantity value) =
    Basics.isInfinite value


{-| Check if a quantity's underlying value is NaN (not-a-number).

    Quantity.isNan (Quantity.sqrt (Area.squareMeters -4))

-}
isNaN : Quantity Float units -> Bool
isNaN (Quantity value) =
    Basics.isNaN value



---------- ARITHMETIC ----------


{-| Negate a quantity!

    Quantity.negate (Length.millimeters 10)
    --> Length.millimeters -10

-}
negate : Quantity number units -> Quantity number units
negate (Quantity value) =
    Quantity -value


{-| Add two quantities.

    Length.meters 1 |> Quantity.plus (Length.centimeters 5)
    --> Length.centimeters 105

-}
plus : Quantity number units -> Quantity number units -> Quantity number units
plus (Quantity y) (Quantity x) =
    Quantity (x + y)


{-| Subtract one quantity from another. Note the [argument order](/#argument-order)!

    fifteenMinutes =
        Duration.minutes 15

    Duration.hours 1 |> Quantity.minus fifteenMinutes
    --> Duration.minutes 45

    -- Same as:
    Quantity.minus fifteenMinutes (Duration.hours 1)
    --> Duration.minutes 45

    List.map (Quantity.minus fifteenMinutes)
        [ Duration.hours 1
        , Duration.hours 2
        , Duration.minutes 30
        ]
    --> [ Duration.minutes 45
    --> , Duration.minutes 105
    --> , Duration.minutes 15
    --> ]

-}
minus : Quantity number units -> Quantity number units -> Quantity number units
minus (Quantity y) (Quantity x) =
    Quantity (x - y)


{-| Multiply two quantities with the same `units` together, resulting in a
quantity in `Squared units`.

This works for any units type (which is useful when used with [`sqrt`](Quantity#sqrt)!)
but one special case is worth pointing out. The units type of an [`Area`](Area#Area)
is `SquareMeters`, which is a type alias for `Squared Meters`. This means that
the product of two `Length`s does in fact give you an `Area`:

    Quantity.product
        (Length.meters 2)
        (Length.centimeters 40)
    --> Area.squareMeters 0.8

    -- This is the definition of an acre, I kid you not 😈
    Quantity.product (Length.feet 66) (Length.feet 660)
    --> Area.acres 1

-}
product : Quantity number units -> Quantity number units -> Quantity number (Squared units)
product (Quantity x) (Quantity y) =
    Quantity (x * y)


{-| Find the ratio of two quantities with the same units.

    Quantity.ratio (Length.miles 1) (Length.yards 1)
    --> 1760

-}
ratio : Quantity Float units -> Quantity Float units -> Float
ratio (Quantity x) (Quantity y) =
    x / y


{-| Multiply a `Quantity` by a `number`.

    Quantity.scaleBy 1.5 (Duration.hours 1)
    --> Duration.minutes 90

-}
scaleBy : number -> Quantity number units -> Quantity number units
scaleBy scale (Quantity value) =
    Quantity (scale * value)


{-| Divide a `Quantity` by a `Float`.

    Quantity.divideBy 2 (Duration.hours 1)
    --> Duration.minutes 30

-}
divideBy : Float -> Quantity Float units -> Quantity Float units
divideBy divisor (Quantity value) =
    Quantity (value / divisor)


{-| Get the absolute value of a quantity.

    Quantity.abs (Duration.milliseconds -10)
    --> Duration.milliseconds 10

-}
abs : Quantity number units -> Quantity number units
abs (Quantity value) =
    Quantity (Basics.abs value)


{-| Given a lower and upper bound, clamp a given quantity to within those
bounds. Say you wanted to clamp an angle to be between +/-30 degrees:

    lowerBound =
        Angle.degrees -30

    upperBound =
        Angle.degrees 30

    Quantity.clamp lowerBound upperBound (Angle.degrees 5)
    --> Angle.degrees 5

    -- One radian is approximately 57 degrees
    Quantity.clamp lowerBound upperBound (Angle.radians 1)
    --> Angle.degrees 30

    Quantity.clamp lowerBound upperBound (Angle.turns -0.5)
    --> Angle.degrees -30

-}
clamp : Quantity number units -> Quantity number units -> Quantity number units -> Quantity number units
clamp (Quantity lower) (Quantity upper) (Quantity value) =
    Quantity (Basics.clamp lower upper value)


{-| Square a quantity with some `units`, resulting in a new quantity in
`Squared units`:

    Quantity.squared (Length.meters 5)
    --> Area.squareMeters 25

(See the documentation of [`product`](Quantity#product) for an explanation of
why a squared `Length` does in fact give you an `Area`.)

-}
squared : Quantity number units -> Quantity number (Squared units)
squared (Quantity value) =
    Quantity (value * value)


{-| Take a quantity in `Squared units` and return the square root of that
quantity in plain `units`:

    Quantity.sqrt (Area.hectares 1)
    --> Length.meters 100

Getting fancier, you could write a 2D hypotenuse (magnitude) function that
worked on _any_ quantity type (length, speed, force...) as

    hypotenuse :
        Quantity Float units
        -> Quantity Float units
        -> Quantity Float units
    hypotenuse x y =
        Quantity.sqrt <|
            Quantity.sum
                [ Quantity.squared x
                , Quantity.squared y
                ]

This works because:

  - The `x` and `y` arguments are both in `units`
  - So each list item is in `Squared units`
  - So the sum is also in `Squared units`
  - And calling `sqrt` on something in `Squared units` returns a value back in
    `units`

-}
sqrt : Quantity Float (Squared units) -> Quantity Float units
sqrt (Quantity value) =
    Quantity (Basics.sqrt value)



---------- ROUNDING ----------


{-| Round a `Float`-valued quantity to the nearest `Int`.

    Quantity.round (Pixels.pixels 3.5)
    --> Pixels.pixels 4

-}
round : Quantity Float units -> Quantity Int units
round (Quantity value) =
    Quantity (Basics.round value)


{-| Round a `Float`-valued quantity down to the nearest `Int`.

    Quantity.floor (Pixels.pixels -2.1)
    --> Pixels.pixels -3

-}
floor : Quantity Float units -> Quantity Int units
floor (Quantity value) =
    Quantity (Basics.floor value)


{-| Round a `Float`-valued quantity up to the nearest `Int`.

    Quantity.ceiling (Pixels.pixels 1.2)
    --> Pixels.pixels 2

-}
ceiling : Quantity Float units -> Quantity Int units
ceiling (Quantity value) =
    Quantity (Basics.ceiling value)


{-| Round a `Float`-valued quantity towards zero.

    Quantity.truncate (Pixels.pixels -2.8)
    --> Pixels.pixels -2

-}
truncate : Quantity Float units -> Quantity Int units
truncate (Quantity value) =
    Quantity (Basics.truncate value)



---------- LIST FUNCTIONS ----------


{-| Find the sum of a list of quanties.

    Quantity.sum
        [ Length.meters 1
        , Length.centimeters 2
        , Length.millimeters 3
        ]
    --> Length.meters 1.023

    Quantity.sum []
    --> Quantity.zero

-}
sum : List (Quantity number units) -> Quantity number units
sum quantities =
    List.foldl plus zero quantities


{-| Find the minimum value in a list of quantities. Returns `Nothing` if the
list is empty.

    Quantity.minimum
        [ Mass.kilograms 1
        , Mass.pounds 2
        , Mass.tonnes 3
        ]
    --> Just (Mass.pounds 2)

-}
minimum : List (Quantity number units) -> Maybe (Quantity number units)
minimum quantities =
    case quantities of
        [] ->
            Nothing

        first :: rest ->
            Just (List.foldl min first rest)


{-| Find the maximum value in a list of quantities. Returns `Nothing` if the
list is empty.

    Quantity.maximum
        [ Mass.kilograms 1
        , Mass.pounds 2
        , Mass.tonnes 3
        ]
    --> Just (Mass.tonnes 3)

-}
maximum : List (Quantity number units) -> Maybe (Quantity number units)
maximum quantities =
    case quantities of
        [] ->
            Nothing

        first :: rest ->
            Just (List.foldl max first rest)


unwrap : Quantity number units -> number
unwrap (Quantity value) =
    value


{-| Sort a list of quantities.

    Quantity.sort
        [ Mass.kilograms 1
        , Mass.pounds 2
        , Mass.tonnes 3
        ]
    --> [ Mass.pounds 2
    --> , Mass.kilograms 1
    --> , Mass.tonnes 3
    --> ]

-}
sort : List (Quantity number units) -> List (Quantity number units)
sort quantities =
    List.sortBy unwrap quantities



---------- WORKING WITH RATES ----------


{-| Construct a rate of change by dividing a dependent quantity (numerator) by
an independent quantity (denominator):

    distance =
        Length.miles 1

    time =
        Duration.minutes 1

    speed =
        distance |> Quantity.per time

    speed |> Speed.inMilesPerHour
    --> 60

Note that we could directly use our rate of change value as a `Speed`! That is
because many built-in quantity types are defined as rates of change, for
example:

  - `Speed` is `Length` per `Duration`
  - `Acceleration` is `Speed` per `Duration`
  - `Pressure` is `Force` per `Area`
  - `Power` is `Energy` per `Duration`
  - `Force` is `Energy` per `Length`
  - `Current` is `Charge` per `Duration`
  - `Voltage` is `Power` per `Current`
  - `Resistance` is `Voltage` per `Current`

-}
per : Quantity Float independentUnits -> Quantity Float dependentUnits -> Quantity Float (Rate dependentUnits independentUnits)
per (Quantity independentValue) (Quantity dependentValue) =
    Quantity (dependentValue / independentValue)


{-| Multiply a rate of change by an independent quantity (the denominator in
the rate) to get a total value:

    -- Pressure is Force per Area
    pressure =
        Pressure.kilopascals 10

    area =
        Area.squareMeters 3

    force =
        pressure |> Quantity.times area

    force |> Force.inNewtons
    --> 30000

-}
times : Quantity number independentUnits -> Quantity number (Rate dependentUnits independentUnits) -> Quantity number dependentUnits
times (Quantity independentValue) (Quantity rate) =
    Quantity (rate * independentValue)


{-| Same as `times` but with the argument order flipped, which may read better
in some cases:

    Duration.minutes 30
        |> Quantity.at
            (Speed.kilometersPerHour 100)
    --> Length.kilometers 50

-}
at : Quantity number (Rate dependentUnits independentUnits) -> Quantity number independentUnits -> Quantity number dependentUnits
at (Quantity rate) (Quantity independentValue) =
    Quantity (rate * independentValue)


{-| Given a rate and a _dependent_ value, determine the necessary amount of the
_independent_ value:

    Length.kilometers 75
        |> Quantity.at_
            (Speed.kilometersPerHour 100)
    --> Duration.minutes 45

Where `times` and `at` perform multiplication, `at_` performs division - you
multiply a speed by a duration to get a distance, but you divide a distance by
a speed to get a duration.

-}
at_ : Quantity Float (Rate dependentUnits independentUnits) -> Quantity Float dependentUnits -> Quantity Float independentUnits
at_ (Quantity rate) (Quantity dependentValue) =
    Quantity (dependentValue / rate)


{-| Find the inverse of a given rate. May be useful if you are using a rate to
define a conversion, and want to convert the other way (although consider just
switching from `at` to `at_` or vice versa instead.)
-}
invert : Quantity Float (Rate dependentUnits independentUnits) -> Quantity Float (Rate independentUnits dependentUnits)
invert (Quantity rate) =
    Quantity (1 / rate)



---------- MAPPING ----------


{-| Transform a quantity by applying a function to the underlying value. This is
primarily useful to convert an `Int`-valued quantity into a `Float`-valued one,
using `Quantity.map toFloat`.
-}
map : (number1 -> number2) -> Quantity number1 units -> Quantity number2 units
map function (Quantity value) =
    Quantity (function value)



---------- UNITLESS QUANTITIES ----------


{-| A special units type representing 'no units'. A `Quantity Int Unitless`
value is interchangeable with a simple `Int`, and a `Quantity Float Unitless`
value is interchangeable with a simple `Float`.
-}
type Unitless
    = Unitless


{-| Convert a plain `Int` into a `Quantity Int Unitless` value.
-}
int : Int -> Quantity Int Unitless
int value =
    Quantity value


{-| Convert a `Quantity Int Unitless` value into a plain `Int`.
-}
toInt : Quantity Int Unitless -> Int
toInt (Quantity value) =
    value


{-| Convert a plain `Float` into a `Quantity Float Unitless` value.
-}
float : Float -> Quantity Float Unitless
float value =
    Quantity value


{-| Convert a `Quantity Float Unitless` value into a plain `Float`.
-}
toFloat : Quantity Float Unitless -> Float
toFloat (Quantity value) =
    value
