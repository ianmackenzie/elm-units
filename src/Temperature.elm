module Temperature
    exposing
        ( Temperature
        , celsius
        , fahrenheit
        , inCelsius
        , inFahrenheit
        , inKelvins
        , kelvins
        )

import Quantity exposing (Quantity(..))


type alias Temperature =
    Quantity.Temperature


kelvins : Float -> Temperature
kelvins numKelvins =
    Quantity numKelvins


inKelvins : Temperature -> Float
inKelvins (Quantity numKelvins) =
    numKelvins


celsius : Float -> Temperature
celsius numDegreesCelsius =
    kelvins (273.15 + numDegreesCelsius)


inCelsius : Temperature -> Float
inCelsius temperature =
    inKelvins temperature - 273.15


fahrenheit : Float -> Temperature
fahrenheit numDegreesFahrenheit =
    celsius ((numDegreesFahrenheit - 32) / 1.8)


inFahrenheit : Temperature -> Float
inFahrenheit temperature =
    32 + 1.8 * inCelsius temperature
