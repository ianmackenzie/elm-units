module Force exposing
    ( Force, Newtons
    , newtons, inNewtons, kilonewtons, inKilonewtons, meganewtons, inMeganewtons
    , pounds, inPounds, kips, inKips
    )

{-| A `Force` value represents a force in newtons, pounds force etc. It is
stored as a number of newtons.

Note that since `Newtons` is defined as `Product Kilograms
MetersPerSecondSquared`, you can compute force directly as a product of mass and
acceleration:

    mass =
        Mass.kilograms 10

    acceleration =
        Acceleration.metersPerSecondSquared 2

    mass |> Quantity.times acceleration
    --> Force.newtons 20

@docs Force, Newtons


## Metric

@docs newtons, inNewtons, kilonewtons, inKilonewtons, meganewtons, inMeganewtons


## Imperial

@docs pounds, inPounds, kips, inKips

-}

import Acceleration exposing (MetersPerSecondSquared)
import Mass exposing (Kilograms)
import Quantity exposing (Product, Quantity(..))


{-| -}
type alias Newtons =
    Product Kilograms MetersPerSecondSquared


{-| -}
type alias Force =
    Quantity Float Newtons


{-| Construct a force value from a number of newtons.
-}
newtons : Float -> Force
newtons numNewtons =
    Quantity numNewtons


{-| Convert a force value to a number of newtons.
-}
inNewtons : Force -> Float
inNewtons (Quantity numNewtons) =
    numNewtons


{-| Construct a force value from a number of kilonewtons.
-}
kilonewtons : Float -> Force
kilonewtons numKilonewtons =
    newtons (1000 * numKilonewtons)


{-| Convert a force value to a number of kilonewtons.
-}
inKilonewtons : Force -> Float
inKilonewtons force =
    inNewtons force / 1000


{-| Construct a force value from a number of meganewtons.
-}
meganewtons : Float -> Force
meganewtons numMeganewtons =
    newtons (1.0e6 * numMeganewtons)


{-| Convert a force value to a number of meganewtons.
-}
inMeganewtons : Force -> Float
inMeganewtons force =
    inNewtons force / 1.0e6


{-| Construct a force value from a number of pounds force. One pound force is
the force required to accelerate one [pound mass][1] at a rate of [one gee][2].

[1]: Mass#pounds
[2]: Acceleration#gees

-}
pounds : Float -> Force
pounds numPounds =
    newtons (4.4482216152605 * numPounds)


{-| Convert a force value to a number of pounds force.
-}
inPounds : Force -> Float
inPounds force =
    inNewtons force / 4.4482216152605


{-| Construct a force value from a number of kips (kilopounds force).

    Force.kips 2
    --> Force.pounds 2000

-}
kips : Float -> Force
kips numKips =
    pounds (1000 * numKips)


{-| Convert a force value to a number of kips.
-}
inKips : Force -> Float
inKips force =
    inPounds force / 1000
