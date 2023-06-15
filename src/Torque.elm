module Torque exposing
    ( Torque, NewtonMeters
    , newtonMeters, inNewtonMeters
    , poundFeet, inPoundFeet
    )

{-| Torque is the rotational analogue of linear force. It is also referred to as the moment of force
(also abbreviated to moment). It describes the rate of change of angular momentum that would be
imparted to an isolated body.

@docs Torque, NewtonMeters


## Metric

@docs newtonMeters, inNewtonMeters


## Imperial

@docs poundFeet, inPoundFeet

-}

import Constants
import Force exposing (Newtons)
import Length exposing (Meters)
import Quantity exposing (Product, Quantity(..))


{-| NB: You may notice that the type here is exactly the same as for `Energy.Joules`.

This means the type checker will not help you in distinguishing between these units.

-}
type alias NewtonMeters =
    Product Newtons Meters


{-| -}
type alias Torque =
    Quantity Float NewtonMeters


{-| Construct a torque value from a number of newton-meters.
-}
newtonMeters : Float -> Torque
newtonMeters numNewtonMeters =
    Quantity numNewtonMeters


{-| Convert a torque value to a number of newton-meters.
-}
inNewtonMeters : Torque -> Float
inNewtonMeters (Quantity numNewtonMeters) =
    numNewtonMeters


{-| Construct a torque value from a number of pound-feet (sometimes called foot-pounds).
-}
poundFeet : Float -> Torque
poundFeet numPoundFeet =
    newtonMeters (Constants.poundFoot * numPoundFeet)


{-| Convert a torque value to a number of pound-feet (sometimes called foot-pounds).
-}
inPoundFeet : Torque -> Float
inPoundFeet torque =
    inNewtonMeters torque / Constants.poundFoot
