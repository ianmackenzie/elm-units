module Point2d
    exposing
        ( Point2d
        , coordinates
        , distanceFrom
        , fromCoordinates
        , origin
        )

import Length exposing (Length)
import Quantity exposing (Quantity(..))


type Point2d space
    = Point2d ( Length space, Length space )


origin : Point2d space
origin =
    fromCoordinates ( Quantity.zero, Quantity.zero )


fromCoordinates : ( Length space, Length space ) -> Point2d space
fromCoordinates coordinates_ =
    Point2d coordinates_


coordinates : Point2d space -> ( Length space, Length space )
coordinates (Point2d coordinates_) =
    coordinates_


distanceFrom : Point2d space -> Point2d space -> Length space
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
