module Voltage exposing
    ( Voltage
    , Volts
    , inVolts
    , volts
    )

import Current exposing (Amperes)
import Power exposing (Watts)
import Quantity exposing (Fractional, Quantity(..), Rate)


type alias Volts =
    Rate Watts Amperes


type alias Voltage =
    Fractional Volts


volts : Float -> Voltage
volts numVolts =
    Quantity numVolts


inVolts : Voltage -> Float
inVolts (Quantity numVolts) =
    numVolts
