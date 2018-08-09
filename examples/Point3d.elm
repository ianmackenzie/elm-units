module Point3d
    exposing
        ( Point3d
        , coordinates
        , distanceFrom
        , fromCoordinates
        , origin
        )

import Length exposing (Length)
import Quantity exposing (Quantity(..))


type Point3d space
    = Point3d ( Length space, Length space, Length space )


origin : Point3d space
origin =
    fromCoordinates ( Quantity.zero, Quantity.zero, Quantity.zero )


fromCoordinates : ( Length space, Length space, Length space ) -> Point3d space
fromCoordinates coordinates_ =
    Point3d coordinates_


coordinates : Point3d space -> ( Length space, Length space, Length space )
coordinates (Point3d coordinates_) =
    coordinates_


distanceFrom : Point3d space -> Point3d space -> Length space
distanceFrom p1 p2 =
    let
        ( Quantity x1, Quantity y1, Quantity z1 ) =
            coordinates p1

        ( Quantity x2, Quantity y2, Quantity z2 ) =
            coordinates p2

        dx =
            x2 - x1

        dy =
            y2 - y1

        dz =
            z2 - z1
    in
    Quantity (sqrt (dx * dx + dy * dy + dz * dz))
