module Quantity exposing
    ( Quantity(..), Whole, Fractional
    , Squared, Rate
    , zero, toFractional
    , lessThan, greaterThan, compare, equalWithin, max, min
    , negate, plus, minus, product, ratio, scaleBy, abs, clamp, squared, sqrt
    , sum, minimum, maximum, sort
    , per, times, at, at_, invert
    , Unitless, int, toInt, float, toFloat
    )

{-|


# Quantity types

@docs Quantity, Whole, Fractional


# Unit types

The `Squared` and `Rate` units types allow you to build up and work with
composite units in a fairly flexible way.

@docs Squared, Rate


# Basics

@docs zero, toFractional


# Comparison

@docs lessThan, greaterThan, compare, equalWithin, max, min


# Arithmetic

@docs negate, plus, minus, product, ratio, scaleBy, abs, clamp, squared, sqrt


# List functions

@docs sum, minimum, maximum, sort


# Working with rates

@docs per, times, at, at_, invert


# Unitless quantities

It is sometimes be useful to be able to represent _unitless_ quantities,
especially when working with generic code (in most other cases, it is likely
simpler and easier to just use `Int` or `Float` values directly). All the
conversions in this section simply wrap or unwrap a `Float` or `Int` value into
a `Quantity` value, and so should get compiled away entirely when using `elm
make --optimize`.

@docs Unitless, int, toInt, float, toFloat

-}

-- Quantity types


