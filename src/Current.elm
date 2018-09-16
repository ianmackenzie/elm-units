module Current exposing
    ( Amperes
    , Current
    , amperes
    , inAmperes
    , inMilliamperes
    , milliamperes
    )

import Charge exposing (Coulombs)
import Duration exposing (Seconds)
import Quantity exposing (Quantity(..), Rate)


type alias Amperes =
    Rate Coulombs Seconds


type alias Current =
    Quantity Float Amperes


amperes : Float -> Current
amperes numAmperes =
    Quantity numAmperes


inAmperes : Current -> Float
inAmperes (Quantity numAmperes) =
    numAmperes


milliamperes : Float -> Current
milliamperes numMilliamperes =
    amperes (numMilliamperes * 1.0e-3)


inMilliamperes : Current -> Float
inMilliamperes current =
    inAmperes current / 1.0e-3
