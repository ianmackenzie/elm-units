module Voltage exposing
    ( Voltage
    , Volts
    , inVolts
    , volts
    )

import Current exposing (Amperes)
import Power exposing (Watts)
import Quantity exposing (Quantity(..), Rate)


type alias Volts =
    Rate Watts Amperes


type alias Voltage =
    Quantity Float Volts


volts : Float -> Voltage
volts numVolts =
    Quantity numVolts


inVolts : Voltage -> Float
inVolts (Quantity numVolts) =
    numVolts
