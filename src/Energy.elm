module Energy exposing
    ( Energy
    , Joules
    , inJoules
    , inKilojoules
    , inKilowattHours
    , inMegajoules
    , joules
    , kilojoules
    , kilowattHours
    , megajoules
    )

import Quantity exposing (Fractional, Quantity(..))


type Joules
    = Joules


type alias Energy =
    Fractional Joules


joules : Float -> Energy
joules numJoules =
    Quantity numJoules


inJoules : Energy -> Float
inJoules (Quantity numJoules) =
    numJoules


kilojoules : Float -> Energy
kilojoules numKilojoules =
    joules (1000 * numKilojoules)


inKilojoules : Energy -> Float
inKilojoules energy =
    inJoules energy / 1000


megajoules : Float -> Energy
megajoules numMegajoules =
    joules (1.0e6 * numMegajoules)


inMegajoules : Energy -> Float
inMegajoules energy =
    inJoules energy / 1.0e6


kilowattHours : Float -> Energy
kilowattHours numKilowattHours =
    joules (3.6e6 * numKilowattHours)


inKilowattHours : Energy -> Float
inKilowattHours energy =
    inJoules energy / 3.6e6
