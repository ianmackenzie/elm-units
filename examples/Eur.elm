module Eur exposing (..)

import Quantity exposing (Quantity(..), Rate)


type Cents
    = Cents Never


type alias Eur number =
    Quantity number Cents


amount : number -> number -> Eur number
amount numEuros numCents =
    Quantity (numEuros * 100 + numCents)


cents : number -> Eur number
cents numCents =
    Quantity numCents


inCents : Eur number -> number
inCents (Quantity numCents) =
    numCents


euros : number -> Eur number
euros numEuros =
    Quantity (100 * numEuros)


inEuros : Eur Float -> Float
inEuros (Quantity numCents) =
    numCents / 100


roundToNearestCent : Eur Float -> Eur Int
roundToNearestCent (Quantity numCents) =
    Quantity (round numCents)


roundDownToNearestCent : Eur Float -> Eur Int
roundDownToNearestCent (Quantity numCents) =
    Quantity (floor numCents)


roundUpToNearestCent : Eur Float -> Eur Int
roundUpToNearestCent (Quantity numCents) =
    Quantity (ceiling numCents)
