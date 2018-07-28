module Angle
    exposing
        ( Angle
        , degrees
        , inDegrees
        , inRadians
        , inTurns
        , perDegree
        , perRadian
        , perTurn
        , radians
        , turns
        )

import Basics exposing ((*), (/), pi)
import Quantity exposing (Quantity(..), Radians, Rate)


type alias Angle =
    Quantity.Angle


radians : Float -> Angle
radians numRadians =
    Quantity numRadians


inRadians : Angle -> Float
inRadians (Quantity numRadians) =
    numRadians


degrees : Float -> Angle
degrees numDegrees =
    radians (pi * (numDegrees / 180))


inDegrees : Angle -> Float
inDegrees angle =
    180 * (inRadians angle / pi)


turns : Float -> Angle
turns numTurns =
    radians (2 * pi * numTurns)


inTurns : Angle -> Float
inTurns angle =
    inRadians angle / (2 * pi)


perDegree : Quantity units -> Quantity (Rate units Radians)
perDegree quantity =
    Quantity.per (degrees 1) quantity


perRadian : Quantity units -> Quantity (Rate units Radians)
perRadian quantity =
    Quantity.per (radians 1) quantity


perTurn : Quantity units -> Quantity (Rate units Radians)
perTurn quantity =
    Quantity.per (turns 1) quantity
