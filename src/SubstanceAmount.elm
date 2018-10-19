module SubstanceAmount exposing
    ( SubstanceAmount, Moles
    , moles, inMoles, picomoles, inPicomoles, nanomoles, inNanomoles
    , micromoles, inMicromoles, millimoles, inMillimoles, kilomoles, inKilomoles
    , megamoles, inMegamoles, gigamoles, inGigamoles
    )

{-| A `SubstanceAmount` value represents a substance amount in moles.

@docs SubstanceAmount, Moles
@docs moles, inMoles, picomoles, inPicomoles, nanomoles, inNanomoles
@docs micromoles, inMicromoles, millimoles, inMillimoles, kilomoles, inKilomoles
@docs megamoles, inMegamoles, gigamoles, inGigamoles

-}

import Quantity exposing (Quantity(..))


{-| -}
type Moles
    = Moles


{-| -}
type alias SubstanceAmount =
    Quantity Float Moles


{-| Construct a substance amount from a number of moles.
-}
moles : Float -> SubstanceAmount
moles numMoles =
    Quantity numMoles


{-| Convert a substance amount to a number of moles.
-}
inMoles : SubstanceAmount -> Float
inMoles (Quantity numMoles) =
    numMoles


{-| Construct a substance amount from a number of picomoles.
-}
picomoles : Float -> SubstanceAmount
picomoles numPicomoles =
    moles (numPicomoles * 1.0e-12)


{-| Convert a substance amount to a number of picomoles.
-}
inPicomoles : SubstanceAmount -> Float
inPicomoles substanceAmount =
    inMoles substanceAmount / 1.0e-12


{-| Construct a substance amount from a number of nanomoles.
-}
nanomoles : Float -> SubstanceAmount
nanomoles numNanomoles =
    moles (numNanomoles * 1.0e-9)


{-| Convert a substance amount to a number of nanomoles.
-}
inNanomoles : SubstanceAmount -> Float
inNanomoles substanceAmount =
    inMoles substanceAmount / 1.0e-9


{-| Construct a substance amount from a number of micromoles.
-}
micromoles : Float -> SubstanceAmount
micromoles numMicromoles =
    moles (numMicromoles * 1.0e-6)


{-| Convert a substance amount to a number of micromoles.
-}
inMicromoles : SubstanceAmount -> Float
inMicromoles substanceAmount =
    inMoles substanceAmount / 1.0e-6


{-| Construct a substance amount from a number of millimoles.
-}
millimoles : Float -> SubstanceAmount
millimoles numMillimoles =
    moles (numMillimoles * 1.0e-3)


{-| Convert a substance amount to a number of millimoles.
-}
inMillimoles : SubstanceAmount -> Float
inMillimoles substanceAmount =
    inMoles substanceAmount / 1.0e-3


{-| Construct a substance amount from a number of kilomoles.
-}
kilomoles : Float -> SubstanceAmount
kilomoles numKilomoles =
    moles (numKilomoles * 1.0e3)


{-| Convert a substance amount to a number of kilomoles.
-}
inKilomoles : SubstanceAmount -> Float
inKilomoles substanceAmount =
    inMoles substanceAmount / 1.0e3


{-| Construct a substance amount from a number of megamoles.
-}
megamoles : Float -> SubstanceAmount
megamoles numMegamoles =
    moles (numMegamoles * 1.0e6)


{-| Convert a substance amount to a number of megamoles.
-}
inMegamoles : SubstanceAmount -> Float
inMegamoles substanceAmount =
    inMoles substanceAmount / 1.0e6


{-| Construct a substance amount from a number of gigamoles.
-}
gigamoles : Float -> SubstanceAmount
gigamoles numGigamoles =
    moles (numGigamoles * 1.0e9)


{-| Convert a substance amount to a number of gigamoles.
-}
inGigamoles : SubstanceAmount -> Float
inGigamoles substanceAmount =
    inMoles substanceAmount / 1.0e9
