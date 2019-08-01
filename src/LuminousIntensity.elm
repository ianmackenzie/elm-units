module LuminousIntensity exposing
    ( Candelas, LuminousIntensity
    , candelas, inCandelas
    )

{-| [Luminous intensity][wp-luminous-intensity] is a measure of the amount of
light produced ([luminous flux](LuminousFlux)) per unit [solid
angle](SolidAngle).

Consider a light bulb that emits light in all directions and a spotlight that
only emits light in a cone. If both lights had the same luminous flux (same
total amount of light produced), then the spotlight would have higher luminous
intensity since its light is concentrated into a smaller solid angle (and the
light from the spotlight would appear brighter if viewed from the same
distance).

On the other hand, if both lights had the same luminous intensity, then they
would appear equally bright when viewed from the same distance (something lit by
the spotlight would appear equally bright as the same object lit by the light
bulb) but the spotlight would have lower luminous flux since its light covers a
smaller solid angle.

Luminous intensity is measured in [candelas][wp-candelas].

[wp-luminous-intensity]: https://en.wikipedia.org/wiki/Luminous_intensity
[wp-candelas]: https://en.wikipedia.org/wiki/Candela

@docs Candelas, LuminousIntensity

@docs candelas, inCandelas

-}

import LuminousFlux exposing (Lumens)
import Quantity exposing (Quantity(..), Rate)
import SolidAngle exposing (Steradians)


{-| -}
type alias Candelas =
    Rate Lumens Steradians


{-| -}
type alias LuminousIntensity =
    Quantity Float Candelas


{-| Construct a luminous intensity value from a number of candelas. One candela
is roughly equivalent to the luminous intensity of a single wax candle.
-}
candelas : Float -> LuminousIntensity
candelas numCandelas =
    Quantity numCandelas


{-| Convert a luminous intensity to a number of candelas. For example, to
compute the luminous intensity of a light bulb with an output of 470 lumens
which emits light equally in all directions:

    LuminousFlux.lumens 470
        |> Quantity.per (SolidAngle.spats 1)
        |> LuminousIntensity.inCandelas
    --> 37.4014

If the same amount of light was emitted over a hemisphere instead of a full
sphere, the luminous intensity would be twice as great:

    LuminousFlux.lumens 470
        |> Quantity.per (SolidAngle.spats 0.5)
        |> LuminousIntensity.inCandelas
    --> 74.8028

-}
inCandelas : LuminousIntensity -> Float
inCandelas (Quantity numCandelas) =
    numCandelas