{-| A `Quantity` is effectively a `number` (an `Int` or `Float`) tagged with a
`units` type. So a

    Quantity Float Meters

is a `Float` number of `Meters` and a

    Quantity Int Pixels

is an `Int` number of \`Pixels. When compiling with

    elm make --optimize

the `Quantity` wrapper type will be compiled away, so the runtime performance
should be the same as just using a raw `Float` or `Int`.

-}
type Quantity number units
    = Quantity number


{-| The `Whole` type alias provides a convenient shorthand for referring an
`Int` number of a particular unit;

    Whole Pixels

is equivalent to

    Quantity Int Pixels

-}
type alias Whole units =
    Quantity Int units


{-| The `Fractional` type alias provides a convenient shorthand for referring an
`Int` number of a particular unit;

    Fractional Meters

is equivalent to

    Quantity Float Meters

-}
type alias Fractional units =
    Quantity Float units



-- Units types


{-| Represents a units type that is the square of some other units type; for
example `Meters` is one units type (the type of a `Length`) and `Squared Meters`
is another (the type of an `Area`). This is useful because some functions in
this module (specifically `product`, `squared`, and `sqrt`) "know" about the
`Squared` type and how to work with it. For example, the type signature of
`Quantity.squared` is

    squared :
        Quantity number units
        -> Quantity number (Squared units)

which means that it takes an arguments in some `units` type and produces a
result in `Squared units` (regardless of what those base `units` are!).
`Quantity.sqrt` then has the type signature

    sqrt : Fractional (Squared units) -> Fractional units

which means that it takes a (floating-point) argument in `Squared units` for
some `units` type, and produces a result in the original `units`. This means
that you could write a 2D hypotenuse function that worked on _any_ units type as

    hypot : Fractional units -> Fractional units -> Fractional units
    hypot x y =
        Quantity.sqrt <|
            Quantity.sum
                [ Quantity.squared x
                , Quantity.squared y
                ]

since each list item is in `Squared units`, so the sum will also be in `Squared
units`, which `Quantity.sqrt` then turns back into `units`.

-}
type Squared units
    = Squared units


{-| Represents a rate or quotient such as a speed (`Rate Meters Seconds`) or a
pressure (`Rate Newtons SquareMeters`). As with `squared`, there are several
functions that "know" about the `Rate` type and how to work with it - see the
[Working with rates](#working-with-rates) section for details.
-}
type Rate dependentUnits independentUnits
    = Rate dependentUnits independentUnits



-- Basics


{-| Construct a zero-valued quantity. This can be treated as either an `Int` or
`Float` quantity in any units type, similar to how `Nothing` can be treated as
any kind of `Maybe` type and `[]` can be treated as any kind of `List`.
-}
zero : Quantity number units
zero =
    Quantity 0


{-| Convert an `Int`-valued `Quantity` to a `Float`-valued one. The actual value
will be unchanged.
-}
toFractional : Whole units -> Fractional units
toFractional (Quantity value) =
    Quantity (Basics.toFloat value)



-- Comparison


lessThan : Quantity number units -> Quantity number units -> Bool
lessThan (Quantity y) (Quantity x) =
    x < y


greaterThan : Quantity number units -> Quantity number units -> Bool
greaterThan (Quantity y) (Quantity x) =
    x > y


compare : Quantity number units -> Quantity number units -> Order
compare (Quantity x) (Quantity y) =
    Basics.compare x y


equalWithin : Quantity number units -> Quantity number units -> Quantity number units -> Bool
equalWithin (Quantity tolerance) (Quantity x) (Quantity y) =
    Basics.abs (x - y) <= tolerance


max : Quantity number units -> Quantity number units -> Quantity number units
max (Quantity x) (Quantity y) =
    Quantity (Basics.max x y)


min : Quantity number units -> Quantity number units -> Quantity number units
min (Quantity x) (Quantity y) =
    Quantity (Basics.min x y)



-- Arithmetic


negate : Quantity number units -> Quantity number units
negate (Quantity value) =
    Quantity -value


plus : Quantity number units -> Quantity number units -> Quantity number units
plus (Quantity y) (Quantity x) =
    Quantity (x + y)


minus : Quantity number units -> Quantity number units -> Quantity number units
minus (Quantity y) (Quantity x) =
    Quantity (x - y)


product : Quantity number units -> Quantity number units -> Quantity number (Squared units)
product (Quantity x) (Quantity y) =
    Quantity (x * y)


ratio : Fractional units -> Fractional units -> Float
ratio (Quantity x) (Quantity y) =
    x / y


scaleBy : number -> Quantity number units -> Quantity number units
scaleBy scale (Quantity value) =
    Quantity (scale * value)


abs : Quantity number units -> Quantity number units
abs (Quantity value) =
    Quantity (Basics.abs value)


clamp : Quantity number units -> Quantity number units -> Quantity number units -> Quantity number units
clamp (Quantity lower) (Quantity upper) (Quantity value) =
    Quantity (Basics.clamp lower upper value)


squared : Quantity number units -> Quantity number (Squared units)
squared (Quantity value) =
    Quantity (value * value)


sqrt : Fractional (Squared units) -> Fractional units
sqrt (Quantity value) =
    Quantity (Basics.sqrt value)



-- List functions


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



-- Working with rates


per : Fractional independentUnits -> Fractional dependentUnits -> Fractional (Rate dependentUnits independentUnits)
per (Quantity independentValue) (Quantity dependentValue) =
    Quantity (dependentValue / independentValue)


times : Fractional independentUnits -> Fractional (Rate dependentUnits independentUnits) -> Fractional dependentUnits
times (Quantity independentValue) (Quantity rate) =
    Quantity (rate * independentValue)


at : Fractional (Rate dependentUnits independentUnits) -> Fractional independentUnits -> Fractional dependentUnits
at (Quantity rate) (Quantity independentValue) =
    Quantity (rate * independentValue)


at_ : Fractional (Rate dependentUnits independentUnits) -> Fractional dependentUnits -> Fractional independentUnits
at_ (Quantity rate) (Quantity dependentValue) =
    Quantity (dependentValue / rate)


invert : Fractional (Rate dependentUnits independentUnits) -> Fractional (Rate independentUnits dependentUnits)
invert (Quantity rate) =
    Quantity (1 / rate)



-- Unitless quantities


{-| A special units type representing 'no units'. A `Whole Unitless` value is
interchangeable with a simple `Int`, and a `Fractional Unitless` value is
interchangeable with a simple `Float`.
-}
type Unitless
    = Unitless


{-| Convert a plain `Int` into a `Whole Unitless` value.
-}
int : Int -> Whole Unitless
int value =
    Quantity value


{-| Convert a `Whole Unitless` value into a plain `Int`.
-}
toInt : Whole Unitless -> Int
toInt (Quantity value) =
    value


{-| Convert a plain `Float` into a `Fractional Unitless` value.
-}
float : Float -> Fractional Unitless
float value =
    Quantity value


{-| Convert a `Fractional Unitless` value into a plain `Float`.
-}
toFloat : Fractional Unitless -> Float
toFloat (Quantity value) =
    value
