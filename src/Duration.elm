module Duration exposing
    ( Duration, Seconds
    , seconds, inSeconds, milliseconds, inMilliseconds, minutes, inMinutes, hours, inHours, days, inDays, weeks, inWeeks, julianYears, inJulianYears
    , from
    , addTo, subtractFrom
    , second, millisecond, minute, hour, day, week, julianYear
    )

{-| A `Duration` refers to an elapsed time in seconds, milliseconds, hours etc.,
as opposed to a specific instant in time (which would generally be represented
by a [`Posix`](https://package.elm-lang.org/packages/elm/time/latest/Time#Posix)
value). It is stored as a number of seconds.

@docs Duration, Seconds


## Conversions

@docs seconds, inSeconds, milliseconds, inMilliseconds, minutes, inMinutes, hours, inHours, days, inDays, weeks, inWeeks, julianYears, inJulianYears


## Working with `Time.Posix` values

@docs from


### Offsetting

`addTo` and `subtractFrom` can be used to offset a [`Time.Posix`](https://package.elm-lang.org/packages/elm/time/latest/Time#Posix)
value by a given `Duration`. However, note that `Time.Posix` values are stored
as an integer number of milliseconds, so the offset amount will be rounded to
the nearest number of milliseconds.

@docs addTo, subtractFrom


## Constants

Shorthand for `Duration.seconds 1`, `Duration.hours 1` etc. Can be convenient to
use with [`Quantity.per`](Quantity#per).

@docs second, millisecond, minute, hour, day, week, julianYear

-}

import Constants
import Quantity exposing (Quantity(..))
import Time


{-| -}
type Seconds
    = Seconds


{-| -}
type alias Duration =
    Quantity Float Seconds


{-| Find the elapsed time from a start time to an end time. For example,
assuming that `nineAM` and `fivePM` are two [`Time.Posix`](https://package.elm-lang.org/packages/elm/time/latest/Time#Posix)
values on the same day:

    Duration.from nineAM fivePM
    --> Duration.hours 8

-}
from : Time.Posix -> Time.Posix -> Duration
from startTime endTime =
    let
        numMilliseconds =
            Time.posixToMillis endTime - Time.posixToMillis startTime
    in
    milliseconds (toFloat numMilliseconds)


{-| Construct a `Duration` from a given number of seconds.
-}
seconds : Float -> Duration
seconds numSeconds =
    Quantity numSeconds


{-| Convert a `Duration` to a value in seconds.

    Duration.milliseconds 10 |> Duration.inSeconds
    --> 0.01

-}
inSeconds : Duration -> Float
inSeconds (Quantity numSeconds) =
    numSeconds


{-| Construct a `Duration` from a given number of milliseconds.

    Duration.milliseconds 5000
    --> Duration.seconds 5

-}
milliseconds : Float -> Duration
milliseconds numMilliseconds =
    seconds (0.001 * numMilliseconds)


{-| Convert a `Duration` to a value in milliseconds.

    Duration.seconds 0.5 |> Duration.inMilliseconds
    --> 500

-}
inMilliseconds : Duration -> Float
inMilliseconds duration =
    inSeconds duration * 1000


{-| Construct a `Duration` from a given number of minutes.

    Duration.minutes 3
    --> Duration.seconds 180

-}
minutes : Float -> Duration
minutes numMinutes =
    seconds (60 * numMinutes)


{-| Convert a `Duration` to a value in minutes.

    Duration.seconds 90 |> Duration.inMinutes
    --> 1.5

-}
inMinutes : Duration -> Float
inMinutes duration =
    inSeconds duration / 60


{-| Construct a `Duration` from a given number of hours.

    Duration.hours 1
    --> Duration.seconds 3600

-}
hours : Float -> Duration
hours numHours =
    seconds (Constants.hour * numHours)


{-| Convert a `Duration` to a value in hours.

    Duration.minutes 120 |> Duration.inHours
    --> 2

-}
inHours : Duration -> Float
inHours duration =
    inSeconds duration / Constants.hour


{-| Construct a `Duration` from a given number of days. A day is defined as
exactly 24 hours or 86400 seconds. Therefore, it is only equal to the length of
a given calendar day if that calendar day does not include either a leap second
or any added/removed daylight savings hours.

    Duration.days 1
    --> Duration.hours 24

-}
days : Float -> Duration
days numDays =
    seconds (Constants.day * numDays)


{-| Convert a `Duration` to a value in days.

    Duration.hours 72 |> Duration.inDays
    --> 3

-}
inDays : Duration -> Float
inDays duration =
    inSeconds duration / Constants.day


{-| Construct a `Duration` from a given number of weeks.

    Duration.weeks 1
    --> Duration.days 7

-}
weeks : Float -> Duration
weeks numWeeks =
    seconds (Constants.week * numWeeks)


{-| Convert a `Duration` to a value in weeks.

    Duration.days 28 |> Duration.inWeeks
    --> 4

-}
inWeeks : Duration -> Float
inWeeks duration =
    inSeconds duration / Constants.week


{-| Construct a `Duration` from a given number of [Julian years][julian_year].
A Julian year is defined as exactly 365.25 days, the average length of a year in
the historical Julian calendar. This is 10 minutes and 48 seconds longer than
a Gregorian year (365.2425 days), which is the average length of a year in the
modern Gregorian calendar, but the Julian year is a bit easier to remember and
reason about and has the virtue of being the 'year' value used in the definition
of a [light year](Length#lightYears).

    Duration.julianYears 1
    --> Duration.days 365.25

[julian_year]: https://en.wikipedia.org/wiki/Julian_year_(astronomy) "Julian year"

-}
julianYears : Float -> Duration
julianYears numJulianYears =
    seconds (31557600 * numJulianYears)


{-| Convert a `Duration` to a value in Julian years.

    Duration.hours 10000 |> Duration.inJulianYears
    --> 1.1407711613050422

-}
inJulianYears : Duration -> Float
inJulianYears duration =
    inSeconds duration / 31557600


{-| Offset a [`Time.Posix`](https://package.elm-lang.org/packages/elm/time/latest/Time#Posix)
value forwards in time by a given `Duration`:

    -- Assuming that 'now' is a Time.Posix value obtained
    -- from Time.now
    threeHoursFromNow =
        Duration.addTo now (Duration.hours 3)

-}
addTo : Time.Posix -> Duration -> Time.Posix
addTo time duration =
    Time.millisToPosix
        (Time.posixToMillis time + round (inMilliseconds duration))


{-| Offset a [`Time.Posix`](https://package.elm-lang.org/packages/elm/time/latest/Time#Posix)
value backwards in time by a given `Duration`:

    -- Assuming that 'now' is a Time.Posix value obtained
    -- from Time.now
    fiveMinutesAgo =
        Duration.subtractFrom now (Duration.minutes 5)

`Duration.subtractFrom time duration` is equivalent to `Duration.addTo time
(Quantity.negate duration)`.

-}
subtractFrom : Time.Posix -> Duration -> Time.Posix
subtractFrom time duration =
    Time.millisToPosix
        (Time.posixToMillis time - round (inMilliseconds duration))


{-| -}
second : Duration
second =
    seconds 1


{-| -}
millisecond : Duration
millisecond =
    milliseconds 1


{-| -}
minute : Duration
minute =
    minutes 1


{-| -}
hour : Duration
hour =
    hours 1


{-| -}
day : Duration
day =
    days 1


{-| -}
week : Duration
week =
    weeks 1


{-| -}
julianYear : Duration
julianYear =
    julianYears 1
