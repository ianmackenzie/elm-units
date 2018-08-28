module Resistance exposing
    ( Ohms
    , Resistance
    , inOhms
    , ohms
    )

import Current exposing (Amperes)
import Quantity exposing (Fractional, Quantity(..), Quotient)
import Voltage exposing (Volts)


type alias Ohms =
    Quotient Volts Amperes


type alias Resistance =
    Fractional Ohms


ohms : Float -> Resistance
ohms numOhms =
    Quantity numOhms


inOhms : Resistance -> Float
inOhms (Quantity numOhms) =
    numOhms
