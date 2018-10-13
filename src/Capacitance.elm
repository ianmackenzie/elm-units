module Capacitance exposing
    ( Capacitance, Farads
    , farads, inFarads, picofarads, inPicofarads
    , inMicrofarads, inNanofarads, microfarads, nanofarads
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

@docs farads, inFarads, picofarads, inPicofarads

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


{-| Construct capacitance from a number of farads.
-}
farads : Float -> Capacitance
farads numFarads =
    Quantity numFarads


{-| Convert capacitance to a number of farads.
-}
inFarads : Capacitance -> Float
inFarads (Quantity numFarads) =
    numFarads


{-| Construct a capacitance from a number of microfarads.
-}
microfarads : Float -> Capacitance
microfarads numMicrofarads =
    farads (numMicrofarads * 1.0e-6)


{-| Convert a capacitance to a number of microfarads
-}
inMicrofarads : Capacitance -> Float
inMicrofarads capacitance =
    inFarads capacitance / 1.0e-6


{-| Construct a capacitance from a number of nanofarads
-}
nanofarads : Float -> Capacitance
nanofarads numNanofarads =
    farads (numNanofarads * 1.0e-9)


{-| Convert a capacitance to a number of nanofarads
-}
inNanofarads : Capacitance -> Float
inNanofarads capacitance =
    inFarads capacitance / 1.0e-9


{-| Construct capacitance from a number of picofarads.
-}
picofarads : Float -> Capacitance
picofarads numPicofarads =
    farads (numPicofarads * 1.0e-12)


{-| Convert a capacitance to a number of picofarads.
-}
inPicofarads : Capacitance -> Float
inPicofarads capacitance =
    inFarads capacitance / 1.0e-12
