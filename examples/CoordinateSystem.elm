module CoordinateSystem exposing
    ( CoordinateSystem
    , InWorld, OnScreen, Unitless
    )

{-|

@docs CoordinateSystem


## Predefined (pseudo) coordinate systems

@docs InWorld, OnScreen, Unitless

-}

import Length exposing (Meters)
import Pixels exposing (Pixels)


type CoordinateSystem name units
    = CoordinateSystem Never


type alias Unitless =
    CoordinateSystem Never Never


type alias InWorld =
    CoordinateSystem Never Meters


type alias OnScreen =
    CoordinateSystem Never Pixels
