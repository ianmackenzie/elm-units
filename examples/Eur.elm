module Eur exposing
    ( Cents(..)
    , amount
    , cents
    , euros
    , inCents
    , inEuros
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
