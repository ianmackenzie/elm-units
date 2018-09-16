module Resistance exposing
    ( Ohms
    , Resistance
    , inOhms
    , ohms
    )

import Current exposing (Amperes)
import Quantity exposing (Quantity(..), Rate)
import Voltage exposing (Volts)


type alias Ohms =
    Rate Volts Amperes


type alias Resistance =
    Quantity Float Ohms


ohms : Float -> Resistance
ohms numOhms =
    Quantity numOhms


inOhms : Resistance -> Float
inOhms (Quantity numOhms) =
    numOhms
