module Pixels exposing
    ( Pixels
    , int, float, toInt, toFloat, pixels, inPixels, pixel
    , PixelsPerSecond, PixelsPerSecondSquared
    , pixelsPerSecond, inPixelsPerSecond
    , pixelsPerSecondSquared, inPixelsPerSecondSquared
    , SquarePixels
    , squarePixels, inSquarePixels
    )

{-| Although most of the focus of `elm-units` is on physical/scientific units,
it's often useful to be able to safely convert back and forth between (for
example) [`Length`](Length) values in the real world and on-screen lengths in
pixels.

This module provides a standard `Pixels` units type and basic functions for
constructing/converting values of type `Quantity Int Pixels` or
`Quantity Float Pixels`, which allows you to do things like represent
conversions between real-world and on-screen lengths as [rates of change][1].
This in turn means that all the normal [`Quantity`](Quantity) functions can be
used to convert between pixels and other units, or even do type-safe math
directly on pixel values.

[1]: Quantity#working-with-rates

@docs Pixels

@docs int, float, toInt, toFloat, pixels, inPixels, pixel


## Rates

@docs PixelsPerSecond, PixelsPerSecondSquared

@docs pixelsPerSecond, inPixelsPerSecond

@docs pixelsPerSecondSquared, inPixelsPerSecondSquared


## Areas

@docs SquarePixels

@docs squarePixels, inSquarePixels

-}

import Duration exposing (Seconds)
import Quantity exposing (Quantity(..), Rate, Squared)


{-| Units type representing one on-screen pixel.
-}
type Pixels
    = Pixels


{-| Units type representing an on-screen speed of one pixel per second.
-}
type alias PixelsPerSecond =
    Rate Pixels Seconds


{-| Units type representing an on-screen acceleration of one pixel per second
squared.
-}
type alias PixelsPerSecondSquared =
    Rate PixelsPerSecond Seconds


{-| Units type representing an on-screen area of one square pixel. For example,
a 32x32 image has an area of 1024 square pixels.
-}
type alias SquarePixels =
    Squared Pixels


{-| Construct a quantity representing an integer number of on-screen pixels:

    screenWidth =
        Pixels.int 1920

-}
int : Int -> Quantity Int Pixels
int numPixels =
    Quantity numPixels


{-| Construct a quantity representing a floating-point number of on-screen
pixels:

    lineWeight =
        Pixels.float 1.5

-}
float : Float -> Quantity Float Pixels
float numPixels =
    Quantity numPixels


{-| Convert an integer number of pixels back into a plain `Int`:

    Pixels.int 1920
        |> Quantity.multiplyBy 2
        |> Pixels.toInt
    --> 3840

-}
toInt : Quantity Int Pixels -> Int
toInt (Quantity numPixels) =
    numPixels


{-| Convert a floating-point number of pixels back into a plain `Float`:

    pixelDensity =
        Pixels.float 96 |> Quantity.per (Length.inches 1)

    Length.centimeters 1
        |> Quantity.at pixelDensity
        |> Pixels.toFloat
    --> 37.795275590551185

-}
toFloat : Quantity Float Pixels -> Float
toFloat (Quantity numPixels) =
    numPixels


{-| Generic version of `Pixels.int`/`Pixels.float`, for consistency with other
modules like `Length`. Note that passing an `Int` will give you a

    Quantity Int Pixels

while passing a `Float` will give you a

    Quantity Float Pixels

If you pass a _literal_ integer like `1920`, you will get a generic `Quantity
number Pixels` which can be used as either an `Int` _or_ `Float` number of
pixels.

-}
pixels : number -> Quantity number Pixels
pixels numPixels =
    Quantity numPixels


{-| Convert a `Pixels` value to a plain number of pixels. This is a generic
version of `Pixels.toInt`/`Pixels.toFloat`.
-}
inPixels : Quantity number Pixels -> number
inPixels (Quantity numPixels) =
    numPixels


{-| Shorthand for `Pixels.pixels 1`. Can be convenient to use with
[`Quantity.per`](Quantity#per).
-}
pixel : Quantity number Pixels
pixel =
    pixels 1


{-| Construct an on-screen speed from a number of pixels per second.
-}
pixelsPerSecond : Float -> Quantity Float PixelsPerSecond
pixelsPerSecond numPixelsPerSecond =
    Quantity numPixelsPerSecond


{-| Convert an on-screen speed to a number of pixels per second.

    elapsedTime =
        Duration.milliseconds 16

    dragDistance =
        Pixels.float 2

    dragSpeed =
        dragDistance |> Quantity.per elapsedTime

    dragSpeed |> Pixels.inPixelsPerSecond
    --> 125

-}
inPixelsPerSecond : Quantity Float PixelsPerSecond -> Float
inPixelsPerSecond (Quantity numPixelsPerSecond) =
    numPixelsPerSecond


{-| Construct an on-screen acceleration from a number of pixels per second
squared.
-}
pixelsPerSecondSquared : Float -> Quantity Float PixelsPerSecondSquared
pixelsPerSecondSquared numPixelsPerSecondSquared =
    Quantity numPixelsPerSecondSquared


{-| Convert an on-screen acceleration to a number of pixels per second squared.
-}
inPixelsPerSecondSquared : Quantity Float PixelsPerSecondSquared -> Float
inPixelsPerSecondSquared (Quantity numPixelsPerSecondSquared) =
    numPixelsPerSecondSquared


{-| Construct an on-screen area from a number of square pixels.
-}
squarePixels : number -> Quantity number SquarePixels
squarePixels numSquarePixels =
    Quantity numSquarePixels


{-| Convert an on-screen area to a number of square pixels.

    area =
        Pixels.int 1928 |> Quantity.times (Pixels.int 1080)

    area |> Pixels.inSquarePixels
    --> 2073600

-}
inSquarePixels : Quantity number SquarePixels -> number
inSquarePixels (Quantity numSquarePixels) =
    numSquarePixels
