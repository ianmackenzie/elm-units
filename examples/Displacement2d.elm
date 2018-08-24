module Displacement2d exposing
    ( Displacement2d
    , convert
    , from
    )

import Length exposing (LengthUnits)
import Point2d exposing (Point2d)
import Quantity
import Vector2d exposing (Vector2d)


type alias Displacement2d space =
    Vector2d (LengthUnits space)


from : Point2d space -> Point2d space -> Displacement2d space
from startPoint endPoint =
    let
        ( x1, y1 ) =
            Point2d.coordinates startPoint

        ( x2, y2 ) =
            Point2d.coordinates endPoint
    in
    Vector2d.fromComponents
        ( Quantity.difference x2 x1
        , Quantity.difference y2 y1
        )


convert : Length.Conversion sourceSpace destinationSpace -> Displacement2d sourceSpace -> Displacement2d destinationSpace
convert sourceToDestination displacement =
    let
        ( dx, dy ) =
            Vector2d.components displacement
    in
    Vector2d.fromComponents
        ( Length.convert sourceToDestination dx
        , Length.convert sourceToDestination dy
        )
