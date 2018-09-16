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

import Quantity exposing (Quantity(..))


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


inEuros : Quantity Float Cents -> Float
inEuros (Quantity numCents) =
    numCents / 100


roundToNearestCent : Quantity Float Cents -> Quantity Int Cents
roundToNearestCent (Quantity numCents) =
    Quantity (round numCents)


roundDownToNearestCent : Quantity Float Cents -> Quantity Int Cents
roundDownToNearestCent (Quantity numCents) =
    Quantity (floor numCents)


roundUpToNearestCent : Quantity Float Cents -> Quantity Int Cents
roundUpToNearestCent (Quantity numCents) =
    Quantity (ceiling numCents)
