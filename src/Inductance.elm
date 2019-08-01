module Inductance exposing
    ( Inductance, Henries(..)
    , henries, inHenries
    , nanohenries, inNanohenries, microhenries, inMicrohenries, millihenries, inMillihenries, kilohenries, inKilohenries
    )

{-| A `Inductance` value represents an electrical inductance in henries.

@docs Inductance, Henries


## Conversions

@docs henries, inHenries
@docs nanohenries, inNanohenries, microhenries, inMicrohenries, millihenries, inMillihenries, kilohenries, inKilohenries

-}

import Current exposing (Amperes)
import Duration exposing (Seconds)
import Quantity exposing (Quantity(..), Rate)
import Voltage exposing (Volts)


{-| -}
type Henries
    = Rate Volts (Rate Amperes Seconds)


{-| -}
type alias Inductance =
    Quantity Float Henries


{-| Construct an inductance from a number of henries.
-}
henries : Float -> Inductance
henries numHenries =
    Quantity numHenries


{-| Convert an inductance to a number of henries.
-}
inHenries : Inductance -> Float
inHenries (Quantity numHneries) =
    numHneries


{-| Construct an inductance from a number of millihenries.
-}
millihenries : Float -> Inductance
millihenries numMilliHenries =
    henries (numMilliHenries * 1.0e-3)


{-| Convert an inductance to a number of millihenries.
-}
inMillihenries : Inductance -> Float
inMillihenries inductance =
    inHenries inductance / 1.0e-3


{-| Construct an inductance from a number of microhenries.
-}
microhenries : Float -> Inductance
microhenries numMicroHenries =
    henries (numMicroHenries * 1.0e-6)


{-| Convert an inductance to a number of microhenries.
-}
inMicrohenries : Inductance -> Float
inMicrohenries inductance =
    inHenries inductance / 1.0e-6


{-| Construct an inductance from a number of nanohenries.
-}
nanohenries : Float -> Inductance
nanohenries numNanoHenries =
    henries (numNanoHenries * 1.0e-9)


{-| Convert an inductance to a number of nanohenries.
-}
inNanohenries : Inductance -> Float
inNanohenries inductance =
    inHenries inductance / 1.0e-9


{-| Construct an inductance from a number of kilohenries.
-}
kilohenries : Float -> Inductance
kilohenries numKiloHenries =
    henries (numKiloHenries * 1.0e3)


{-| Convert an inductance to a number of kilohenries.
-}
inKilohenries : Inductance -> Float
inKilohenries inductance =
    inHenries inductance / 1.0e3
