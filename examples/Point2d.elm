module Point2d
    exposing
        ( Point2d
        , coordinates
        , distanceFrom
        , fromCoordinates
        , origin
        )

import Quantity exposing (Quantity(..))


type Point2d units
    = Point2d ( Quantity Float units, Quantity Float units )


origin : Point2d units
origin =
    fromCoordinates ( Quantity.zero, Quantity.zero )


fromCoordinates : ( Quantity Float units, Quantity Float units ) -> Point2d units
fromCoordinates coordinates_ =
    Point2d coordinates_


coordinates : Point2d units -> ( Quantity Float units, Quantity Float units )
coordinates (Point2d coordinates_) =
    coordinates_


distanceFrom : Point2d units -> Point2d units -> Quantity Float units
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
