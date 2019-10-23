module Molarity exposing
    ( Molarity, MolesPerCubicMeter
    , molesPerCubicMeter, inMolesPerCubicMeter
    , molesPerLiter, inMolesPerLiter
    , decimolesPerLiter, inDecimolesPerLiter
    , centimolesPerLiter, inCentimolesPerLiter
    , millimolesPerLiter, inMillimolesPerLiter
    , micromolesPerLiter, inMicromolesPerLiter
    )

{-| A `Molarity` value represents a concentration of substance in moles per
cubic meter, moles per liter, millimoles per liter etc. It is stored as a number
of moles per cubic meter.

Note that the [NIST Guide to the
SI](https://www.nist.gov/pml/special-publication-811/nist-guide-si-chapter-8)
states that the term "molarity" is considered obsolete, but it appears to still
be in common use and is far less verbose than the alternative NIST suggestion of
"amount-of-substance concentration".

Since the units of `Molarity` are defined to be `Rate Moles CubicMeters` (amount
of substance per unit volume), you can construct a `Molarity` value using
`Quantity.per`:

    molarity =
        substanceAmount |> Quantity.per volume

You can also do rate-related calculations with `Molarity` values to compute
`SubstanceAmount` or `Volume`:

    substanceAmount =
        volume |> Quantity.at molarity

    volume =
        substanceAmount |> Quantity.at_ molarity

@docs Molarity, MolesPerCubicMeter
@docs molesPerCubicMeter, inMolesPerCubicMeter
@docs molesPerLiter, inMolesPerLiter
@docs decimolesPerLiter, inDecimolesPerLiter
@docs centimolesPerLiter, inCentimolesPerLiter
@docs millimolesPerLiter, inMillimolesPerLiter
@docs micromolesPerLiter, inMicromolesPerLiter

-}

import Constants
import Quantity exposing (Quantity(..), Rate)
import SubstanceAmount exposing (Moles)
import Volume exposing (CubicMeters)


{-| -}
type alias MolesPerCubicMeter =
    Rate Moles CubicMeters


{-| -}
type alias Molarity =
    Quantity Float MolesPerCubicMeter



---------- CONSTANTS ----------


{-| One mole per liter, in moles per cubic meter
-}
oneMolePerLiter : Float
oneMolePerLiter =
    Constants.mole / Constants.liter


{-| One decimole per liter, in moles per cubic meter
-}
oneDecimolePerLiter : Float
oneDecimolePerLiter =
    0.1 * Constants.mole / Constants.liter



---------- FUNCTIONS ----------


{-| Construct a molarity from a number of moles per cubic meter.
-}
molesPerCubicMeter : Float -> Molarity
molesPerCubicMeter numMolesPerCubicMeter =
    Quantity numMolesPerCubicMeter


{-| Convert a molarity to a number of moles per cubic meter.
-}
inMolesPerCubicMeter : Molarity -> Float
inMolesPerCubicMeter (Quantity numMolesPerCubicMeter) =
    numMolesPerCubicMeter


{-| Construct a molarity from a number of moles per liter.
-}
molesPerLiter : Float -> Molarity
molesPerLiter numMolesPerLiter =
    molesPerCubicMeter (numMolesPerLiter * oneMolePerLiter)


{-| Convert a molarity to a number of moles per liter.
-}
inMolesPerLiter : Molarity -> Float
inMolesPerLiter molarity =
    inMolesPerCubicMeter molarity / oneMolePerLiter


{-| Construct a molarity from a number of decimoles per liter.
-}
decimolesPerLiter : Float -> Molarity
decimolesPerLiter numDecimolesPerLiter =
    molesPerCubicMeter (numDecimolesPerLiter * oneDecimolePerLiter)


{-| Convert a molarity to a number of decimoles per liter.
-}
inDecimolesPerLiter : Molarity -> Float
inDecimolesPerLiter molarity =
    inMolesPerCubicMeter molarity / oneDecimolePerLiter


{-| Construct a molarity from a number of centimoles per liter.
-}
centimolesPerLiter : Float -> Molarity
centimolesPerLiter numCentimolesPerLiter =
    decimolesPerLiter (10 * numCentimolesPerLiter)


{-| Convert a molarity to a number of centimoles per liter.
-}
inCentimolesPerLiter : Molarity -> Float
inCentimolesPerLiter molar =
    inDecimolesPerLiter molar / 10


{-| Construct a molarity from a number of millimoles per liter.
-}
millimolesPerLiter : Float -> Molarity
millimolesPerLiter numMillimolesPerLiter =
    decimolesPerLiter (100 * numMillimolesPerLiter)


{-| Convert a molarity to a number of millimoles per liter.
-}
inMillimolesPerLiter : Molarity -> Float
inMillimolesPerLiter molar =
    inDecimolesPerLiter molar / 100


{-| Construct a molarity from a number of micromoles per liter.
-}
micromolesPerLiter : Float -> Molarity
micromolesPerLiter numMicromolesPerLiter =
    decimolesPerLiter (1000 * numMicromolesPerLiter)


{-| Convert a molarity to a number of micromoles per liter.
-}
inMicromolesPerLiter : Molarity -> Float
inMicromolesPerLiter molar =
    inDecimolesPerLiter molar / 1000
