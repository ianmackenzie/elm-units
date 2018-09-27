module Force exposing
    ( Force
    , Newtons
    , inKilonewtons
    , inKips
    , inMeganewtons
    , inNewtons
    , inPounds
    , kilonewtons
    , kips
    , meganewtons
    , newtons
    , pounds
    )

import Energy exposing (Joules)
import Length exposing (Meters)
import Quantity exposing (Quantity(..), Rate)


type alias Newtons =
    Rate Joules Meters


type alias Force =
    Quantity Float Newtons


newtons : Float -> Force
newtons numNewtons =
    Quantity numNewtons


inNewtons : Force -> Float
inNewtons (Quantity numNewtons) =
    numNewtons


kilonewtons : Float -> Force
kilonewtons numKilonewtons =
    newtons (1000 * numKilonewtons)


inKilonewtons : Force -> Float
inKilonewtons force =
    inNewtons force / 1000


meganewtons : Float -> Force
meganewtons numMeganewtons =
    newtons (1.0e6 * numMeganewtons)


inMeganewtons : Force -> Float
inMeganewtons force =
    inNewtons force / 1.0e6


pounds : Float -> Force
pounds numPounds =
    newtons (4.4482216152605 * numPounds)


inPounds : Force -> Float
inPounds force =
    inNewtons force / 4.4482216152605


kips : Float -> Force
kips numKips =
    pounds (1000 * numKips)


inKips : Force -> Float
inKips force =
    inPounds force / 1000
