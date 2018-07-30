module Pixels
    exposing
        ( PixelUnits
        , Pixels
        , inPixels
        , perPixel
        , pixels
        )

import Quantity exposing (Quantity(..), Rate)


type PixelUnits
    = PixelUnits


type alias Pixels =
    Quantity PixelUnits


pixels : Float -> Pixels
pixels numPixels =
    Quantity numPixels


inPixels : Pixels -> Float
inPixels (Quantity numPixels) =
    numPixels


perPixel : Quantity units -> Quantity (Rate units PixelUnits)
perPixel quantity =
    Quantity.per (pixels 1) quantity
