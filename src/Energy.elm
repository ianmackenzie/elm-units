module Energy exposing
    ( Energy, Joules
    , joules, inJoules, kilojoules, inKilojoules, megajoules, inMegajoules, kilowattHours, inKilowattHours
    )

{-| An `Energy` value represents an amount of energy (or work) in joules,
kilowatt hours etc. It is stored as a number of joules.

Note that since `Joules` is defined as `Product Newtons Meters`, you can compute
energy directly as a product of force and distance:

    Force.newtons 5 |> Quantity.times (Length.meters 4)
    --> Energy.joules 20

@docs Energy, Joules


## Conversions

@docs joules, inJoules, kilojoules, inKilojoules, megajoules, inMegajoules, kilowattHours, inKilowattHours

-}

import Force exposing (Newtons)
import Length exposing (Meters)
import Quantity exposing (Product, Quantity(..))


{-| -}
type alias Joules =
    Product Newtons Meters


{-| -}
type alias Energy =
    Quantity Float Joules


{-| Construct an energy value from a number of joules.
-}
joules : Float -> Energy
joules numJoules =
    Quantity numJoules


{-| Convert an energy value to a number of joules.
-}
inJoules : Energy -> Float
inJoules (Quantity numJoules) =
    numJoules


{-| Construct an energy value from a number of kilojoules.
-}
kilojoules : Float -> Energy
kilojoules numKilojoules =
    joules (1000 * numKilojoules)


{-| Convert an energy value to a number of kilojoules.
-}
inKilojoules : Energy -> Float
inKilojoules energy =
    inJoules energy / 1000


{-| Construct an energy value from a number of megajoules.
-}
megajoules : Float -> Energy
megajoules numMegajoules =
    joules (1.0e6 * numMegajoules)


{-| Convert an energy value to a number of megajoules.
-}
inMegajoules : Energy -> Float
inMegajoules energy =
    inJoules energy / 1.0e6


{-| Construct an energy value from a number of kilowatt hours.

    Energy.kilowattHours 1
    --> Energy.megajoules 3.6

-}
kilowattHours : Float -> Energy
kilowattHours numKilowattHours =
    joules (3.6e6 * numKilowattHours)


{-| Convert an energy value to a number of kilowatt hours.
-}
inKilowattHours : Energy -> Float
inKilowattHours energy =
    inJoules energy / 3.6e6
