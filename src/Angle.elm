module Angle exposing
    ( Angle, Radians
    , radians, inRadians, degrees, inDegrees, turns, inTurns
    , minutes, inMinutes, seconds, inSeconds
    , Sign(..), fromDms, toDms
    , sin, cos, tan, asin, acos, atan, atan2
    , normalize
    , radian, degree, turn, minute, second
    )

{-| An `Angle` represents an angle in degrees, radians, or turns. It is stored
as a number of radians.

@docs Angle, Radians


## Common units

@docs radians, inRadians, degrees, inDegrees, turns, inTurns


## Minutes and seconds

Angles are sometimes measured in degrees, minutes, and seconds, where 1 minute =
1/60th of a degree and 1 second = 1/60th of a minute.

@docs minutes, inMinutes, seconds, inSeconds

Degrees, minutes and seconds are often used together, so a couple of special
functions are provided to convert to and from combinations of those units.

@docs Sign, fromDms, toDms


## Trigonometry

If you're using `Angle` values instead of plain `Float`s, you'll need to use
these functions instead of [the corresponding ones in core][1].

[1]: https://package.elm-lang.org/packages/elm/core/latest/Basics#trigonometry

@docs sin, cos, tan, asin, acos, atan, atan2


## Normalization

@docs normalize


## Constants

Shorthand for `Angle.radians 1`, `Angle.degrees 1` etc. Can be convenient to use
with [`Quantity.per`](Quantity#per).

@docs radian, degree, turn, minute, second

-}

import Quantity exposing (Quantity(..), zero)


{-| -}
type Radians
    = Radians


{-| -}
type alias Angle =
    Quantity Float Radians


{-| Construct an angle from a number of radians.
-}
radians : Float -> Angle
radians numRadians =
    Quantity numRadians


{-| Convert an angle to a number of radians.
-}
inRadians : Angle -> Float
inRadians (Quantity numRadians) =
    numRadians


{-| Construct an angle from a number of degrees.

    Angle.degrees 180
    --> Angle.radians pi

-}
degrees : Float -> Angle
degrees numDegrees =
    radians (pi * (numDegrees / 180))


{-| Convert an angle to a number of degrees.

    Angle.turns 2 |> Angle.inDegrees
    --> 720

-}
inDegrees : Angle -> Float
inDegrees angle =
    180 * (inRadians angle / pi)


{-| Construct an angle from a number of turns.

    Angle.turns -0.25
    --> Angle.degrees -90

-}
turns : Float -> Angle
turns numTurns =
    radians (2 * pi * numTurns)


{-| Convert an angle to a number of turns.

    Angle.radians pi |> Angle.inTurns
    --> 0.5

-}
inTurns : Angle -> Float
inTurns angle =
    inRadians angle / (2 * pi)


{-| Construct an angle from a number of minutes.

    Angle.minutes 30
    --> Angle.degrees 0.5

-}
minutes : Float -> Angle
minutes numMinutes =
    degrees (numMinutes / 60)


{-| Convert an angle to a number of minutes.

    Angle.degrees 2 |> Angle.inMinutes
    --> 120

-}
inMinutes : Angle -> Float
inMinutes angle =
    60 * inDegrees angle


{-| Construct an angle from a number of seconds.

    Angle.seconds 120
    --> Angle.minutes 2

-}
seconds : Float -> Angle
seconds numSeconds =
    degrees (numSeconds / 3600)


{-| Convert an angle to a number of seconds.

    Angle.degrees 0.1 |> Angle.inSeconds
    --> 360

-}
inSeconds : Angle -> Float
inSeconds angle =
    3600 * inDegrees angle


{-| The sign of an angle given in degrees, minutes and seconds.
-}
type Sign
    = Positive
    | Negative


{-| Construct an angle given its sign and its degree, minute and second
components. The signs of `degrees`, `minutes` and `seconds` will be ignored
(their absolute values will be used). Note that only `seconds` may be
fractional! In general `minutes` and `seconds` should each be less than 60, but
this is not enforced.

    Angle.fromDms
        { sign = Angle.Positive
        , degrees = 45
        , minutes = 30
        , seconds = 36
        }
    --> Angle.degrees 45.51

    Angle.fromDms
        { sign = Angle.Negative
        , degrees = 2
        , minutes = 15
        , seconds = 0
        }
    --> Angle.degrees -2.25

-}
fromDms : { sign : Sign, degrees : Int, minutes : Int, seconds : Float } -> Angle
fromDms given =
    let
        absDegrees =
            toFloat (abs given.degrees)
                + (toFloat (abs given.minutes) / 60)
                + (abs given.seconds / 3600)
    in
    case given.sign of
        Positive ->
            degrees absDegrees

        Negative ->
            degrees -absDegrees


{-| Convert an angle to a number of degrees, minutes and seconds, along with its
sign. The `degrees`, `minutes` and `seconds` values will all be non-negative,
and both `minutes` and `seconds` will be less than 60.

    Angle.toDms (Angle.degrees 1.5)
    --> { sign = Angle.Positive
    --> , degrees = 1
    --> , minutes = 30
    --> , seconds = 0
    --> }

    Angle.toDms (Angle.degrees -0.751)
    --> { sign = Angle.Negative
    --> , degrees = 0
    --> , minutes = 45
    --> , seconds = 3.6
    --> }

You could use this to write a string-conversion function for angles, something
like:

    angleString angle =
        let
            { sign, degrees, minutes, seconds } =
                Angle.toDms angle

            signString =
                case sign of
                    Angle.Positive ->
                        ""

                    Angle.Negative ->
                        "-"
        in
        String.concat
            [ signString
            , String.fromInt degrees
            , "° "
            , String.fromInt minutes
            , "′ "
            , Round.round 3 seconds
            , "″"
            ]

(Here we're using the
[myrho/elm-round](https://package.elm-lang.org/packages/myrho/elm-round/latest/)
package to control the number of decimal places used when displaying the number
of seconds.)

-}
toDms : Angle -> { sign : Sign, degrees : Int, minutes : Int, seconds : Float }
toDms angle =
    let
        signedDegrees =
            inDegrees angle

        sign =
            if signedDegrees >= 0 then
                Positive

            else
                Negative

        numDegrees =
            abs signedDegrees

        integerDegrees =
            floor numDegrees

        fractionalDegrees =
            numDegrees - toFloat integerDegrees

        numMinutes =
            fractionalDegrees * 60

        integerMinutes =
            floor numMinutes

        fractionalMinutes =
            numMinutes - toFloat integerMinutes

        numSeconds =
            fractionalMinutes * 60
    in
    { sign = sign
    , degrees = integerDegrees
    , minutes = integerMinutes
    , seconds = numSeconds
    }


{-| -}
sin : Angle -> Float
sin (Quantity angle) =
    Basics.sin angle


{-| -}
cos : Angle -> Float
cos (Quantity angle) =
    Basics.cos angle


{-| -}
tan : Angle -> Float
tan (Quantity angle) =
    Basics.tan angle


{-| -}
asin : Float -> Angle
asin x =
    Quantity (Basics.asin x)


{-| -}
acos : Float -> Angle
acos x =
    Quantity (Basics.acos x)


{-| -}
atan : Float -> Angle
atan x =
    Quantity (Basics.atan x)


{-| -}
atan2 : Quantity Float units -> Quantity Float units -> Angle
atan2 (Quantity y) (Quantity x) =
    Quantity (Basics.atan2 y x)


{-| Convert an arbitrary angle to the equivalent angle in the range -180 to 180
degrees (-π to π radians), by adding or subtracting some multiple of 360
degrees (2π radians) if necessary.

    Angle.normalize (Angle.degrees 45)
    --> Angle.degrees 45

    Angle.normalize (Angle.degrees 270)
    --> Angle.degrees -90

    Angle.normalize (Angle.degrees 370)
    --> Angle.degrees 10

    Angle.normalize (Angle.degrees 181)
    --> Angle.degrees -179

-}
normalize : Angle -> Angle
normalize (Quantity angle) =
    Quantity <|
        clamp -pi pi <|
            (angle - 2 * pi * toFloat (round (angle / (2 * pi))))


{-| -}
radian : Angle
radian =
    radians 1


{-| -}
degree : Angle
degree =
    degrees 1


{-| -}
turn : Angle
turn =
    turns 1


{-| -}
minute : Angle
minute =
    minutes 1


{-| -}
second : Angle
second =
    seconds 1
