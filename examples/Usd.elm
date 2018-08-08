module Usd exposing (..)

import Quantity exposing (Quantity(..), Rate)


type Cents
    = Cents Never


type alias Usd number =
    Quantity number Cents


amount : number -> number -> Usd number
amount numDollars numCents =
    Quantity (numDollars * 100 + numCents)


cents : number -> Usd number
cents numCents =
    Quantity numCents


inCents : Usd number -> number
inCents (Quantity numCents) =
    numCents


dollars : number -> Usd number
dollars numDollars =
    Quantity (100 * numDollars)


inDollars : Usd Float -> Float
inDollars (Quantity numCents) =
    numCents / 100


roundToNearestCent : Usd Float -> Usd Int
roundToNearestCent (Quantity numCents) =
    Quantity (round numCents)


roundDownToNearestCent : Usd Float -> Usd Int
roundDownToNearestCent (Quantity numCents) =
    Quantity (floor numCents)


roundUpToNearestCent : Usd Float -> Usd Int
roundUpToNearestCent (Quantity numCents) =
    Quantity (ceiling numCents)
