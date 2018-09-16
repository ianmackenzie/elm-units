module Tests exposing
    ( durations
    , forces
    , lengths
    , powers
    , pressures
    , speeds
    , temperatureDeltas
    , temperatures
    )

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
import Quantity exposing (Quantity(..), at, at_, minus, per, plus, times)
import Resistance exposing (..)
import Speed exposing (..)
import Temperature exposing (Temperature)
import Test exposing (Test)
import Voltage exposing (..)


equalityTest : String -> String -> ( Quantity Float units, Quantity Float units ) -> Test
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


equalPairs : String -> String -> List ( Quantity Float units, Quantity Float units ) -> Test
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
        "Pressures"
        "Pa"
        [ ( atmospheres 1
          , kilopascals 101.325
          )
        ]


durations : Test
durations =
    equalPairs
        "Durations"
        "s"
        [ ( julianYears 1
          , days 365.25
          )
        ]


temperatureEqualityTest : ( Temperature, Temperature ) -> Test
temperatureEqualityTest ( x, y ) =
    let
        xInCelsius =
            Temperature.inDegreesCelsius x

        yInCelsius =
            Temperature.inDegreesCelsius y

        description =
            String.join " "
                [ "Temperatures"
                , String.fromFloat xInCelsius ++ "C"
                , "and"
                , String.fromFloat yInCelsius ++ "C"
                , "should be equal"
                ]
    in
    Test.test description
        (\() -> Expect.within (Expect.Absolute 1.0e-12) xInCelsius yInCelsius)


temperatures : Test
temperatures =
    Test.describe "Temperatures" <|
        List.map temperatureEqualityTest
            [ ( Temperature.degreesCelsius -40
              , Temperature.degreesFahrenheit -40
              )
            , ( Temperature.degreesCelsius 0
              , Temperature.degreesFahrenheit 32
              )
            , ( Temperature.degreesCelsius 25
                    |> Temperature.plus (Temperature.fahrenheitDegrees 3)
              , Temperature.degreesFahrenheit 80
              )
            ]


temperatureDeltas : Test
temperatureDeltas =
    equalPairs
        "Temperature deltas"
        "K"
        [ ( Quantity.sum
                [ Temperature.celsiusDegrees 10
                , Temperature.fahrenheitDegrees 5
                ]
          , Temperature.fahrenheitDegrees 23
          )
        ]
