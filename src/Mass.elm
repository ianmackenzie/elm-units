module Mass exposing
    ( Kilograms
    , Mass
    , grams
    , inGrams
    , inKilograms
    , inLongTons
    , inOunces
    , inPounds
    , inShortTons
    , inTonnes
    , kilograms
    , longTons
    , ounces
    , pounds
    , shortTons
    , tonnes
    )

import Acceleration exposing (MetersPerSecondSquared)
import Quantity exposing (Quantity(..), Rate)


type Kilograms
    = Kilograms


type alias Mass =
    Quantity Float Kilograms


kilograms : Float -> Mass
kilograms numKilograms =
    Quantity numKilograms


inKilograms : Mass -> Float
inKilograms (Quantity numKilograms) =
    numKilograms


grams : Float -> Mass
grams numGrams =
    kilograms (0.001 * numGrams)


inGrams : Mass -> Float
inGrams mass =
    1000 * inKilograms mass


pounds : Float -> Mass
pounds numPounds =
    kilograms (0.45359237 * numPounds)


inPounds : Mass -> Float
inPounds mass =
    inKilograms mass / 0.45359237


ounces : Float -> Mass
ounces numOunces =
    pounds (0.0625 * numOunces)


inOunces : Mass -> Float
inOunces mass =
    16 * inPounds mass


tonnes : Float -> Mass
tonnes numTonnes =
    kilograms (1000 * numTonnes)


inTonnes : Mass -> Float
inTonnes mass =
    0.001 * inKilograms mass


shortTons : Float -> Mass
shortTons numShortTons =
    pounds (2000 * numShortTons)


inShortTons : Mass -> Float
inShortTons mass =
    inPounds mass / 2000


longTons : Float -> Mass
longTons numLongTons =
    pounds (2240 * numLongTons)


inLongTons : Mass -> Float
inLongTons mass =
    inPounds mass / 2240
