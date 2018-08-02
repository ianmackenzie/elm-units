module Mass
    exposing
        ( Mass
        , MassUnits
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
        , perGram
        , perKilogram
        , perLongTon
        , perOunce
        , perPound
        , perShortTon
        , perTonne
        , pounds
        , shortTons
        , tonnes
        )

import Quantity exposing (Quantity(..), Rate)


type MassUnits
    = Kilograms


type alias Mass =
    Quantity MassUnits


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


perKilogram : Quantity units -> Quantity (Rate units MassUnits)
perKilogram quantity =
    Quantity.per (kilograms 1) quantity


perGram : Quantity units -> Quantity (Rate units MassUnits)
perGram quantity =
    Quantity.per (grams 1) quantity


perPound : Quantity units -> Quantity (Rate units MassUnits)
perPound quantity =
    Quantity.per (pounds 1) quantity


perOunce : Quantity units -> Quantity (Rate units MassUnits)
perOunce quantity =
    Quantity.per (ounces 1) quantity


perTonne : Quantity units -> Quantity (Rate units MassUnits)
perTonne quantity =
    Quantity.per (tonnes 1) quantity


perShortTon : Quantity units -> Quantity (Rate units MassUnits)
perShortTon quantity =
    Quantity.per (shortTons 1) quantity


perLongTon : Quantity units -> Quantity (Rate units MassUnits)
perLongTon quantity =
    Quantity.per (longTons 1) quantity
