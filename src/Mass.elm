module Mass exposing
    ( Mass, Kilograms
    , kilograms, inKilograms, grams, inGrams, metricTons, inMetricTons
    , pounds, inPounds, ounces, inOunces, shortTons, inShortTons, longTons, inLongTons
    )

{-| A `Mass` represents a mass in kilograms, pounds, metric or imperial tons
etc. It is stored as a number of kilograms.

@docs Mass, Kilograms


## Metric

@docs kilograms, inKilograms, grams, inGrams, metricTons, inMetricTons


## Imperial

@docs pounds, inPounds, ounces, inOunces, shortTons, inShortTons, longTons, inLongTons

-}

import Quantity exposing (Quantity(..), Rate)


{-| -}
type Kilograms
    = Kilograms


{-| -}
type alias Mass =
    Quantity Float Kilograms


{-| Construct a mass from a number of kilograms.
-}
kilograms : Float -> Mass
kilograms numKilograms =
    Quantity numKilograms


{-| Convert a mass to a number of kilograms.
-}
inKilograms : Mass -> Float
inKilograms (Quantity numKilograms) =
    numKilograms


{-| Construct a mass from a number of grams.
-}
grams : Float -> Mass
grams numGrams =
    kilograms (0.001 * numGrams)


{-| Convert a mass to a number of grams.
-}
inGrams : Mass -> Float
inGrams mass =
    1000 * inKilograms mass


{-| Construct a mass from a number of pounds.
-}
pounds : Float -> Mass
pounds numPounds =
    kilograms (0.45359237 * numPounds)


{-| Convert a mass to a number of pounds.
-}
inPounds : Mass -> Float
inPounds mass =
    inKilograms mass / 0.45359237


{-| Construct a mass from a number of ounces.
-}
ounces : Float -> Mass
ounces numOunces =
    pounds (0.0625 * numOunces)


{-| Convert a mass to a number of ounces.

    Mass.pounds 1 |> Mass.inOunces
    --> 16

-}
inOunces : Mass -> Float
inOunces mass =
    16 * inPounds mass


{-| Construct a mass from a number of [metric tons][1].

    Mass.metricTons 1
    --> Mass.kilograms 1000

[1]: https://en.wikipedia.org/wiki/Tonne

-}
metricTons : Float -> Mass
metricTons numTonnes =
    kilograms (1000 * numTonnes)


{-| Convert a mass to a number of metric tons.
-}
inMetricTons : Mass -> Float
inMetricTons mass =
    0.001 * inKilograms mass


{-| Construct a mass from a number of [short tons][1]. This is the 'ton'
commonly used in the United States.

    Mass.shortTons 1
    --> Mass.pounds 2000

[1]: https://en.wikipedia.org/wiki/Short_ton

-}
shortTons : Float -> Mass
shortTons numShortTons =
    pounds (2000 * numShortTons)


{-| Convert a mass to a number of short tons.
-}
inShortTons : Mass -> Float
inShortTons mass =
    inPounds mass / 2000


{-| Construct a mass from a number of [long tons][1]. This is the 'ton' commonly
used in the United Kingdom and British Commonwealth.

    Mass.longTons 1
    --> Mass.pounds 2240

[1]: https://en.wikipedia.org/wiki/Long_ton

-}
longTons : Float -> Mass
longTons numLongTons =
    pounds (2240 * numLongTons)


{-| Convert a mass to a number of long tons.
-}
inLongTons : Mass -> Float
inLongTons mass =
    inPounds mass / 2240
