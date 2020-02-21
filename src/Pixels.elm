module Pixels exposing
    ( Pixels, PixelsPerSecond, PixelsPerSecondSquared, SquarePixels
    , pixels, inPixels, pixel
    , pixelsPerSecond, inPixelsPerSecond
    , pixelsPerSecondSquared, inPixelsPerSecondSquared
    , squarePixels, inSquarePixels
    )

{-| Although most of the focus of `elm-units` is on physical/scientific units,
it's very useful to be able to safely convert back and forth between (for
example) [`Length`](Length) values in the real world and on-screen lengths in
pixels. This module provides a standard `Pixels` units type and basic functions
for constructing/converting values of type `Quantity number Pixels`, which
allows you to do things like represent conversions between real-world and
on-screen lengths as [rates of change][1]. This in turn means that all the
normal `Quantity` functions can be used to convert between pixels and other
units, or even do type-safe math directly on pixel values.

[1]: Quantity#working-with-rates

@docs Pixels, PixelsPerSecond, PixelsPerSecondSquared, SquarePixels

@docs pixels, inPixels, pixel

@docs pixelsPerSecond, inPixelsPerSecond

@docs pixelsPerSecondSquared, inPixelsPerSecondSquared

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


{-| Construct a quantity representing a given number of on-screen pixels:

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


{-| Convert a `Pixels` value to a plain number of pixels.

    pixelDensity =
        pixels 96 |> Quantity.per (Length.inches 1)

    Length.centimeters 1
        |> Quantity.at pixelDensity
        |> inPixels
    --> 37.795275590551185

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
        pixels 2

    dragSpeed =
        dragDistance |> Quantity.per elapsedTime

    dragSpeed |> inPixelsPerSecond
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
        pixels 1920 |> Quantity.times (pixels 1080)

    area |> inSquarePixels
    --> 2073600

-}
inSquarePixels : Quantity number SquarePixels -> number
inSquarePixels (Quantity numSquarePixels) =
    numSquarePixels
