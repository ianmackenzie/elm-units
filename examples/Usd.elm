module Usd exposing
    ( Cents(..)
    , amount
    , cents
    , dollars
    , inCents
    , inDollars
    , roundDownToNearestCent
    , roundToNearestCent
    , roundUpToNearestCent
    )

import Quantity exposing (Quantity(..))


type Cents
    = Cents


amount : number -> number -> Quantity number Cents
amount numDollars numCents =
    Quantity (numDollars * 100 + numCents)


cents : number -> Quantity number Cents
cents numCents =
    Quantity numCents


inCents : Quantity number Cents -> number
inCents (Quantity numCents) =
    numCents


dollars : number -> Quantity number Cents
dollars numDollars =
    Quantity (100 * numDollars)


inDollars : Quantity Float Cents -> Float
inDollars (Quantity numCents) =
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
