module Temperature
    exposing
        ( Temperature
        , TemperatureUnits
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
        , perDegreeCelsius
        , perDegreeFahrenheit
        , perKelvin
        , sort
        , toAbsolute
        )

import Quantity exposing (Quantity(..), Rate)


type TemperatureUnits
    = Kelvins


type Temperature
    = Temperature Float


kelvins : Float -> Quantity TemperatureUnits
kelvins numKelvins =
    Quantity numKelvins


inKelvins : Quantity TemperatureUnits -> Float
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


toAbsolute : Temperature -> Quantity TemperatureUnits
toAbsolute (Temperature temperatureInKelvins) =
    kelvins temperatureInKelvins


fromAbsolute : Quantity TemperatureUnits -> Temperature
fromAbsolute quantity =
    Temperature (inKelvins quantity)


degreesCelsius : Float -> Quantity TemperatureUnits
degreesCelsius numDegreesCelsius =
    kelvins numDegreesCelsius


inDegreesCelsius : Quantity TemperatureUnits -> Float
inDegreesCelsius quantity =
    inKelvins quantity


degreesFahrenheit : Float -> Quantity TemperatureUnits
degreesFahrenheit numDegreesFahrenheit =
    kelvins (numDegreesFahrenheit / 1.8)


inDegreesFahrenheit : Quantity TemperatureUnits -> Float
inDegreesFahrenheit quantity =
    inKelvins quantity * 1.8


perKelvin : Quantity units -> Quantity (Rate units TemperatureUnits)
perKelvin quantity =
    Quantity.per (kelvins 1) quantity


perDegreeCelsius : Quantity units -> Quantity (Rate units TemperatureUnits)
perDegreeCelsius quantity =
    Quantity.per (degreesCelsius 1) quantity


perDegreeFahrenheit : Quantity units -> Quantity (Rate units TemperatureUnits)
perDegreeFahrenheit quantity =
    Quantity.per (degreesFahrenheit 1) quantity



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


difference : Temperature -> Temperature -> Quantity TemperatureUnits
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
