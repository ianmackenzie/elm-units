module Duration
    exposing
        ( Duration
        , TimeUnits
        , days
        , from
        , hours
        , inDays
        , inHours
        , inMilliseconds
        , inMinutes
        , inSeconds
        , inWeeks
        , inYears
        , milliseconds
        , minutes
        , perDay
        , perHour
        , perMillisecond
        , perMinute
        , perSecond
        , perWeek
        , perYear
        , seconds
        , weeks
        , years
        )

import Quantity exposing (Quantity(..), Rate)
import Time


type TimeUnits
    = Seconds


{-| A `Duration` refers to an elapsed time, as opposed to a specific instant in
time (which would generally be represented by a `Posix` value).
-}
type alias Duration =
    Quantity TimeUnits


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


{-| Construct a `Duration` from a given number of days. A day is defined as
exactly 24 hours or 86400 seconds. Therefore, it is only equal to the length of
a given calendar day if that calendar day does not include either a leap second
or any added/removed daylight savings hours.

    days 1 == hours 24

-}
days : Float -> Duration
days numDays =
    seconds (86400 * numDays)


{-| Convert a `Duration` to a value in days.

    hours 72 |> inDays
    --> 3

-}
inDays : Duration -> Float
inDays duration =
    inSeconds duration / 86400


{-| Construct a `Duration` from a given number of weeks.

    weeks 1 == days 7

-}
weeks : Float -> Duration
weeks numWeeks =
    seconds (604800 * numWeeks)


{-| Convert a `Duration` to a value in weeks.

    days 28 |> inWeeks
    --> 4

-}
inWeeks : Duration -> Float
inWeeks duration =
    inSeconds duration / 604800


{-| Construct a `Duration` from a given number of [Julian years](https://en.wikipedia.org/wiki/Julian_year_(astronomy)).
A Julian year is defined as exactly 365.25 days, the average length of a year in
the historical Julian calendar. This is 10 minutes and 48 seconds longer than
a Gregorian year (365.2425 days), which is the average length of a year in the
modern Gregorian calendar, but the Julian year is a bit easier to remember and
reason about and has the virtue of being the 'year' value used in the definition
of a light year.

    years 1 == days 365.25

-}
years : Float -> Duration
years numYears =
    seconds (31557600 * numYears)


{-| Convert a `Duration` to a value in Julian years.

    hours 10000 |> inYears
    --> 1.1407711613050422

-}
inYears : Duration -> Float
inYears duration =
    inSeconds duration / 31557600


perMillisecond : Quantity units -> Quantity (Rate units TimeUnits)
perMillisecond quantity =
    Quantity.per (milliseconds 1) quantity


perSecond : Quantity units -> Quantity (Rate units TimeUnits)
perSecond quantity =
    Quantity.per (seconds 1) quantity


perMinute : Quantity units -> Quantity (Rate units TimeUnits)
perMinute quantity =
    Quantity.per (minutes 1) quantity


perHour : Quantity units -> Quantity (Rate units TimeUnits)
perHour quantity =
    Quantity.per (hours 1) quantity


perDay : Quantity units -> Quantity (Rate units TimeUnits)
perDay quantity =
    Quantity.per (days 1) quantity


perWeek : Quantity units -> Quantity (Rate units TimeUnits)
perWeek quantity =
    Quantity.per (weeks 1) quantity


perYear : Quantity units -> Quantity (Rate units TimeUnits)
perYear quantity =
    Quantity.per (years 1) quantity
