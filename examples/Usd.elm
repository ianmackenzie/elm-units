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


perCent : Quantity Float units -> Rate units Cents
perCent quantity =
    Quantity.per (cents 1) quantity


perDollar : Quantity Float units -> Rate units Cents
perDollar quantity =
    Quantity.per (dollars 1) quantity


roundToNearestCent : Usd Float -> Usd Int
roundToNearestCent (Quantity numCents) =
    Quantity (round numCents)


roundDownToNearestCent : Usd Float -> Usd Int
roundDownToNearestCent (Quantity numCents) =
    Quantity (floor numCents)


roundUpToNearestCent : Usd Float -> Usd Int
roundUpToNearestCent (Quantity numCents) =
    Quantity (ceiling numCents)
