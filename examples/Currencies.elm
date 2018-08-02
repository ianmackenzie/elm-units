module Currencies exposing (..)

import Quantity exposing (Quantity(..), Rate)


type Euros
    = Euros Never


type Usd
    = Usd Never


euros : Float -> Quantity Euros
euros numEuros =
    Quantity numEuros


inEuros : Quantity Euros -> Float
inEuros (Quantity numEuros) =
    numEuros


perEuro : Quantity units -> Quantity (Rate units Euros)
perEuro quantity =
    Quantity.per (euros 1) quantity


usd : Float -> Quantity Usd
usd numUsd =
    Quantity numUsd


inUsd : Quantity Usd -> Float
inUsd (Quantity numUsd) =
    numUsd


perUsd : Quantity units -> Quantity (Rate units Usd)
perUsd quantity =
    Quantity.per (usd 1) quantity
