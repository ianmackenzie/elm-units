module Voltage exposing
    ( Voltage, Volts
    , volts, inVolts
    )

{-| A `Voltage` value represents a voltage (electric potential difference, if
we're being picky) in volts.

@docs Voltage, Volts

@docs volts, inVolts

-}

import Current exposing (Amperes)
import Power exposing (Watts)
import Quantity exposing (Quantity(..), Rate)


{-| -}
type alias Volts =
    Rate Watts Amperes


{-| -}
type alias Voltage =
    Quantity Float Volts


{-| Construct a voltage from a number of volts.
-}
volts : Float -> Voltage
volts numVolts =
    Quantity numVolts


{-| Convert a voltage to a number of volts.
-}
inVolts : Voltage -> Float
inVolts (Quantity numVolts) =
    numVolts
