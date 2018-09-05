module Power exposing
    ( Power
    , Watts
    , inKilowatts
    , inMegawatts
    , inWatts
    , kilowatts
    , megawatts
    , watts
    )

import Duration exposing (Seconds)
import Energy exposing (Joules)
import Quantity exposing (Fractional, Quantity(..), Rate)


type alias Watts =
    Rate Joules Seconds


type alias Power =
    Fractional Watts


watts : Float -> Power
watts numWatts =
    Quantity numWatts


inWatts : Power -> Float
inWatts (Quantity numWatts) =
    numWatts


kilowatts : Float -> Power
kilowatts numKilowatts =
    watts (1000 * numKilowatts)


inKilowatts : Power -> Float
inKilowatts power =
    inWatts power / 1000


megawatts : Float -> Power
megawatts numMegawatts =
    watts (1.0e6 * numMegawatts)


inMegawatts : Power -> Float
inMegawatts power =
    inWatts power / 1.0e6
