module Pixels exposing
    ( Pixels, PixelsPerSecond, PixelsPerSecondSquared, SquarePixels
    , pixels, inPixels
    , pixelsPerSecond, inPixelsPerSecond
    , squarePixels, inSquarePixels
    )

{-|

@docs Pixels, PixelsPerSecond, PixelsPerSecondSquared, SquarePixels

@docs pixels, inPixels

@docs pixelsPerSecond, inPixelsPerSecond

@docs squarePixels, inSquarePixels

-}

import Duration exposing (Seconds)
import Quantity exposing (Quantity(..), Rate, Squared)


type Pixels
    = Pixels


type alias PixelsPerSecond =
    Rate Pixels Seconds


type alias PixelsPerSecondSquared =
    Rate PixelsPerSecond Seconds


type alias SquarePixels =
    Squared Pixels


{-| Construct a quantity representing a given number of pixels:

    screenWidth =
        pixels 1920

Note that passing an `Int` will give you a

    Quantity Int Pixels

while passing a `Float` will give you a

    Quantity Float Pixels

If you pass a _literal_ integer like `1920`, the result can be used as either an
`Int` _or_ `Float` number of pixels.

-}
pixels : number -> Quantity number Pixels
pixels numPixels =
    Quantity numPixels


inPixels : Quantity number Pixels -> number
inPixels (Quantity numPixels) =
    numPixels


pixelsPerSecond : Float -> Quantity Float PixelsPerSecond
pixelsPerSecond numPixelsPerSecond =
    Quantity numPixelsPerSecond


inPixelsPerSecond : Quantity Float PixelsPerSecond -> Float
inPixelsPerSecond (Quantity numPixelsPerSecond) =
    numPixelsPerSecond


pixelsPerSecondSquared : Float -> Quantity Float PixelsPerSecondSquared
pixelsPerSecondSquared numPixelsPerSecondSquared =
    Quantity numPixelsPerSecondSquared


inPixelsPerSecondSquared : Quantity Float PixelsPerSecondSquared -> Float
inPixelsPerSecondSquared (Quantity numPixelsPerSecondSquared) =
    numPixelsPerSecondSquared


squarePixels : number -> Quantity number SquarePixels
squarePixels numSquarePixels =
    Quantity numSquarePixels


inSquarePixels : Quantity number SquarePixels -> number
inSquarePixels (Quantity numSquarePixels) =
    numSquarePixels
