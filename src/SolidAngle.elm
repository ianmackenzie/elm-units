module SolidAngle exposing
    ( SolidAngle, Steradians
    , steradians, inSteradians, spats, inSpats, squareDegrees, inSquareDegrees
    )

{-| [Solid angle](https://en.wikipedia.org/wiki/Solid_angle) is a tricky concept
to explain, but roughly speaking solid angle is for 3D what angle is for 2D.
Where angle can be thought of as a fraction of a circle (there are 2π radians in
a circle, and π/2 radians covers a quarter of the circle), solid angle can be
thought of as a fraction of sphere (there are 4π steradians in a sphere, and π
steradians covers a quarter of the surface of a sphere). Solid angle can be used
to measure three-dimensional field of view. It is stored as a number of
[steradians](https://en.wikipedia.org/wiki/Steradian).

@docs SolidAngle, Steradians


## Conversions

@docs steradians, inSteradians, spats, inSpats, squareDegrees, inSquareDegrees

-}

import Quantity exposing (Quantity(..), zero)


{-| -}
type Steradians
    = Steradians


{-| -}
type alias SolidAngle =
    Quantity Float Steradians


{-| Construct a solid angle from a number of
[steradians](https://en.wikipedia.org/wiki/Steradian).
-}
steradians : Float -> SolidAngle
steradians numSteradians =
    Quantity numSteradians


{-| Convert an angle to a number of radians.
-}
inSteradians : SolidAngle -> Float
inSteradians (Quantity numSteradians) =
    numSteradians


{-| Construct a solid angle from a number of [spats][1]. One spat is the 3D
equivalent of one full turn; in the same way that one turn is the angle that
covers an entire circle, one spat is the solid angle that covers an entire
sphere. It's rare to have solid angles more than one spat, since solid angles
are usually used to measure what angular fraction of a full sphere something
covers.

    SolidAngle.spats 1
    --> SolidAngle.steradians (4 * pi)

[1]: https://en.wikipedia.org/wiki/Spat_(unit)

-}
spats : Float -> SolidAngle
spats numSpats =
    steradians (4 * pi * numSpats)


{-| Convert a solid angle to a number of spats.

    SolidAngle.steradians pi |> SolidAngle.inSpats
    --> 0.25

-}
inSpats : SolidAngle -> Float
inSpats solidAngle =
    inSteradians solidAngle / (4 * pi)


{-| Construct a solid angle from a number of [square
degrees](https://en.wikipedia.org/wiki/Square_degree). One square degree is,
roughly speaking, the solid angle of a square on the surface of a sphere where
the square is one degree wide and one degree tall when viewed from the center of
the sphere.

    SolidAngle.squareDegrees 100
    -> SolidAngle.steradians 0.03046

-}
squareDegrees : Float -> SolidAngle
squareDegrees numSquareDegrees =
    steradians (numSquareDegrees * (pi / 180) ^ 2)


{-| Convert a solid angle to a number of square degrees.

    SolidAngle.spats 1 |> SolidAngle.inSquareDegrees
    --> 41252.96125

-}
inSquareDegrees : SolidAngle -> Float
inSquareDegrees solidAngle =
    inSteradians solidAngle / ((pi / 180) ^ 2)
