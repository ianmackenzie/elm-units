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


type alias Pixels number =
    Quantity number PixelUnits


pixels : number -> Pixels number
pixels numPixels =
    Quantity numPixels


inPixels : Pixels number -> number
inPixels (Quantity numPixels) =
    numPixels


perPixel : Quantity Float units -> Rate units PixelUnits
perPixel quantity =
    Quantity.per (pixels 1) quantity
