module Molarity exposing 
    (Molarity, MolesPerCubicMeter
    , molesPerCubicMeter, inMolesPerCubicMeter, decimolesPerCubicDecimeter, inDecimolesPerCubicDecimeter
    )

{-|

8.6.5 Concentration of B; amount-of-substance concentration of B

Quantity symbol: cB. SI unit: mole per cubic meter (mol/m3).

Definition: amount of substance of B divided by the volume of the mixture: cB = nB/V.

https://www.nist.gov/pml/special-publication-811/nist-guide-si-chapter-8

Notes:

1. This Guide prefers the name "amount-of-substance concentration of B" for this quantity because it is unambiguous. However, in practice, it is often shortened to amount concentration of B, or even simply to concentration of B. Unfortunately, this last form can cause confusion because there are several different "concentrations," for example, mass concentration of B, ρB = mB/V; and molecular concentration of B, CB = NB/V, where NB is the number of molecules of B.

2. The term normality and the symbol N should no longer be used because they are obsolete. One should avoid writing, for example, "a 0.5 N solution of H2SO4" and write instead "a solution having an amount-of-substance concentration of c [(1/2)H2SO4]) = 0.5 mol/dm3" (or 0.5 kmol/m3 or 0.5 mol/L since 1 mol/dm3 = 1 kmol/m3 = 1 mol/L).

3. The term molarity and the symbol M should no longer be used because they, too, are obsolete. One should use instead amount-of-substance concentration of B and such units as mol/dm3, kmol/m3, or mol/L. (A solution of, for example, 0.1 mol/dm3 was often called a 0.1 molar solution, denoted 0.1 M solution. The molarity of the solution was said to be 0.1 M.)

A liter is equal to a cubic decimeter

8.2 Volume

The SI unit of volume is the cubic meter (m3) and may be used to express the volume of any substance, whether solid, liquid, or gas. The liter (L) is a special name for the cubic decimeter (dm3), but the CGPM recommends that the liter not be used to give the results of high accuracy measurements of volumes [1, 2]. Also, it is not common practice to use the liter to express the volumes of solids nor to use multiples of the liter such as the kiloliter (kL) [see Sec. 6.2.8, and also Table 6, footnote (b)].

@docs Molarity, MolesPerCubicMeter

reading:
https://courses.lumenlearning.com/boundless-chemistry/chapter/concentration-units/

## Metric

-}

import Quantity exposing (Quantity(..), Rate)
import SubstanceAmount (Moles)
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


{-| Construct a molarity from a number of decimoles per cubic decimeter. 
-}
decimolesPerCubicDecimeter : Float -> Molarity
decimolesPerCubicDecimeter numDecimolesPerCubicDecimeter =
    molesPerCubicMeter (10 * numDecimolesPerCubicDecimeter)


{-| Convert a molarity to a number of decimoles per cubic decimeter.
-}
inDecimolesPerCubicDecimeter : Molarity -> Float
inDecimolesPerCubicDecimeter molar =
    molesPerCubicMeter (molar / 10)
