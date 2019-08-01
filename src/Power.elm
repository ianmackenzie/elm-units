module Power exposing
    ( Power, Watts
    , watts, inWatts, kilowatts, inKilowatts, megawatts, inMegawatts
    , metricHorsepower, inMetricHorsepower, mechanicalHorsepower, inMechanicalHorsepower, electricalHorsepower, inElectricalHorsepower
    )

{-| A `Power` value represents power in watts or horsepower. It is stored as a
number of watts.

Note that since `Watts` is defined as `Rate Joules Seconds` (energy per unit
time), you can construct a `Power` value using `Quantity.per`:

    power =
        energy |> Quantity.per duration

You can also do rate-related calculations with `Power` values to compute
`Energy` or `Duration`:

    energy =
        power |> Quantity.for duration

    alsoEnergy =
        duration |> Quantity.at power

    duration =
        energy |> Quantity.at_ power

[1]: https://en.wikipedia.org/wiki/Horsepower#Definitions

@docs Power, Watts


## Metric

@docs watts, inWatts, kilowatts, inKilowatts, megawatts, inMegawatts


## Horsepower

Who knew that there were not one, not two, but _three_ possible interpretations
of "one horsepower"? (Actually there are more than that, but these three
seemed the most reasonable.)

@docs metricHorsepower, inMetricHorsepower, mechanicalHorsepower, inMechanicalHorsepower, electricalHorsepower, inElectricalHorsepower

-}

import Duration exposing (Seconds)
import Energy exposing (Joules)
import Quantity exposing (Quantity(..), Rate)


{-| -}
type alias Watts =
    Rate Joules Seconds


{-| -}
type alias Power =
    Quantity Float Watts


{-| Construct a `Power` value from a number of watts.
-}
watts : Float -> Power
watts numWatts =
    Quantity numWatts


{-| Convert a `Power` value to a number of watts.
-}
inWatts : Power -> Float
inWatts (Quantity numWatts) =
    numWatts


{-| Construct a `Power` value from a number of kilowatts.
-}
kilowatts : Float -> Power
kilowatts numKilowatts =
    watts (1000 * numKilowatts)


{-| Convert a `Power` value to a number of kilowatts.
-}
inKilowatts : Power -> Float
inKilowatts power =
    inWatts power / 1000


{-| Construct a `Power` value from a number of megawatts.
-}
megawatts : Float -> Power
megawatts numMegawatts =
    watts (1.0e6 * numMegawatts)


{-| Convert a `Power` value to a number of megawatts.
-}
inMegawatts : Power -> Float
inMegawatts power =
    inWatts power / 1.0e6


{-| Construct a `Power` value from an number of [metric horsepower][1].

    Power.metricHorsepower 1
    --> Power.watts 735.49875

[1]: https://en.wikipedia.org/wiki/Horsepower#Metric_horsepower

-}
metricHorsepower : Float -> Power
metricHorsepower numMetricHorsepower =
    watts (735.49875 * numMetricHorsepower)


{-| Convert a `Power` value to a number of metric horsepower.
-}
inMetricHorsepower : Power -> Float
inMetricHorsepower power =
    inWatts power / 735.49875


{-| Construct a `Power` value from an number of [mechanical horsepower][1].

    Power.mechanicalHorsepower 1
    --> Power.watts 745.6998715822702

[1]: https://en.wikipedia.org/wiki/Horsepower#Mechanical_horsepower

-}
mechanicalHorsepower : Float -> Power
mechanicalHorsepower numMechanicalHorsepower =
    watts (numMechanicalHorsepower * 550 * 0.3048 * 4.4482216152605)


{-| Convert a `Power` value to a number of mechanical horsepower.
-}
inMechanicalHorsepower : Power -> Float
inMechanicalHorsepower power =
    inWatts power / (550 * 0.3048 * 4.4482216152605)


{-| Construct a `Power` value from an number of [electrical horsepower][1].

    Power.electricalHorsepower 1
    --> Power.watts 746

[1]: https://en.wikipedia.org/wiki/Horsepower#Electrical_horsepower

-}
electricalHorsepower : Float -> Power
electricalHorsepower numElectricalHorsepower =
    watts (746 * numElectricalHorsepower)


{-| Convert a `Power` value to a number of electrical horsepower.
-}
inElectricalHorsepower : Power -> Float
inElectricalHorsepower power =
    inWatts power / 746
