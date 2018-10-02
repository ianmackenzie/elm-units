module Charge exposing
    ( Charge, Coulombs
    , coulombs, inCoulombs, ampereHours, inAmpereHours, milliampereHours, inMilliampereHours
    )

{-| A `Charge` value represents an electrical charge in coulombs or ampere
hours. It is stored as a number of coulombs.

@docs Charge, Coulombs

@docs coulombs, inCoulombs, ampereHours, inAmpereHours, milliampereHours, inMilliampereHours

-}

import Quantity exposing (Quantity(..))


{-| -}
type Coulombs
    = Coulombs


{-| -}
type alias Charge =
    Quantity Float Coulombs


{-| Construct a charge from a number of coulombs.
-}
coulombs : Float -> Charge
coulombs numCoulombs =
    Quantity numCoulombs


{-| Convert a charge to a number of coulombs.
-}
inCoulombs : Charge -> Float
inCoulombs (Quantity numCoulombs) =
    numCoulombs


{-| Construct a charge from a number of ampere hours.
-}
ampereHours : Float -> Charge
ampereHours numAmpereHours =
    coulombs (3600 * numAmpereHours)


{-| Convert a charge to a number of ampere hours.
-}
inAmpereHours : Charge -> Float
inAmpereHours charge =
    inCoulombs charge / 3600


{-| Construct a charge from a number of milliampere hours.
-}
milliampereHours : Float -> Charge
milliampereHours numMilliampereHours =
    coulombs (3.6 * numMilliampereHours)


{-| Convert a charge to a number of milliampere hours.
-}
inMilliampereHours : Charge -> Float
inMilliampereHours charge =
    inCoulombs charge / 3.6
