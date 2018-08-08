module Pixels
    exposing
        ( PixelUnits
        , Pixels
        , inPixels
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
