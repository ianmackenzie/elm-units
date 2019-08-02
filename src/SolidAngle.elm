module SolidAngle exposing
    ( SolidAngle, Steradians
    , steradians, inSteradians, spats, inSpats, squareDegrees, inSquareDegrees
    , conical, pyramidal
    )

{-| [Solid angle](https://en.wikipedia.org/wiki/Solid_angle) is a tricky concept
to explain, but roughly speaking solid angle is for 3D what angle is for 2D. It
can be used to measure three-dimensional field of view and is stored in
[steradians](https://en.wikipedia.org/wiki/Steradian).

2D angle can be thought of as how much circumference of the unit circle is
covered. The unit circle (circle of radius 1) has a circumference of 2π, and an
angle in radians corresponds to the corresponding amount of circumference
covered. So an angle of 2π radians covers the entire circumference of the
circle, π radians covers half the circle, π/2 radians covers a quarter, etc.

Similarly, 3D solid angle can be thought of as how much surface area of the unit
sphere is covered. The unit sphere has surface area of 4π, and a solid angle in
steradians corresponds to the corresponding amount of surface area covered. So a
solid angle of 4π steradians covers the entire sphere, 2π steradians covers half
the sphere (one hemisphere), etc.

@docs SolidAngle, Steradians


## Conversions

@docs steradians, inSteradians, spats, inSpats, squareDegrees, inSquareDegrees


## Computation

@docs conical, pyramidal

-}

import Angle exposing (Angle)
import Quantity exposing (Quantity(..), zero)


{-| -}
type Steradians
    = Steradians


{-| -}
type alias SolidAngle =
    Quantity Float Steradians


{-| Construct a solid angle from a number of steradians.
-}
steradians : Float -> SolidAngle
steradians numSteradians =
    Quantity numSteradians


{-| Convert a solid angle to a number of steradians.
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

    SolidAngle.steradians (2 * pi) |> SolidAngle.inSpats
    --> 0.5

-}
inSpats : SolidAngle -> Float
inSpats solidAngle =
    inSteradians solidAngle / (4 * pi)


{-| Construct a solid angle from a number of [square
degrees](https://en.wikipedia.org/wiki/Square_degree). One square degree is,
roughly speaking, the solid angle of a square on the surface of a sphere where
the square is one degree wide and one degree tall as viewed from the center of
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


{-| Find the solid angle of a cone with a given tip angle (the angle between two
opposite sides of the cone, _not_ the half-angle from the axis of the cone to
its side). A 1 degree cone has a solid angle of approximately π/4 square
degrees, similar to how a circle of diameter 1 has an area of π/4:

    SolidAngle.conical (Angle.degrees 1)
        |> SolidAngle.inSquareDegrees
    --> 0.78539318

    pi / 4
    --> 0.78539816

A cone with a tip angle of 180 degrees is just a hemisphere:

    SolidAngle.conical (Angle.degrees 180)
    --> SolidAngle.spats 0.5

"Inside out" cones are also supported, up to 360 degrees (a full sphere):

    SolidAngle.conical (Angle.degrees 270)
    --> SolidAngle.spats 0.85355

    SolidAngle.conical (Angle.degrees 360)
    --> SolidAngle.spats 1

-}
conical : Angle -> SolidAngle
conical angle =
    let
        halfAngle =
            Quantity.half angle
    in
    steradians (2 * pi * (1 - Angle.cos halfAngle))


{-| Find the solid angle of a rectangular pyramid given the angles between the
two pairs of sides. A 1 degree by 1 degree pyramid has a solid angle of almost
exactly 1 square degree:

    SolidAngle.pyramidal
        (Angle.degrees 1)
        (Angle.degrees 1)
    --> SolidAngle.squareDegrees 0.9999746

In general, the solid angle of a pyramid that is _n_ degrees wide by _m_ degrees
tall is (for relatively small values of _n_ and _m_) approximately _nm_ square
degrees:

    SolidAngle.pyramidal
        (Angle.degrees 10)
        (Angle.degrees 10)
    --> SolidAngle.squareDegrees 99.7474

    SolidAngle.pyramidal
        (Angle.degrees 60)
        (Angle.degrees 30)
    --> SolidAngle.squareDegrees 1704.08

A pyramid that is 180 degrees by 180 degrees covers an entire hemisphere:

    SolidAngle.pyramidal
        (Angle.degrees 180)
        (Angle.degrees 180)
    --> SolidAngle.spats 0.5

"Inside out" pyramids greater than 180 degrees are not supported and will be
treated as the corresponding "normal" pyramid (an angle of 240 degrees will be
treated as 120 degrees, an angle of 330 degrees will be treated as 30 degrees,
etc.).

-}
pyramidal : Angle -> Angle -> SolidAngle
pyramidal theta phi =
    let
        halfTheta =
            Quantity.half theta

        halfPhi =
            Quantity.half phi
    in
    steradians (4 * asin (Angle.sin halfTheta * Angle.sin halfPhi))
