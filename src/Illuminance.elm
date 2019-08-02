module Illuminance exposing
    ( Illuminance, Lux
    , lux, inLux, footCandles, inFootCandles
    )

{-| [Illuminance][wp-illuminance] is a measure of how much light is striking a
surface: [luminous flux](LuminousFlux) per unit area. It is measured in
[lux][wp-lux].

Illuminance is useful as a measure of how brightly a surface is lit. For
example, on an overcast day, outside surfaces have an illuminance of
approximately 1000 lux; inside an office might be more like 400 lux and under a
full moon might be only 0.2 lux.

[wp-illuminance]: https://en.wikipedia.org/wiki/Illuminance
[wp-lux]: https://en.wikipedia.org/wiki/Lux>

@docs Illuminance, Lux


## Conversions

@docs lux, inLux, footCandles, inFootCandles

-}

import Area exposing (SquareMeters)
import LuminousFlux exposing (Lumens)
import Quantity exposing (Quantity(..), Rate)


{-| -}
type alias Lux =
    Rate Lumens SquareMeters


{-| -}
type alias Illuminance =
    Quantity Float Lux


{-| Construct an illuminance value from a number of lux. One lux is equal to one
lumen per square meter. See [here][wp-lux-illuminance] for a table of
illuminance values in lux for common environments.

[wp-lux-illuminance]: https://en.wikipedia.org/wiki/Lux#Illuminance

-}
lux : Float -> Illuminance
lux numLux =
    Quantity numLux


{-| Convert an illuminance value to a number of lux.
-}
inLux : Illuminance -> Float
inLux (Quantity numLux) =
    numLux


{-| Construct an illuminance value from a number of
[foot-candles][wp-foot-candles]. One foot-candle is equal to one lumen per
square foot.

[wp-foot-candles]: https://en.wikipedia.org/wiki/Foot-candle

-}
footCandles : Float -> Illuminance
footCandles numFootCandles =
    LuminousFlux.lumens numFootCandles |> Quantity.per (Area.squareFeet 1)


{-| Convert an illuminance value to a number of foot-candles.
-}
inFootCandles : Illuminance -> Float
inFootCandles illuminance =
    Area.squareFeet 1 |> Quantity.at illuminance |> LuminousFlux.inLumens
