module Eur exposing
    ( Cents(..)
    , amount
    , cents
    , euros
    , inCents
    , inEuros
    , roundDownToNearestCent
    , roundToNearestCent
    , roundUpToNearestCent
    )

import Quantity exposing (Fractional, Quantity(..), Whole)


type Cents
    = Cents


amount : number -> number -> Quantity number Cents
amount numEuros numCents =
    Quantity (numEuros * 100 + numCents)


cents : number -> Quantity number Cents
cents numCents =
    Quantity numCents


inCents : Quantity number Cents -> number
inCents (Quantity numCents) =
    numCents


euros : number -> Quantity number Cents
euros numEuros =
    Quantity (100 * numEuros)


inEuros : Fractional Cents -> Float
inEuros (Quantity numCents) =
    numCents / 100


roundToNearestCent : Fractional Cents -> Whole Cents
roundToNearestCent (Quantity numCents) =
    Quantity (round numCents)


roundDownToNearestCent : Fractional Cents -> Whole Cents
roundDownToNearestCent (Quantity numCents) =
    Quantity (floor numCents)


roundUpToNearestCent : Fractional Cents -> Whole Cents
roundUpToNearestCent (Quantity numCents) =
    Quantity (ceiling numCents)
