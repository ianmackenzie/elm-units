module Point3d
    exposing
        ( Point3d
        , coordinates
        , distanceFrom
        , fromCoordinates
        , origin
        )

import Quantity exposing (Quantity(..))


type Point3d units
    = Point3d ( Quantity Float units, Quantity Float units, Quantity Float units )


origin : Point3d units
origin =
    fromCoordinates ( Quantity.zero, Quantity.zero, Quantity.zero )


fromCoordinates : ( Quantity Float units, Quantity Float units, Quantity Float units ) -> Point3d units
fromCoordinates coordinates_ =
    Point3d coordinates_


coordinates : Point3d units -> ( Quantity Float units, Quantity Float units, Quantity Float units )
coordinates (Point3d coordinates_) =
    coordinates_


distanceFrom : Point3d units -> Point3d units -> Quantity Float units
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
