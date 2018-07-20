# elm-units

This package provides a simple, lightweight way to represent quantities such as
length, duration (elapsed time), and speed:

```elm
height : Length
height =
    Length.feet 6

movieLength : Duration
movieLength =
    Duration.minutes 120

speedLimit : Speed
speedLimit =
    Speed.kilometersPerHour 100
```

It provides a convenient way to convert values between different units:

```elm
Length.inMeters (Length.feet 1)
--> 0.3048

Duration.inSeconds (Duration.hours 3)
--> 10800

Speed.inMetersPerSecond (Speed.milesPerHour 60)
--> 26.8224
```

More importantly, it provides a type-safe way of passing quantities between
functions. This allows different bodies of code to use whatever units they want,
without having to worry about unit mismatches. For example, one module might
implement a function that computes the braking distance for a car given its
current speed and braking deceleration:

```elm
computeBrakingDistance : Speed -> Acceleration -> Length
computeBrakingDistance currentSpeed brakingDeceleration =
    -- Using v_1^2 = v_0^2 + 2ad, solve for d where v_1=0
    let
        v0 =
            Speed.inMetersPerSecond currentSpeed

        a =
            abs (Acceleration.inMetersPerSecondSquared brakingDeceleration)

        d =
            v0 ^ 2 / (2 * a)
    in
    Length.meters d
```

Internally, `computeBrakingDistance` works in SI units (meters, seconds etc.),
but calling code can work with whatever units it wants:

```elm
-- Braking distance for a Nissan Maxima, using data from
-- http://www.batesville.k12.in.us/physics/PhyNet/Mechanics/Kinematics/BrakingDistData.html

brakingDistance : Length
brakingDistance =
    computeBrakingDistance
        (Speed.milesPerHour 60)
        (Acceleration.feetPerSecondSquared 27.3)

Length.inMeters brakingDistance
--> 43.23

Length.inFeet brakingDistance
--> 141.83
```

Note that since `currentSpeed` and `brakingDeceleration` must be turned into
plain `Float` values `v0` and `a` for computation, the _internals_ of
`computeBrakingDistance` must be careful to use units consistently (the compiler
cannot verify that `v0 ^ 2 / (2 * a)` actually evaluates to a length in meters,
for example). However, as long as you can verify the correctness of individual
functions (with code reviews, unit tests etc.), using this package can guarantee
that there are no units mismatches _between_ functions. This allows you to
safely pass values between different functions which may be in different modules
or even different packages.

## Doing math with units

Short answer: you can't, at least not directly.

To keep things simple, this package has no functions to (for example) construct
a `Speed` by dividing a `Length` by a `Direction` (or by multiplying an
`Acceleration` by a `Duration`). Instead, you will have to write code like

```elm
speed =
    Speed.metersPerSecond
        (Length.inMeters length
            / Duration.inSeconds duration
        )
```

Note that this will work properly even if `length` and `duration` are defined
using different units such as

```elm
length =
    Length.feet 10

duration =
    Duration.milliseconds 2500
```

but you do have to have to be careful not to write nonsense code like

```elm
-- BAD!
speed =
    Speed.metersPerSecond
        (Length.inInches length
            / Duration.inHours duration
        )
```

I recommend using SI units (meters, seconds, kilograms etc.) everywhere, but
everything will still work if you use other units as long as you're consistent.
For example, the following will work properly:

```elm
speed =
    Speed.milesPerHour
        (Length.inMiles length
            / Duration.inHours duration
        )
```
