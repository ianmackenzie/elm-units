module Charge exposing
    ( Charge, Coulombs
    , coulombs, inCoulombs, ampereHours, inAmpereHours, milliampereHours, inMilliampereHours
    )

{-| A `Charge` value represents an electrical charge in coulombs or ampere
hours. It is stored as a number of coulombs.

@docs Charge, Coulombs


## Conversions

@docs coulombs, inCoulombs, ampereHours, inAmpereHours, milliampereHours, inMilliampereHours

-}

import Constants
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
    coulombs (Constants.hour * numAmpereHours)


{-| Convert a charge to a number of ampere hours.
-}
inAmpereHours : Charge -> Float
inAmpereHours charge =
    inCoulombs charge / Constants.hour


{-| Construct a charge from a number of milliampere hours.
-}
milliampereHours : Float -> Charge
milliampereHours numMilliampereHours =
    coulombs (Constants.hour * numMilliampereHours / 1000)


{-| Convert a charge to a number of milliampere hours.
-}
inMilliampereHours : Charge -> Float
inMilliampereHours charge =
    inCoulombs charge * 1000 / Constants.hour
