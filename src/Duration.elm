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

import Quantity exposing (Quantity(..))
import Time


{-| A `Duration` refers to an elapsed time, as opposed to a specific instant in
time (which would generally be represented by a `Posix` value).
-}
type alias Duration =
    Quantity.Duration


{-| Find the elapsed time from a start time to an end time. For example,
assuming that `nineAM` and `fivePM` are two `Time.Posix` values on the same day:

    Duration.from nineAM fivePM == hours 8

-}
from : Time.Posix -> Time.Posix -> Duration
from startTime endTime =
    let
        numMilliseconds =
            Time.posixToMillis endTime - Time.posixToMillis startTime
    in
    milliseconds (toFloat numMilliseconds)


{-| Construct a `Duration` from a given number of seconds.

    seconds 60 == minutes 1

-}
seconds : Float -> Duration
seconds numSeconds =
    Quantity numSeconds


{-| Convert a `Duration` to a value in seconds.

    milliseconds 10 |> inSeconds
    --> 0.01

-}
inSeconds : Duration -> Float
inSeconds (Quantity numSeconds) =
    numSeconds


{-| Construct a `Duration` from a given number of milliseconds.

    milliseconds 5000 == seconds 5

-}
milliseconds : Float -> Duration
milliseconds numMilliseconds =
    seconds (0.001 * numMilliseconds)


{-| Convert a `Duration` to a value in milliseconds.

    seconds 0.5 |> inMilliseconds
    --> 500

-}
inMilliseconds : Duration -> Float
inMilliseconds duration =
    inSeconds duration * 1000


{-| Construct a `Duration` from a given number of minutes.

    minutes 3 == seconds 180

-}
minutes : Float -> Duration
minutes numMinutes =
    seconds (60 * numMinutes)


{-| Convert a `Duration` to a value in minutes.

    seconds 90 |> inMinutes
    --> 1.5

-}
inMinutes : Duration -> Float
inMinutes duration =
    inSeconds duration / 60


{-| Construct a `Duration` from a given number of hours.

    hours 1 == seconds 3600

-}
hours : Float -> Duration
hours numHours =
    seconds (3600 * numHours)


{-| Convert a `Duration` to a value in hours.

    minutes 120 |> inHours
    --> 2

-}
inHours : Duration -> Float
inHours duration =
    inSeconds duration / 3600
