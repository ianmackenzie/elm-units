module Temperature exposing
    ( Kelvins
    , Temperature
    , celsius
    , clamp
    , compare
    , degreesCelsius
    , degreesFahrenheit
    , difference
    , fahrenheit
    , fromAbsolute
    , greaterThan
    , inCelsius
    , inDegreesCelsius
    , inDegreesFahrenheit
    , inFahrenheit
    , inKelvins
    , kelvins
    , lessThan
    , max
    , maximum
    , min
    , minimum
    , sort
    , toAbsolute
    )

import Quantity exposing (Fractional, Quantity(..), Rate)


{-| Kelvins are the standard unit of temperature.
-}
type Kelvins
    = Kelvins Never


type Temperature
    = Temperature Float


kelvins : Float -> Fractional Kelvins
kelvins numKelvins =
    Quantity numKelvins


inKelvins : Fractional Kelvins -> Float
inKelvins (Quantity numKelvins) =
    numKelvins


celsius : Float -> Temperature
celsius temperatureInCelsius =
    Temperature (273.15 + temperatureInCelsius)


inCelsius : Temperature -> Float
inCelsius (Temperature temperatureInKelvins) =
    temperatureInKelvins - 273.15


fahrenheit : Float -> Temperature
fahrenheit temperatureInFahrenheit =
    celsius ((temperatureInFahrenheit - 32) / 1.8)


inFahrenheit : Temperature -> Float
inFahrenheit temperature =
    32 + 1.8 * inCelsius temperature


toAbsolute : Temperature -> Fractional Kelvins
toAbsolute (Temperature temperatureInKelvins) =
    kelvins temperatureInKelvins


fromAbsolute : Fractional Kelvins -> Temperature
fromAbsolute quantity =
    Temperature (inKelvins quantity)


degreesCelsius : Float -> Fractional Kelvins
degreesCelsius numDegreesCelsius =
    kelvins numDegreesCelsius


inDegreesCelsius : Fractional Kelvins -> Float
inDegreesCelsius quantity =
    inKelvins quantity


degreesFahrenheit : Float -> Fractional Kelvins
degreesFahrenheit numDegreesFahrenheit =
    kelvins (numDegreesFahrenheit / 1.8)


inDegreesFahrenheit : Fractional Kelvins -> Float
inDegreesFahrenheit quantity =
    inKelvins quantity * 1.8



-- Math with Temperature values


lessThan : Temperature -> Temperature -> Bool
lessThan (Temperature y) (Temperature x) =
    x < y


greaterThan : Temperature -> Temperature -> Bool
greaterThan (Temperature y) (Temperature x) =
    x > y


clamp : Temperature -> Temperature -> Temperature -> Temperature
clamp (Temperature lower) (Temperature upper) (Temperature temperature) =
    Temperature (Basics.clamp lower upper temperature)


compare : Temperature -> Temperature -> Order
compare (Temperature x) (Temperature y) =
    Basics.compare x y


min : Temperature -> Temperature -> Temperature
min (Temperature x) (Temperature y) =
    Temperature (Basics.min x y)


max : Temperature -> Temperature -> Temperature
max (Temperature x) (Temperature y) =
    Temperature (Basics.max x y)


difference : Temperature -> Temperature -> Fractional Kelvins
difference (Temperature x) (Temperature y) =
    kelvins (x - y)


minimum : List Temperature -> Maybe Temperature
minimum temperatures =
    case temperatures of
        first :: rest ->
            Just (List.foldl min first rest)

        [] ->
            Nothing


maximum : List Temperature -> Maybe Temperature
maximum temperatures =
    case temperatures of
        first :: rest ->
            Just (List.foldl max first rest)

        [] ->
            Nothing


sort : List Temperature -> List Temperature
sort temperatures =
    List.sortWith compare temperatures
