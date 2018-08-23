module Point2d exposing
    ( Point2d
    , coordinates
    , distanceFrom
    , fromCoordinates
    , fromTuple
    , origin
    , toTuple
    )

import CoordinateSystem exposing (CoordinateSystem, Nowhere)
import Quantity exposing (Fractional, Quantity(..))


type Point2d coordinateSystem
    = Point2d ( Float, Float )


origin : Point2d (CoordinateSystem name units)
origin =
    fromCoordinates ( Quantity.zero, Quantity.zero )


fromCoordinates : ( Fractional units, Fractional units ) -> Point2d (CoordinateSystem name units)
fromCoordinates ( Quantity x, Quantity y ) =
    Point2d ( x, y )


coordinates : Point2d (CoordinateSystem name units) -> ( Fractional units, Fractional units )
coordinates (Point2d ( x, y )) =
    ( Quantity x, Quantity y )


distanceFrom : Point2d (CoordinateSystem name units) -> Point2d (CoordinateSystem name units) -> Fractional units
distanceFrom p1 p2 =
    let
        ( Quantity x1, Quantity y1 ) =
            coordinates p1

        ( Quantity x2, Quantity y2 ) =
            coordinates p2

        dx =
            x2 - x1

        dy =
            y2 - y1
    in
    Quantity (sqrt (dx * dx + dy * dy))


fromTuple : ( Float, Float ) -> Point2d Nowhere
fromTuple tuple =
    Point2d tuple


toTuple : Point2d Nowhere -> ( Float, Float )
toTuple (Point2d tuple) =
    tuple
