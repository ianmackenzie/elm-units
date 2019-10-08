module Molarity exposing
    ( Molarity, MolesPerCubicMeter
    , molesPerCubicMeter, inMolesPerCubicMeter
    , decimolesPerLiter, inDecimolesPerLiter
    , centimolesPerLiter, inCentimolesPerLiter
    , millimolesPerLiter, inMillimolesPerLiter
    , micromolesPerLiter, inMicromolesPerLiter
    )

{-| A `Molarity` value represents a concentration in mole per cubic meter, decimoles per liter, etc.
It is stored in number of mole per cubic meter.

An SI unit, mole per cubic meter (mol/m3), `Molarity` is an amount of substance divided by the volume of the mixture.

_Note: A liter is equal to a cubic decimeter._

Section 8.6.5 in Chapter 8 of the [NIST Guide to the SI](https://www.nist.gov/pml/special-publication-811/nist-guide-si-chapter-8) does notes that the term molarity is consider obsolete. The initial decision to use `Molarity` as the module name was due to the verbosity of "amount-of-substance concentration".

@docs Molarity, MolesPerCubicMeter
@docs molesPerCubicMeter, inMolesPerCubicMeter
@docs decimolesPerLiter, inDecimolesPerLiter
@docs centimolesPerLiter, inCentimolesPerLiter
@docs millimolesPerLiter, inMillimolesPerLiter
@docs micromolesPerLiter, inMicromolesPerLiter

-}

import Quantity exposing (Quantity(..), Rate)
import SubstanceAmount exposing (Moles)
import Volume exposing (CubicMeters)


{-| -}
type alias MolesPerCubicMeter =
    Rate Moles CubicMeters


{-| -}
type alias Molarity =
    Quantity Float MolesPerCubicMeter


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


{-| Construct a molarity from a number of decimoles per liter.
-}
decimolesPerLiter : Float -> Molarity
decimolesPerLiter numDecimolesPerLiter =
    molesPerCubicMeter (10 * numDecimolesPerLiter)


{-| Convert a molarity to a number of decimoles per liter.
-}
inDecimolesPerLiter : Molarity -> Float
inDecimolesPerLiter (Quantity numMolesPerCubicMeter) =
    numMolesPerCubicMeter / 10


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
