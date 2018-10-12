module Capacitance exposing
    ( Capacitance, Farads
    , farads, inFarads, picoFarads, inPicoFarads
    )

{-| A `Capacitance` value represents an electrical capacitance in farads.

Note that since `Capacitance` is defined as `Rate Coulombs Volts` (charge per voltage),
you can construct a `Capacitance` value using `Quantity.per`:

    capacitance =
        charge |> Quantity.per voltage

You can also compute `Charge` and `Voltage` using `Capacitance`:

    charge =
        capacitance |> Quantity.times voltage

    voltage =
        charge |> Quantity.at_ capacitance

@docs Capacitance, Farads

@docs farads, inFarads, picoFarads, inPicoFarads

-}

import Charge exposing (Coulombs)
import Quantity exposing (Quantity(..), Rate)
import Voltage exposing (Volts)


{-| -}
type Farads
    = Rate Coulombs Volts


{-| -}
type alias Capacitance =
    Quantity Float Farads


{-| Construct capacitance from number of farads.
-}
farads : Float -> Capacitance
farads numFarads =
    Quantity numFarads


{-| Convert capacitance to number of farads
-}
inFarads : Capacitance -> Float
inFarads (Quantity numFarads) =
    numFarads


{-| Construct capacitance from number of farads.
-}
picoFarads : Float -> Capacitance
picoFarads numPicoFarads =
    farads (numPicoFarads * 1.0e-12)


{-| Construct capacitance from number of picofarads.
-}
inPicoFarads : Capacitance -> Float
inPicoFarads capacitance =
    inFarads capacitance / 1.0e-12
