module Luminance exposing
    ( Luminance, Nits
    , nits, inNits, footLamberts, inFootLamberts
    )

{-| [Luminance][wp-luminance] is [luminous intensity](LuminousIntensity) per
unit area or equivalently [illuminance](Illuminance) per [solid
angle](SolidAngle), and is measured in [nits][wp-nits] (or, to use standard SI
terminology, candelas per square meter - the two terms are equivalent).
Luminance is often used to describe the brightness of a particular surface as
viewed from a particular direction; for example, a computer monitor might be
described as having a brightness of 300 nits (but that would likely only be true
when viewing straight on instead of at an angle). See [here][wp-luminance-values]
for some common approximate luminance values.

[wp-luminance]: https://en.wikipedia.org/wiki/Luminance
[wp-nits]: https://en.wikipedia.org/wiki/Candela_per_square_metre
[wp-luminance-values]: https://en.wikipedia.org/wiki/Orders_of_magnitude_(luminance)

@docs Luminance, Nits


## Conversions

@docs nits, inNits, footLamberts, inFootLamberts

-}

import Area exposing (SquareMeters)
import LuminousIntensity exposing (Candelas)
import Quantity exposing (Quantity(..), Rate)


{-| -}
type alias Nits =
    Rate Candelas SquareMeters


{-| -}
type alias Luminance =
    Quantity Float Nits


{-| Construct a luminance value from a number of nits. One nit is equal to one
[candela](LuminousIntensity) per square meter, or equivalently one
[lux](Illuminance) per [steradian](SolidAngle).
-}
nits : Float -> Luminance
nits numNits =
    Quantity numNits


{-| Convert a luminance value to a number of nits.
-}
inNits : Luminance -> Float
inNits (Quantity numNits) =
    numNits


{-| Construct a luminance value from a number of
[foot-lamberts][wp-foot-lambert].

[wp-foot-lambert]: https://en.wikipedia.org/wiki/Foot-lambert

-}
footLamberts : Float -> Luminance
footLamberts numFootLamberts =
    LuminousIntensity.candelas numFootLamberts
        |> Quantity.per (Area.squareFeet pi)


{-| Convert a luminance value to a number of foot-lamberts.
-}
inFootLamberts : Luminance -> Float
inFootLamberts luminance =
    Area.squareFeet pi
        |> Quantity.at luminance
        |> LuminousIntensity.inCandelas
