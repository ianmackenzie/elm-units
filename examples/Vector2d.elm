module Vector2d
    exposing
        ( Vector2d
        , components
        , for
        , fromComponents
        , magnitude
        , per
        , zero
        )

import Length exposing (LengthUnits)
import Point2d exposing (Point2d)
import Quantity exposing (Fractional, Quantity(..), Quotient, Rate)


type Vector2d units
    = Vector2d ( Fractional units, Fractional units )


zero : Vector2d units
zero =
    fromComponents ( Quantity.zero, Quantity.zero )


fromComponents : ( Fractional units, Fractional units ) -> Vector2d units
fromComponents components_ =
    Vector2d components_


components : Vector2d units -> ( Fractional units, Fractional units )
components (Vector2d components_) =
    components_


magnitude : Vector2d units -> Fractional units
magnitude vector =
    let
        ( Quantity x, Quantity y ) =
            components vector
    in
    Quantity (sqrt (x * x + y * y))


per : Fractional independentUnits -> Vector2d dependentUnits -> Vector2d (Quotient dependentUnits independentUnits)
per independentQuantity vector =
    let
        ( x, y ) =
            components vector
    in
    fromComponents
        ( Quantity.per independentQuantity x
        , Quantity.per independentQuantity y
        )


for : Fractional independentUnits -> Vector2d (Quotient dependentUnits independentUnits) -> Vector2d dependentUnits
for independentQuantity rateVector =
    let
        ( xRate, yRate ) =
            components rateVector
    in
    fromComponents
        ( Quantity.for independentQuantity xRate
        , Quantity.for independentQuantity yRate
        )
