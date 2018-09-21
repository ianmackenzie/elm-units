module Quantity exposing
    ( Quantity(..)
    , Squared, Rate
    , zero
    , lessThan, greaterThan, compare, equalWithin, max, min
    , negate, plus, minus, product, ratio, scaleBy, divideBy, abs, clamp, squared, sqrt
    , round, floor, ceiling
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

@docs zero


# Comparison

@docs lessThan, greaterThan, compare, equalWithin, max, min


# Arithmetic

@docs negate, plus, minus, product, ratio, scaleBy, divideBy, abs, clamp, squared, sqrt


# Rounding

@docs round, floor, ceiling


# List functions

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

is an `Int` number of `Pixels`. When compiling with

    elm make --optimize

the `Quantity` wrapper type will be compiled away, so the runtime performance
should be the same as just using a raw `Float` or `Int`.

-}
type Quantity number units
    = Quantity number



---------- UNIT TYPES ----------


{-| Represents a units type that is the square of some other units type; for
example `Meters` is one units type (the type of a `Length`) and `Squared Meters`
is another (the units type of an `Area`). This is useful because some functions
in this module (specifically `product`, `squared`, and `sqrt`) "know" about the
`Squared` type and how to work with it. For example, the type signature of
`Quantity.squared` is

    squared :
        Quantity number units
        -> Quantity number (Squared units)

which means that it takes an arguments in some `units` type and produces a
result in `Squared units` (regardless of what those base `units` are!).
`Quantity.sqrt` then has the type signature

    sqrt :
        Quantity Float (Squared units)
        -> Quantity Float units

which means that it takes a (floating-point) argument in `Squared units` for
some `units` type, and produces a result in the original `units`. This means
that you could write a 2D hypotenuse function that worked on _any_ units type as

    hypot :
        Quantity Float units
        -> Quantity Float units
        -> Quantity Float units
    hypot x y =
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


{-| Construct a zero-valued quantity. This can be treated as either an `Int` or
`Float` quantity in any units type, similar to how `Nothing` can be treated as
any kind of `Maybe` type and `[]` can be treated as any kind of `List`.
-}
zero : Quantity number units
zero =
    Quantity 0



---------- COMPARISON ----------


{-| Check if one quantity is less than another. Note the [argument order](#argument-order)!

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


{-| Check if one quantity is greater than another. Note the [argument order](#argument-order)!

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


{-| Subtract one quantity from another. Note the [argument order](#argument-order)!

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

    Quantity.product (Length.meters 2) (Length.centimeters 40)
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


{-| Multiply a `Quantity` by a `Float`.

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

-}
squared : Quantity number units -> Quantity number (Squared units)
squared (Quantity value) =
    Quantity (value * value)


{-| Take a quantity in `Squared units` and return the square root of that
quantity in plain `units`:

    Quantity.sqrt (Area.hectares 1)
    --> Length.meters 100

Getting fancier, you could implement a generic [root mean square](https://en.wikipedia.org/wiki/Root_mean_square)
function (that works with any units type) as

    rootMeanSquare : List (Quantity Float units) -> Quantity Float units
    rootMeanSquare values =
        let
            squares =
                List.map Quantity.squared values
        in
        Quantity.sqrt
            (Quantity.sum squares
                |> Quantity.divideBy
                    (toFloat (List.length squares))
            )

-}
sqrt : Quantity Float (Squared units) -> Quantity Float units
sqrt (Quantity value) =
    Quantity (Basics.sqrt value)



---------- ROUNDING ----------


round : Quantity Float units -> Quantity Int units
round (Quantity value) =
    Quantity (Basics.round value)


floor : Quantity Float units -> Quantity Int units
floor (Quantity value) =
    Quantity (Basics.floor value)


ceiling : Quantity Float units -> Quantity Int units
ceiling (Quantity value) =
    Quantity (Basics.ceiling value)



---------- LIST FUNCTIONS ----------


sum : List (Quantity number units) -> Quantity number units
sum quantities =
    List.foldl plus zero quantities


minimum : List (Quantity number units) -> Maybe (Quantity number units)
minimum quantities =
    case quantities of
        [] ->
            Nothing

        first :: rest ->
            Just (List.foldl min first rest)


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


sort : List (Quantity number units) -> List (Quantity number units)
sort quantities =
    List.sortBy unwrap quantities



---------- WORKING WITH RATES ----------


per : Quantity Float independentUnits -> Quantity Float dependentUnits -> Quantity Float (Rate dependentUnits independentUnits)
per (Quantity independentValue) (Quantity dependentValue) =
    Quantity (dependentValue / independentValue)


times : Quantity number independentUnits -> Quantity number (Rate dependentUnits independentUnits) -> Quantity number dependentUnits
times (Quantity independentValue) (Quantity rate) =
    Quantity (rate * independentValue)


at : Quantity number (Rate dependentUnits independentUnits) -> Quantity number independentUnits -> Quantity number dependentUnits
at (Quantity rate) (Quantity independentValue) =
    Quantity (rate * independentValue)


at_ : Quantity Float (Rate dependentUnits independentUnits) -> Quantity Float dependentUnits -> Quantity Float independentUnits
at_ (Quantity rate) (Quantity dependentValue) =
    Quantity (dependentValue / rate)


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
