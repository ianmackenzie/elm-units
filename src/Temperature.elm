module Temperature exposing
    ( Temperature, Delta, CelsiusDegrees
    , degreesCelsius, inDegreesCelsius, degreesFahrenheit, inDegreesFahrenheit, kelvins, inKelvins, absoluteZero
    , celsiusDegrees, inCelsiusDegrees, fahrenheitDegrees, inFahrenheitDegrees
    , celsiusDegree, fahrenheitDegree
    , lessThan, greaterThan, lessThanOrEqualTo, greaterThanOrEqualTo, compare, equalWithin, min, max
    , plus, minus, clamp
    , minimum, maximum, sort, sortBy
    )

{-| Unlike other modules in `elm-units`, this module contains two different
primary types:

  - `Temperature`, which is not actually a `Quantity` since temperatures don't
    really act like normal quantities. For example, it doesn't make sense to
    add two temperatures or find the ratio between them.
  - `Delta`, which represents the difference between two temperatures. A `Delta`
    _is_ a `Quantity` since it does make sense to add two deltas to get a net
    delta, find the ratio between two deltas (one rise in temperature might be
    twice as much as another rise in temperature), etc.

Since a `Temperature` value is not a `Quantity`, this module exposes specialized
functions for doing the operations on `Temperature` values that _do_ make sense,
such as comparing two temperatures or sorting a list of temperatures. It's also
possible to find the delta from one temperature to another using [`minus`](Temperature#minus),
and then add a `Delta` to a `Temperature` using [`plus`](Temperature#plus).

@docs Temperature, Delta, CelsiusDegrees


# Temperatures

@docs degreesCelsius, inDegreesCelsius, degreesFahrenheit, inDegreesFahrenheit, kelvins, inKelvins, absoluteZero


# Deltas

Following the suggestion mentioned [here](https://en.wikipedia.org/wiki/Celsius#Temperatures_and_intervals),
this module uses (for example) `celsiusDegrees` to indicate a temperature delta
(change in temperature), in contrast to `degreesCelsius` which indicates an
actual temperature.

@docs celsiusDegrees, inCelsiusDegrees, fahrenheitDegrees, inFahrenheitDegrees


## Constants

Shorthand for `Temperature.celsiusDegrees 1` and `Temperature.fahrenheitDegrees
1`. Can be convenient to use with [`Quantity.per`](Quantity#per).

@docs celsiusDegree, fahrenheitDegree


# Comparison

@docs lessThan, greaterThan, lessThanOrEqualTo, greaterThanOrEqualTo, compare, equalWithin, min, max


# Arithmetic

@docs plus, minus, clamp


# List functions

@docs minimum, maximum, sort, sortBy

-}

import Quantity exposing (Quantity(..))


{-| A temperature such as 25 degrees Celsius or 80 degrees Fahrenheit.
-}
type Temperature
    = Temperature Float


{-| A `Delta` represents the difference between two temperatures.
-}
type alias Delta =
    Quantity Float CelsiusDegrees


{-| Tempereature deltas are stored as a number of Celsius degrees.
-}
type CelsiusDegrees
    = CelsiusDegrees



-- Temperatures


{-| Construct a temperature from a number of degrees Celsius.
-}
degreesCelsius : Float -> Temperature
degreesCelsius numDegreesCelsius =
    kelvins (273.15 + numDegreesCelsius)


{-| Convert a temperature to a number of degrees Celsius.
-}
inDegreesCelsius : Temperature -> Float
inDegreesCelsius temperature =
    inKelvins temperature - 273.15


{-| Construct a temperature from a number of degrees Fahrenheit.
-}
degreesFahrenheit : Float -> Temperature
degreesFahrenheit numDegreesFahrenheit =
    degreesCelsius ((numDegreesFahrenheit - 32) / 1.8)


{-| Convert a temperature to a number of degrees Fahrenheit.
-}
inDegreesFahrenheit : Temperature -> Float
inDegreesFahrenheit temperature =
    32 + 1.8 * inDegreesCelsius temperature


{-| Construct a temperature from a number of [kelvins][kelvin].

    Temperature.kelvins 300
    --> Temperature.degreesCelsius 26.85

[kelvin]: https://en.wikipedia.org/wiki/Kelvin "Kelvin"

-}
kelvins : Float -> Temperature
kelvins numKelvins =
    Temperature numKelvins


{-| Convert a temperature to a number of kelvins.

    Temperature.degreesCelsius 0
        |> Temperature.inKelvins
    --> 273.15

-}
inKelvins : Temperature -> Float
inKelvins (Temperature numKelvins) =
    numKelvins


{-| [Absolute zero](https://en.wikipedia.org/wiki/Absolute_zero), equal to zero
kelvins or -273.15 degrees Celsius.

    Temperature.absoluteZero
    --> Temperature.degreesCelsius -273.15

-}
absoluteZero : Temperature
absoluteZero =
    kelvins 0



-- Deltas


{-| Construct a temperature delta from a number of Celsius degrees.
-}
celsiusDegrees : Float -> Delta
celsiusDegrees numCelsiusDegrees =
    Quantity numCelsiusDegrees


{-| Convert a temperature delta to a number of Celsius degrees.
-}
inCelsiusDegrees : Delta -> Float
inCelsiusDegrees (Quantity numCelsiusDegrees) =
    numCelsiusDegrees


{-| Construct a temperature delta from a number of Fahrenheit degrees.

    Temperature.fahrenheitDegrees 36
    --> Temperature.celsiusDegrees 20

-}
fahrenheitDegrees : Float -> Delta
fahrenheitDegrees numFahrenheitDegrees =
    celsiusDegrees (numFahrenheitDegrees / 1.8)


{-| Convert a temperature delta to a number of Fahrenheit degrees.

    Temperature.celsiusDegrees 10
        |> Temperature.inFahrenheitDegrees
    --> 18

-}
inFahrenheitDegrees : Delta -> Float
inFahrenheitDegrees quantity =
    inCelsiusDegrees quantity * 1.8


{-| -}
celsiusDegree : Delta
celsiusDegree =
    celsiusDegrees 1


{-| -}
fahrenheitDegree : Delta
fahrenheitDegree =
    fahrenheitDegrees 1



-- Comparison


{-| Check if one temperature is less than another. Note the [argument order](/#argument-order)!

    roomTemperature =
        Temperature.degreesCelsius 21

    Temperature.degreesFahrenheit 50
        |> Temperature.lessThan roomTemperature
    --> True

    -- Same as:
    Temperature.lessThan roomTemperature
        (Temperature.degreesFahrenheit 50)
    --> True

-}
lessThan : Temperature -> Temperature -> Bool
lessThan (Temperature y) (Temperature x) =
    x < y


{-| Check if one temperature is greater than another. Note the [argument order](/#argument-order)!

    roomTemperature =
        Temperature.degreesCelsius 21

    Temperature.degreesFahrenheit 50
        |> Temperature.greaterThan roomTemperature
    --> False

    -- Same as:
    Temperature.greaterThan roomTemperature
        (Temperature.degreesFahrenheit 50)
    --> False

-}
greaterThan : Temperature -> Temperature -> Bool
greaterThan (Temperature y) (Temperature x) =
    x > y


{-| Check if one temperature is less than or equal to another. Note the
[argument order](/#argument-order)!
-}
lessThanOrEqualTo : Temperature -> Temperature -> Bool
lessThanOrEqualTo (Temperature y) (Temperature x) =
    x <= y


{-| Check if one temperature is greater than or equal to another. Note the
[argument order](/#argument-order)!
-}
greaterThanOrEqualTo : Temperature -> Temperature -> Bool
greaterThanOrEqualTo (Temperature y) (Temperature x) =
    x >= y


{-| Compare two temperatures, returning an [`Order`](https://package.elm-lang.org/packages/elm/core/latest/Basics#Order)
value indicating whether the first is less than, equal to or greater than the
second.

    Temperature.compare
        (Temperature.degreesCelsius 25)
        (Temperature.degreesFahrenheit 75)
    --> GT

    Temperature.compare
        (Temperature.degreesCelsius 25)
        (Temperature.degreesFahrenheit 77)
    --> EQ

(Note that due to floating-point roundoff, you generally shouldn't rely on
temperatures comparing as exactly equal.)

-}
compare : Temperature -> Temperature -> Order
compare (Temperature x) (Temperature y) =
    Basics.compare x y


{-| Check if two temperatures are equal within a given delta tolerance. The
tolerance must be greater than or equal to zero - if it is negative, then the
result will always be false.

    Temperature.equalWithin (Temperature.fahrenheitDegrees 1)
        (Temperature.degreesCelsius 25)
        (Temperature.degreesFahrenheit 75)
    --> False

    Temperature.equalWithin (Temperature.fahrenheitDegrees 3)
        (Temperature.degreesCelsius 25)
        (Temperature.degreesFahrenheit 75)
    --> True

-}
equalWithin : Delta -> Temperature -> Temperature -> Bool
equalWithin (Quantity tolerance) (Temperature x) (Temperature y) =
    Basics.abs (x - y) <= tolerance


{-| Find the minimum of two temperatures.

    Temperature.min
        (Temperature.degreesCelsius 25)
        (Temperature.degreesFahrenheit 75)
    --> Temperature.degreesFahrenheit 75

-}
min : Temperature -> Temperature -> Temperature
min (Temperature x) (Temperature y) =
    Temperature (Basics.min x y)


{-| Find the maximum of two temperatures.

    Temperature.max
        (Temperature.degreesCelsius 25)
        (Temperature.degreesFahrenheit 75)
    --> Temperature.degreesCelsius 25

-}
max : Temperature -> Temperature -> Temperature
max (Temperature x) (Temperature y) =
    Temperature (Basics.max x y)



-- Arithmetic


{-| Add a `Delta` to a `Temperature` to get a new `Temperature`.

    Temperature.degreesCelsius 25
        |> Temperature.plus
            (Temperature.celsiusDegrees 7)
    --> Temperature.degreesCelsius 32

If you want to _subtract_ a `Delta` from a `Temperature`, you can [`negate`](Quantity#negate)
the delta first and then call `plus`.

-}
plus : Delta -> Temperature -> Temperature
plus (Quantity delta) (Temperature temperature) =
    Temperature (temperature + delta)


{-| Subtract one `Temperature` from another to get a `Delta`. Note the [argument
order](/#argument-order)!

    -- 25 degrees Celsius is 77 degrees Fahrenheit
    start =
        Temperature.degreesCelsius 25

    end =
        Temperature.degreesFahrenheit 80

    end |> Temperature.minus start
    --> Temperature.fahrenheitDegrees 3

    start |> Temperature.minus end
    --> Temperature.fahrenheitDegrees -3

-}
minus : Temperature -> Temperature -> Delta
minus (Temperature y) (Temperature x) =
    Quantity (x - y)


{-| Given a lower and upper bound, clamp a given temperature to within those
bounds. Say you wanted to clamp a temperature to be between 18 and 22 degrees
Celsius:

    lowerBound =
        Temperature.degreesCelsius 18

    upperBound =
        Temperature.degreesCelsius 22

    Temperature.degreesCelsius 25
        |> Temperature.clamp lowerBound upperBound
    --> Temperature.degreesCelsius 22

    Temperature.degreesFahrenheit 67 -- approx 19.4 °C
        |> Temperature.clamp lowerBound upperBound
    --> Temperature.degreesFahrenheit 67

    Temperature.absoluteZero
        |> Temperature.clamp lowerBound upperBound
    --> Temperature.degreesCelsius 18

-}
clamp : Temperature -> Temperature -> Temperature -> Temperature
clamp (Temperature lower) (Temperature upper) (Temperature temperature) =
    Temperature (Basics.clamp lower upper temperature)



-- List functions


{-| Find the minimum of a list of temperatures. Returns `Nothing` if the list
is empty.

    Temperature.minimum
        [ Temperature.degreesCelsius 20
        , Temperature.kelvins 300
        , Temperature.degreesFahrenheit 74
        ]
    --> Just (Temperature.degreesCelsius 20)

-}
minimum : List Temperature -> Maybe Temperature
minimum temperatures =
    case temperatures of
        first :: rest ->
            Just (List.foldl min first rest)

        [] ->
            Nothing


{-| Find the maximum of a list of temperatures. Returns `Nothing` if the list
is empty.

    Temperature.maximum
        [ Temperature.degreesCelsius 20
        , Temperature.kelvins 300
        , Temperature.degreesFahrenheit 74
        ]
    --> Just (Temperature.kelvins 300)

-}
maximum : List Temperature -> Maybe Temperature
maximum temperatures =
    case temperatures of
        first :: rest ->
            Just (List.foldl max first rest)

        [] ->
            Nothing


{-| Sort a list of temperatures from lowest to highest.

    Temperature.sort
        [ Temperature.degreesCelsius 20
        , Temperature.kelvins 300
        , Temperature.degreesFahrenheit 74
        ]
    --> [ Temperature.degreesCelsius 20
    --> , Temperature.degreesFahrenheit 74
    --> , Temperature.kelvins 300
    --> ]

-}
sort : List Temperature -> List Temperature
sort temperatures =
    List.sortBy inKelvins temperatures


{-| Sort an arbitrary list of values by a derived `Temperature`. If you had

    rooms =
        [ ( "Lobby", Temperature.degreesCelsius 21 )
        , ( "Locker room", Temperature.degreesCelsius 17 )
        , ( "Rink", Temperature.degreesCelsius -4 )
        , ( "Sauna", Temperature.degreesCelsius 82 )
        ]

then you could sort by temperature with

    Temperature.sortBy Tuple.second rooms
    --> [ ( "Rink", Temperature.degreesCelsius -4 )
    --> , ( "Locker room", Temperature.degreesCelsius 17 )
    --> , ( "Lobby", Temperature.degreesCelsius 21 )
    --> , ( "Sauna", Temperature.degreesCelsius 82 )
    --> ]

-}
sortBy : (a -> Temperature) -> List a -> List a
sortBy toTemperature list =
    let
        comparator first second =
            compare (toTemperature first) (toTemperature second)
    in
    List.sortWith comparator list
