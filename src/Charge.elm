module Charge exposing
    ( Charge
    , Coulombs
    , ampereHours
    , coulombs
    , inAmpereHours
    , inCoulombs
    , inMilliampereHours
    , milliampereHours
    )

import Quantity exposing (Quantity(..))


type Coulombs
    = Coulombs


type alias Charge =
    Quantity Float Coulombs


coulombs : Float -> Charge
coulombs numCoulombs =
    Quantity numCoulombs


inCoulombs : Charge -> Float
inCoulombs (Quantity numCoulombs) =
    numCoulombs


ampereHours : Float -> Charge
ampereHours numAmpereHours =
    coulombs (3600 * numAmpereHours)


inAmpereHours : Charge -> Float
inAmpereHours charge =
    inCoulombs charge / 3600


milliampereHours : Float -> Charge
milliampereHours numMilliampereHours =
    coulombs (3.6 * numMilliampereHours)


inMilliampereHours : Charge -> Float
inMilliampereHours charge =
    inCoulombs charge / 3.6
