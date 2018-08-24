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

import Quantity exposing (Fractional, Quantity(..), Whole)


type Cents
    = Cents Never


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


inDollars : Fractional Cents -> Float
inDollars (Quantity numCents) =
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
