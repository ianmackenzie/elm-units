module Angle
    exposing
        ( Angle
        , degrees
        , inDegrees
        , inRadians
        , inTurns
        , radians
        , turns
        )

import Basics exposing ((*), (/), pi)
import Quantity exposing (Quantity(..))


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
