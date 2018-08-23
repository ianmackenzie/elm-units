module CoordinateSystem exposing (CoordinateSystem, Nowhere)


type CoordinateSystem name units
    = CoordinateSystem Never


type alias Nowhere =
    CoordinateSystem Never Never
