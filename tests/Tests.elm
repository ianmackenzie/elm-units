module Tests exposing (forces, lengths, powers, pressures, speeds)

import Acceleration exposing (..)
import Current exposing (..)
import Duration exposing (..)
import Expect exposing (Expectation)
import Force exposing (..)
import Fuzz exposing (Fuzzer)
import Length exposing (..)
import Mass exposing (..)
import Power exposing (..)
import Pressure exposing (..)
import Quantity exposing (Fractional, Quantity(..), at, at_, minus, per, plus, times)
import Resistance exposing (..)
import Speed exposing (..)
import Test exposing (Test)
import Voltage exposing (..)


equalityTest : String -> String -> ( Fractional units, Fractional units ) -> Test
equalityTest title unit ( Quantity x, Quantity y ) =
    let
        description =
            String.join " "
                [ title
                , String.fromFloat x ++ unit
                , "and"
                , String.fromFloat y ++ unit
                , "should be equal"
                ]
    in
    Test.test description (\() -> Expect.within (Expect.Absolute 1.0e-12) x y)


equalPairs : String -> String -> List ( Fractional units, Fractional units ) -> Test
equalPairs title unit pairs =
    Test.describe title (List.map (equalityTest title unit) pairs)


lengths : Test
lengths =
    equalPairs
        "Lengths"
        "m"
        [ ( inches 1
          , centimeters 2.54
          )
        , ( feet 3
          , yards 1
          )
        , ( miles 1
          , feet 5280
          )
        , ( meters 1
          , microns 1.0e6
          )
        ]


speeds : Test
speeds =
    equalPairs
        "Speeds"
        "m/s"
        [ ( metersPerSecond 2.5
          , meters 5 |> per (seconds 2)
          )
        , ( milesPerHour 60
          , miles 1 |> per (minutes 1)
          )
        , ( lightYears 1 |> per (julianYears 1)
          , metersPerSecond 299792458
          )
        ]


powers : Test
powers =
    equalPairs
        "Powers"
        "W"
        [ ( watts 50
          , amperes 5 |> at (amperes 5 |> at (ohms 2))
          )
        ]


forces : Test
forces =
    equalPairs
        "Forces"
        "N"
        [ ( kilograms 20 |> times (metersPerSecondSquared 5)
          , newtons 100
          )
        ]


pressures : Test
pressures =
    equalPairs
        "Pressure"
        "Pa"
        [ ( atmospheres 1
          , kilopascals 101.325
          )
        ]
