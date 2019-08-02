module LuminousFlux exposing (Lumens, LuminousFlux, lumens, inLumens)

{-| A `LuminousFlux` value represents the total amount of light emitted by a
light source. You can think of it as roughly "photons per second", although
[it's a bit more complicated than that][wp-luminous-flux].

Luminous flux is stored in [lumens][wp-lumen]. It's often used to describe the
total output of a light bulb; for example, a 50 watt incandescent bulb and a 6
watt LED bulb might each have an output of 400 lumens.

[wp-luminous-flux]: https://en.wikipedia.org/wiki/Luminous_flux
[wp-lumen]: https://en.wikipedia.org/wiki/Lumen_(unit)

@docs Lumens, LuminousFlux, lumens, inLumens

-}

import Quantity exposing (Quantity(..))


{-| -}
type Lumens
    = Lumens


{-| -}
type alias LuminousFlux =
    Quantity Float Lumens


{-| Construct a luminous flux value from a number of lumens. See
[here][wp-luminous-flux-examples] and [here][wp-lumen-lighting] for the number
of lumens emitted by some common light sources.

[wp-luminous-flux-examples]: https://en.wikipedia.org/wiki/Luminous_flux#Examples
[wp-lumen-lighting]: https://en.wikipedia.org/wiki/Lumen_(unit)#Lighting

-}
lumens : Float -> LuminousFlux
lumens numLumens =
    Quantity numLumens


{-| Convert a luminous flux value to a number of lumens.
-}
inLumens : LuminousFlux -> Float
inLumens (Quantity numLumens) =
    numLumens
