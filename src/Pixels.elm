module Pixels exposing
    ( Pixels, PixelsPerSecond, PixelsPerSecondSquared, SquarePixels
    , pixels, inPixels
    , roundToNearestPixel
    , pixelsPerSecond, inPixelsPerSecond
    , squarePixels, inSquarePixels
    )

{-|

@docs Pixels, PixelsPerSecond, PixelsPerSecondSquared, SquarePixels

@docs pixels, inPixels

@docs roundToNearestPixel

@docs pixelsPerSecond, inPixelsPerSecond

@docs squarePixels, inSquarePixels

-}

import Duration exposing (Seconds)
import Quantity exposing (Fractional, Quantity(..), Quotient, Squared, Whole)


type Pixels
    = Pixels


type alias PixelsPerSecond =
    Quotient Pixels Seconds


type alias PixelsPerSecondSquared =
    Quotient PixelsPerSecond Seconds


type alias SquarePixels =
    Squared Pixels


{-| Construct a quantity representing a given number of pixels:

    screenWidth =
        pixels 1920

Note that passing an `Int` will give you a

    Quantity Int Pixels

which is equivalent to

    Whole Pixels

while passing a `Float` will give you a

    Quantity Float Pixels

which is equivalent to

    Fractional Pixels

If you pass a _literal_ integer like `1920`, the result can be used as either a
`Fractional` _or_ `Whole` number of pixels.

-}
pixels : number -> Quantity number Pixels
pixels numPixels =
    Quantity numPixels


inPixels : Quantity number Pixels -> number
inPixels (Quantity numPixels) =
    numPixels


roundToNearestPixel : Fractional Pixels -> Whole Pixels
roundToNearestPixel (Quantity numPixels) =
    Quantity (round numPixels)


pixelsPerSecond : Float -> Fractional PixelsPerSecond
pixelsPerSecond numPixelsPerSecond =
    Quantity numPixelsPerSecond


inPixelsPerSecond : Fractional PixelsPerSecond -> Float
inPixelsPerSecond (Quantity numPixelsPerSecond) =
    numPixelsPerSecond


pixelsPerSecondSquared : Float -> Fractional PixelsPerSecondSquared
pixelsPerSecondSquared numPixelsPerSecondSquared =
    Quantity numPixelsPerSecondSquared


inPixelsPerSecondSquared : Fractional PixelsPerSecondSquared -> Float
inPixelsPerSecondSquared (Quantity numPixelsPerSecondSquared) =
    numPixelsPerSecondSquared


squarePixels : number -> Quantity number SquarePixels
squarePixels numSquarePixels =
    Quantity numSquarePixels


inSquarePixels : Quantity number SquarePixels -> number
inSquarePixels (Quantity numSquarePixels) =
    numSquarePixels


roundToNearestSquarePixel : Fractional SquarePixels -> Whole SquarePixels
roundToNearestSquarePixel (Quantity numSquarePixels) =
    Quantity (round numSquarePixels)
