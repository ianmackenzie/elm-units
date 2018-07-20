module Duration
    exposing
        ( Duration
        , from
        , hours
        , inHours
        , inMilliseconds
        , inMinutes
        , inSeconds
        , milliseconds
        , minutes
        , seconds
        )

import Time


{-| A `Duration` refers to an elapsed time, as opposed to a specific instant in
time (which would generally be represented by a `Posix` value).
-}
type Duration
    = Duration Float -- stored as seconds


{-| Find the elapsed time from a start time to an end time. For example,
assuming that `nineAM` and `fivePM` are two `Time.Posix` values on the same day:

    Duration.from nineAM fivePM == Duration.hours 8

-}
from : Time.Posix -> Time.Posix -> Duration
from startTime endTime =
    let
        numMilliseconds =
            Time.posixToMillis endTime - Time.posixToMillis startTime
    in
    milliseconds (toFloat numMilliseconds)


{-| Construct a `Duration` from a given number of seconds.

    Duration.seconds 60 == Duration.minutes 1

-}
seconds : Float -> Duration
seconds numSeconds =
    Duration numSeconds


{-| Convert a `Duration` to a value in seconds.

    Duration.inSeconds (Duration.milliseconds 10)
    --> 0.01

-}
inSeconds : Duration -> Float
inSeconds (Duration numSeconds) =
    numSeconds


{-| Construct a `Duration` from a given number of milliseconds.

    Duration.milliseconds 5000 == Duration.seconds 5

-}
milliseconds : Float -> Duration
milliseconds numMilliseconds =
    seconds (0.001 * numMilliseconds)


{-| Convert a `Duration` to a value in milliseconds.

    Duration.inMilliseconds (Duration.seconds 0.5)
    --> 500

-}
inMilliseconds : Duration -> Float
inMilliseconds duration =
    inSeconds duration * 1000


{-| Construct a `Duration` from a given number of minutes.

    Duration.minutes 3 == Duration.seconds 180

-}
minutes : Float -> Duration
minutes numMinutes =
    seconds (60 * numMinutes)


{-| Convert a `Duration` to a value in minutes.

    Duration.inMinutes (Duration.seconds 90)
    --> 1.5

-}
inMinutes : Duration -> Float
inMinutes duration =
    inSeconds duration / 60


{-| Construct a `Duration` from a given number of hours.

    Duration.hours 1 == Duration.seconds 3600

-}
hours : Float -> Duration
hours numHours =
    seconds (3600 * numHours)


{-| Convert a `Duration` to a value in hours.

    Duration.inHours (Duration.minutes 120)
    --> 2

-}
inHours : Duration -> Float
inHours duration =
    inSeconds duration / 3600
