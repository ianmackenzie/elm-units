module Resistance exposing
    ( Resistance, Ohms
    , ohms, inOhms
    )

{-| A `Resistance` value represents an electrical resistance in ohms.

@docs Resistance, Ohms

@docs ohms, inOhms

-}

import Current exposing (Amperes)
import Quantity exposing (Quantity(..), Rate)
import Voltage exposing (Volts)


{-| -}
type alias Ohms =
    Rate Volts Amperes


{-| -}
type alias Resistance =
    Quantity Float Ohms


{-| Construct a resistance from a number of ohms.
-}
ohms : Float -> Resistance
ohms numOhms =
    Quantity numOhms


{-| Convert a resistance to a number of ohms.
-}
inOhms : Resistance -> Float
inOhms (Quantity numOhms) =
    numOhms
