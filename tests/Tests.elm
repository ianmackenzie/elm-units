module Tests exposing
    ( angularAccelerations
    , angularSpeeds
    , conversionsToQuantityAndBack
    , densities
    , durations
    , fromDmsNegative
    , fromDmsPositive
    , illuminances
    , inductance
    , lengths
    , luminances
    , masses
    , over
    , powers
    , pressures
    , solidAngles
    , speeds
    , substanceAmount
    , temperatureDeltas
    , temperatures
    , times
    , toDmsProducesValidValues
    , toDmsReconstructsAngle
    , volumes
    )

import Acceleration exposing (..)
import Angle
import AngularAcceleration exposing (..)
import AngularSpeed exposing (..)
import Area exposing (..)
import Capacitance exposing (..)
import Charge exposing (..)
import Current exposing (..)
import Density exposing (..)
import Duration exposing (..)
import Energy exposing (..)
import Expect exposing (Expectation)
import Force exposing (..)
import Fuzz exposing (Fuzzer)
import Illuminance
import Inductance exposing (..)
import Length exposing (..)
import Luminance
import LuminousFlux
import LuminousIntensity
import Mass exposing (..)
import Molarity exposing (..)
import Pixels exposing (..)
import Power exposing (..)
import Pressure exposing (..)
import Quantity exposing (Quantity(..), at, at_, minus, per, plus, times)
import Resistance exposing (..)
import SolidAngle
import Speed exposing (..)
import SubstanceAmount exposing (..)
import Temperature exposing (Temperature)
import Test exposing (Test)
import Voltage exposing (..)
import Volume exposing (..)


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


fuzzFloatToQuantityAndBack : String -> (Float -> Quantity Float unit) -> (Quantity Float unit -> Float) -> Test
fuzzFloatToQuantityAndBack testName toQuantity fromQuantity =
    Test.fuzz (Fuzz.floatRange -10 10) testName <|
        \randomFloat ->
            Expect.within (Expect.Absolute 1.0e-12) randomFloat (randomFloat |> toQuantity |> fromQuantity)


inductance : Test
inductance =
    equalPairs
        "Inductance"
        "H"
        [ ( henries 1000
          , kilohenries 1
          )
        , ( nanohenries 1000
          , microhenries 1
          )
        , ( kilohenries 10
          , millihenries 10000000
          )
        ]


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


angularAccelerations : Test
angularAccelerations =
    equalPairs
        "Angular Accelerations"
        "rad/s"
        [ ( degreesPerSecondSquared 360
          , turnsPerSecondSquared 1
          )
        ]


angularSpeeds : Test
angularSpeeds =
    equalPairs
        "Angular Speeds"
        "rad/s"
        [ ( turnsPerSecond 1
          , turnsPerMinute 60
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


pressures : Test
pressures =
    equalPairs
        "Pressures"
        "Pa"
        [ ( atmospheres 1
          , kilopascals 101.325
          )
        ]


masses : Test
masses =
    equalPairs
        "Masses"
        "kg"
        [ ( grams 1
          , kilograms 0.001
          )
        , ( ounces 1
          , Mass.pounds 0.0625
          )
        , ( Mass.pounds 1
          , kilograms 0.45359237
          )
        ]


densities : Test
densities =
    equalPairs
        "Densities"
        "kg/m^3"
        [ ( gramsPerCubicCentimeter 1
          , kilogramsPerCubicMeter 1000
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


substanceAmount : Test
substanceAmount =
    equalPairs
        "SubstanceAmounts"
        "ν"
        [ ( nanomoles 20
          , picomoles 20000
          )
        , ( nanomoles 7000
          , micromoles 7
          )
        , ( millimoles 3
          , micromoles 3000
          )
        , ( nanomoles 1000000
          , millimoles 1
          )
        , ( centimoles 600
          , decimoles 60
          )
        , ( moles 1
          , millimoles 1000
          )
        , ( moles 4
          , centimoles 400
          )
        , ( moles 2
          , decimoles 20
          )
        , ( moles 2000
          , kilomoles 2
          )
        , ( kilomoles 1000
          , megamoles 1
          )
        , ( megamoles 1000
          , gigamoles 1
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
            , ( Temperature.absoluteZero
              , Temperature.degreesCelsius -273.15
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


volumes : Test
volumes =
    equalPairs
        "Volumes"
        "m^3"
        [ ( cubicMeters 2
          , usLiquidGallons (2 * 264.17205235814845)
          )
        , ( imperialGallons 219.96924829908778
          , usDryGallons 227.02074606721396
          )
        , ( cubicInches (36 * 36 * 36)
          , cubicYards 1
          )
        , ( usLiquidGallons 1
          , usLiquidQuarts 4
          )
        , ( usDryGallons 1
          , usDryQuarts 4
          )
        , ( imperialGallons 1
          , imperialQuarts 4
          )
        , ( usLiquidQuarts 1
          , usLiquidPints 2
          )
        , ( usDryQuarts 1
          , usDryPints 2
          )
        , ( imperialQuarts 1
          , imperialPints 2
          )
        , ( usLiquidPints 1
          , usFluidOunces 16
          )
        , ( imperialPints 1
          , imperialFluidOunces 20
          )
        ]


times : Test
times =
    Test.describe "times"
        [ equalPairs
            "Areas"
            "m^2"
            [ ( Length.feet 66 |> Quantity.times (Length.feet 660)
              , Area.acres 1
              )
            ]
        , equalPairs
            "Volumes"
            "m^3"
            [ ( Area.squareMeters 1 |> Quantity.times (Length.centimeters 1)
              , Volume.liters 10
              )
            ]
        , equalPairs
            "Forces"
            "N"
            [ ( Mass.kilograms 10 |> Quantity.times (Acceleration.gees 1)
              , Force.newtons 98.0665
              )
            ]
        , equalPairs
            "Energies"
            "J"
            [ ( Force.newtons 5 |> Quantity.times (Length.meters 4)
              , Energy.joules 20
              )
            , ( Mass.kilograms 1
                    |> Quantity.times (Acceleration.metersPerSecondSquared 2)
                    |> Quantity.times (Length.meters 3)
              , Energy.joules 6
              )
            ]
        ]


over : Test
over =
    Test.describe "over"
        [ equalPairs
            "Area / length"
            "m"
            [ ( Area.squareKilometers 1 |> Quantity.over (Length.meters 100)
              , Length.kilometers 10
              )
            ]
        , equalPairs
            "Volume / length"
            "m^2"
            [ ( Volume.liters 10 |> Quantity.over_ (Length.centimeters 10)
              , Area.squareCentimeters 1000
              )
            ]
        , equalPairs
            "Volume / area"
            "m"
            [ ( Volume.cubicMeters 1.0e7
                    |> Quantity.over
                        (Area.squareKilometers 1)
              , Length.meters 10
              )
            ]
        ]


conversionsToQuantityAndBack : Test
conversionsToQuantityAndBack =
    Test.describe "Conversion to Quantity and back is (almost) identity" <|
        [ Test.describe "Acceleration" <|
            [ fuzzFloatToQuantityAndBack "metersPerSecondSquared" Acceleration.metersPerSecondSquared Acceleration.inMetersPerSecondSquared
            , fuzzFloatToQuantityAndBack "feetPerSecondSquared" Acceleration.feetPerSecondSquared Acceleration.inFeetPerSecondSquared
            , fuzzFloatToQuantityAndBack "gees" Acceleration.gees Acceleration.inGees
            ]
        , Test.describe "Angle" <|
            [ fuzzFloatToQuantityAndBack "radians" Angle.radians Angle.inRadians
            , fuzzFloatToQuantityAndBack "degrees" Angle.degrees Angle.inDegrees
            , fuzzFloatToQuantityAndBack "turns" Angle.turns Angle.inTurns
            ]
        , Test.describe "AngularAcceleration" <|
            [ fuzzFloatToQuantityAndBack "radiansPerSecondSquared" AngularAcceleration.radiansPerSecondSquared AngularAcceleration.inRadiansPerSecondSquared
            , fuzzFloatToQuantityAndBack "degreesPerSecondSquared" AngularAcceleration.degreesPerSecondSquared AngularAcceleration.inDegreesPerSecondSquared
            , fuzzFloatToQuantityAndBack "turnsPerSecondSquared" AngularAcceleration.turnsPerSecondSquared AngularAcceleration.inTurnsPerSecondSquared
            ]
        , Test.describe "AngularSpeed" <|
            [ fuzzFloatToQuantityAndBack "radiansPerSecond" AngularSpeed.radiansPerSecond AngularSpeed.inRadiansPerSecond
            , fuzzFloatToQuantityAndBack "degreesPerSecond" AngularSpeed.degreesPerSecond AngularSpeed.inDegreesPerSecond
            , fuzzFloatToQuantityAndBack "turnsPerSecond" AngularSpeed.turnsPerSecond AngularSpeed.inTurnsPerSecond
            , fuzzFloatToQuantityAndBack "turnsPerMinute" AngularSpeed.turnsPerMinute AngularSpeed.inTurnsPerMinute
            ]
        , Test.describe "Area" <|
            [ fuzzFloatToQuantityAndBack "squareMeters" Area.squareMeters Area.inSquareMeters
            , fuzzFloatToQuantityAndBack "squareMillimeters" Area.squareMillimeters Area.inSquareMillimeters
            , fuzzFloatToQuantityAndBack "squareInches" Area.squareInches Area.inSquareInches
            , fuzzFloatToQuantityAndBack "squareCentimeters" Area.squareCentimeters Area.inSquareCentimeters
            , fuzzFloatToQuantityAndBack "squareFeet" Area.squareFeet Area.inSquareFeet
            , fuzzFloatToQuantityAndBack "squareYards" Area.squareYards Area.inSquareYards
            , fuzzFloatToQuantityAndBack "hectares" Area.hectares Area.inHectares
            , fuzzFloatToQuantityAndBack "squareKilometers" Area.squareKilometers Area.inSquareKilometers
            , fuzzFloatToQuantityAndBack "acres" Area.acres Area.inAcres
            , fuzzFloatToQuantityAndBack "squareMiles" Area.squareMiles Area.inSquareMiles
            ]
        , Test.describe "Capacitance" <|
            [ fuzzFloatToQuantityAndBack "farads" Capacitance.farads Capacitance.inFarads
            , fuzzFloatToQuantityAndBack "microfarads" Capacitance.microfarads Capacitance.inMicrofarads
            , fuzzFloatToQuantityAndBack "nanofarads" Capacitance.nanofarads Capacitance.inNanofarads
            , fuzzFloatToQuantityAndBack "picofarads" Capacitance.picofarads Capacitance.inPicofarads
            ]
        , Test.describe "Charge" <|
            [ fuzzFloatToQuantityAndBack "coulombs" Charge.coulombs Charge.inCoulombs
            , fuzzFloatToQuantityAndBack "ampereHours" Charge.ampereHours Charge.inAmpereHours
            , fuzzFloatToQuantityAndBack "milliampereHours" Charge.milliampereHours Charge.inMilliampereHours
            ]
        , Test.describe "Current" <|
            [ fuzzFloatToQuantityAndBack "ampere" Current.amperes Current.inAmperes
            , fuzzFloatToQuantityAndBack "milliampere" Current.milliamperes Current.inMilliamperes
            ]
        , Test.describe "Density" <|
            [ fuzzFloatToQuantityAndBack "kilogramsPerCubicMeter" Density.kilogramsPerCubicMeter Density.inKilogramsPerCubicMeter
            , fuzzFloatToQuantityAndBack "gramsPerCubicCentimeter" Density.gramsPerCubicCentimeter Density.inGramsPerCubicCentimeter
            , fuzzFloatToQuantityAndBack "poundsPerCubicInch" Density.poundsPerCubicInch Density.inPoundsPerCubicInch
            , fuzzFloatToQuantityAndBack "poundsPerCubicFoot" Density.poundsPerCubicFoot Density.inPoundsPerCubicFoot
            ]
        , Test.describe "Duration" <|
            [ fuzzFloatToQuantityAndBack "seconds" Duration.seconds Duration.inSeconds
            , fuzzFloatToQuantityAndBack "milliseconds" Duration.milliseconds Duration.inMilliseconds
            , fuzzFloatToQuantityAndBack "minutes" Duration.minutes Duration.inMinutes
            , fuzzFloatToQuantityAndBack "hours" Duration.hours Duration.inHours
            , fuzzFloatToQuantityAndBack "days" Duration.days Duration.inDays
            , fuzzFloatToQuantityAndBack "weeks" Duration.weeks Duration.inWeeks
            , fuzzFloatToQuantityAndBack "julianYears" Duration.julianYears Duration.inJulianYears
            ]
        , Test.describe "Energy" <|
            [ fuzzFloatToQuantityAndBack "joules" Energy.joules Energy.inJoules
            , fuzzFloatToQuantityAndBack "kilojoules" Energy.kilojoules Energy.inKilojoules
            , fuzzFloatToQuantityAndBack "megajoules" Energy.megajoules Energy.inMegajoules
            , fuzzFloatToQuantityAndBack "kilowattHours" Energy.kilowattHours Energy.inKilowattHours
            ]
        , Test.describe "Force" <|
            [ fuzzFloatToQuantityAndBack "newtons" Force.newtons Force.inNewtons
            , fuzzFloatToQuantityAndBack "kilonewtons" Force.kilonewtons Force.inKilonewtons
            , fuzzFloatToQuantityAndBack "meganewtons" Force.meganewtons Force.inMeganewtons
            , fuzzFloatToQuantityAndBack "pounds" Force.pounds Force.inPounds
            , fuzzFloatToQuantityAndBack "kips" Force.kips Force.inKips
            ]
        , Test.describe "Inductance" <|
            [ fuzzFloatToQuantityAndBack "henries" Inductance.henries Inductance.inHenries
            , fuzzFloatToQuantityAndBack "millihenries" Inductance.millihenries Inductance.inMillihenries
            , fuzzFloatToQuantityAndBack "microhenries" Inductance.microhenries Inductance.inMicrohenries
            , fuzzFloatToQuantityAndBack "nanohenries" Inductance.nanohenries Inductance.inNanohenries
            , fuzzFloatToQuantityAndBack "kilohenries" Inductance.kilohenries Inductance.inKilohenries
            ]
        , Test.describe "Length" <|
            [ fuzzFloatToQuantityAndBack "meters" Length.meters Length.inMeters
            , fuzzFloatToQuantityAndBack "microns" Length.microns Length.inMicrons
            , fuzzFloatToQuantityAndBack "millimeters" Length.millimeters Length.inMillimeters
            , fuzzFloatToQuantityAndBack "thou" Length.thou Length.inThou
            , fuzzFloatToQuantityAndBack "inches" Length.inches Length.inInches
            , fuzzFloatToQuantityAndBack "centimeters" Length.centimeters Length.inCentimeters
            , fuzzFloatToQuantityAndBack "feet" Length.feet Length.inFeet
            , fuzzFloatToQuantityAndBack "yards" Length.yards Length.inYards
            , fuzzFloatToQuantityAndBack "kilometers" Length.kilometers Length.inKilometers
            , fuzzFloatToQuantityAndBack "miles" Length.miles Length.inMiles
            , fuzzFloatToQuantityAndBack "astronomicalUnits" Length.astronomicalUnits Length.inAstronomicalUnits
            , fuzzFloatToQuantityAndBack "parsecs" Length.parsecs Length.inParsecs
            , fuzzFloatToQuantityAndBack "lightYears" Length.lightYears Length.inLightYears
            ]
        , Test.describe "Mass" <|
            [ fuzzFloatToQuantityAndBack "kilograms" Mass.kilograms Mass.inKilograms
            , fuzzFloatToQuantityAndBack "grams" Mass.grams Mass.inGrams
            , fuzzFloatToQuantityAndBack "pounds" Mass.pounds Mass.inPounds
            , fuzzFloatToQuantityAndBack "ounces" Mass.ounces Mass.inOunces
            , fuzzFloatToQuantityAndBack "metricTons" Mass.metricTons Mass.inMetricTons
            , fuzzFloatToQuantityAndBack "shortTons" Mass.shortTons Mass.inShortTons
            , fuzzFloatToQuantityAndBack "longTons" Mass.longTons Mass.inLongTons
            ]
        , Test.describe "Molarity" <|
            [ fuzzFloatToQuantityAndBack "molesPerCubicMeter" Molarity.molesPerCubicMeter Molarity.inMolesPerCubicMeter
            , fuzzFloatToQuantityAndBack "decimolesPerLiter" Molarity.decimolesPerLiter Molarity.inDecimolesPerLiter
            , fuzzFloatToQuantityAndBack "centimolesPerLiter" Molarity.centimolesPerLiter Molarity.inCentimolesPerLiter
            , fuzzFloatToQuantityAndBack "millimolesPerLiter" Molarity.millimolesPerLiter Molarity.inMillimolesPerLiter
            , fuzzFloatToQuantityAndBack "micromolesPerLiter" Molarity.micromolesPerLiter Molarity.inMicromolesPerLiter
            ]
        , Test.describe "Pixels" <|
            [ fuzzFloatToQuantityAndBack "pixels" Pixels.pixels Pixels.inPixels
            , fuzzFloatToQuantityAndBack "pixelsPerSecond" Pixels.pixelsPerSecond Pixels.inPixelsPerSecond
            , fuzzFloatToQuantityAndBack "pixelsPerSecondSquared" Pixels.pixelsPerSecondSquared Pixels.inPixelsPerSecondSquared
            , fuzzFloatToQuantityAndBack "squarePixels" Pixels.squarePixels Pixels.inSquarePixels
            ]
        , Test.describe "Power" <|
            [ fuzzFloatToQuantityAndBack "watts" Power.watts Power.inWatts
            , fuzzFloatToQuantityAndBack "kilowatts" Power.kilowatts Power.inKilowatts
            , fuzzFloatToQuantityAndBack "megawatts" Power.megawatts Power.inMegawatts
            , fuzzFloatToQuantityAndBack "metricHorsepower" Power.metricHorsepower Power.inMetricHorsepower
            , fuzzFloatToQuantityAndBack "mechanicalHorsepower" Power.mechanicalHorsepower Power.inMechanicalHorsepower
            , fuzzFloatToQuantityAndBack "electricalHorsepower" Power.electricalHorsepower Power.inElectricalHorsepower
            ]
        , Test.describe "Pressure" <|
            [ fuzzFloatToQuantityAndBack "pascals" Pressure.pascals Pressure.inPascals
            , fuzzFloatToQuantityAndBack "kilopascals" Pressure.kilopascals Pressure.inKilopascals
            , fuzzFloatToQuantityAndBack "megapascals" Pressure.megapascals Pressure.inMegapascals
            , fuzzFloatToQuantityAndBack "poundsPerSquareInch" Pressure.poundsPerSquareInch Pressure.inPoundsPerSquareInch
            , fuzzFloatToQuantityAndBack "atmospheres" Pressure.atmospheres Pressure.inAtmospheres
            ]
        , Test.describe "Resistance" <|
            [ fuzzFloatToQuantityAndBack "ohms" Resistance.ohms Resistance.inOhms
            ]
        , Test.describe "Speed" <|
            [ fuzzFloatToQuantityAndBack "metersPerSecond" Speed.metersPerSecond Speed.inMetersPerSecond
            , fuzzFloatToQuantityAndBack "feetPerSecond" Speed.feetPerSecond Speed.inFeetPerSecond
            , fuzzFloatToQuantityAndBack "kilometersPerHour" Speed.kilometersPerHour Speed.inKilometersPerHour
            , fuzzFloatToQuantityAndBack "milesPerHour" Speed.milesPerHour Speed.inMilesPerHour
            ]
        , Test.describe "SubstanceAmount" <|
            [ fuzzFloatToQuantityAndBack "moles" SubstanceAmount.moles SubstanceAmount.inMoles
            , fuzzFloatToQuantityAndBack "picomoles" SubstanceAmount.picomoles SubstanceAmount.inPicomoles
            , fuzzFloatToQuantityAndBack "nanomoles" SubstanceAmount.nanomoles SubstanceAmount.inNanomoles
            , fuzzFloatToQuantityAndBack "micromoles" SubstanceAmount.micromoles SubstanceAmount.inMicromoles
            , fuzzFloatToQuantityAndBack "millimoles" SubstanceAmount.millimoles SubstanceAmount.inMillimoles
            , fuzzFloatToQuantityAndBack "centimoles" SubstanceAmount.centimoles SubstanceAmount.inCentimoles
            , fuzzFloatToQuantityAndBack "decimoles" SubstanceAmount.decimoles SubstanceAmount.inDecimoles
            , fuzzFloatToQuantityAndBack "kilomoles" SubstanceAmount.kilomoles SubstanceAmount.inKilomoles
            , fuzzFloatToQuantityAndBack "megamoles" SubstanceAmount.megamoles SubstanceAmount.inMegamoles
            , fuzzFloatToQuantityAndBack "gigamoles" SubstanceAmount.gigamoles SubstanceAmount.inGigamoles
            ]
        , Test.describe "Temperature" <|
            [ fuzzFloatToQuantityAndBack "celsiusDegrees" Temperature.celsiusDegrees Temperature.inCelsiusDegrees
            , fuzzFloatToQuantityAndBack "fahrenheitDegrees" Temperature.fahrenheitDegrees Temperature.inFahrenheitDegrees
            ]
        , Test.describe "Voltage" <|
            [ fuzzFloatToQuantityAndBack "volts" Voltage.volts Voltage.inVolts
            ]
        , Test.describe "Volume" <|
            [ fuzzFloatToQuantityAndBack "cubicMeters" Volume.cubicMeters Volume.inCubicMeters
            , fuzzFloatToQuantityAndBack "cubicInches" Volume.cubicInches Volume.inCubicInches
            , fuzzFloatToQuantityAndBack "cubicFeet" Volume.cubicFeet Volume.inCubicFeet
            , fuzzFloatToQuantityAndBack "cubicYards" Volume.cubicYards Volume.inCubicYards
            , fuzzFloatToQuantityAndBack "milliliters" Volume.milliliters Volume.inMilliliters
            , fuzzFloatToQuantityAndBack "liters" Volume.liters Volume.inLiters
            , fuzzFloatToQuantityAndBack "usLiquidGallons" Volume.usLiquidGallons Volume.inUsLiquidGallons
            , fuzzFloatToQuantityAndBack "usDryGallons" Volume.usDryGallons Volume.inUsDryGallons
            , fuzzFloatToQuantityAndBack "imperialGallons" Volume.imperialGallons Volume.inImperialGallons
            , fuzzFloatToQuantityAndBack "usLiquidQuarts" Volume.usLiquidQuarts Volume.inUsLiquidQuarts
            , fuzzFloatToQuantityAndBack "usDryQuarts" Volume.usDryQuarts Volume.inUsDryQuarts
            , fuzzFloatToQuantityAndBack "imperialQuarts" Volume.imperialQuarts Volume.inImperialQuarts
            , fuzzFloatToQuantityAndBack "usLiquidPints" Volume.usLiquidPints Volume.inUsLiquidPints
            , fuzzFloatToQuantityAndBack "usDryPints" Volume.usDryPints Volume.inUsDryPints
            , fuzzFloatToQuantityAndBack "imperialPints" Volume.imperialPints Volume.inImperialPints
            , fuzzFloatToQuantityAndBack "usFluidOunces" Volume.usFluidOunces Volume.inUsFluidOunces
            , fuzzFloatToQuantityAndBack "imperialFluidOunces" Volume.imperialFluidOunces Volume.inImperialFluidOunces
            ]
        , Test.describe "SolidAngle" <|
            [ fuzzFloatToQuantityAndBack "steradians" SolidAngle.steradians SolidAngle.inSteradians
            , fuzzFloatToQuantityAndBack "spats" SolidAngle.spats SolidAngle.inSpats
            , fuzzFloatToQuantityAndBack "squareDegrees" SolidAngle.squareDegrees SolidAngle.inSquareDegrees
            ]
        , Test.describe "LuminousFlux" <|
            [ fuzzFloatToQuantityAndBack "lumens" LuminousFlux.lumens LuminousFlux.inLumens
            ]
        , Test.describe "Illuminance" <|
            [ fuzzFloatToQuantityAndBack "lux" Illuminance.lux Illuminance.inLux
            , fuzzFloatToQuantityAndBack "footCandles" Illuminance.footCandles Illuminance.inFootCandles
            ]
        , Test.describe "LuminousIntensity" <|
            [ fuzzFloatToQuantityAndBack "candelas" LuminousIntensity.candelas LuminousIntensity.inCandelas
            ]
        , Test.describe "Luminance" <|
            [ fuzzFloatToQuantityAndBack "nits" Luminance.nits Luminance.inNits
            , fuzzFloatToQuantityAndBack "footLambers" Luminance.footLamberts Luminance.inFootLamberts
            ]
        ]


fromDmsPositive : Test
fromDmsPositive =
    Test.fuzz3
        (Fuzz.intRange 0 1000)
        (Fuzz.intRange 0 59)
        (Fuzz.floatRange 0 60)
        "toDms works for positive angles"
        (\numDegrees numMinutes numSeconds ->
            let
                angle1 =
                    Angle.fromDms
                        { sign = Angle.Positive
                        , degrees = numDegrees
                        , minutes = numMinutes
                        , seconds = numSeconds
                        }

                angle2 =
                    Quantity.sum
                        [ Angle.degrees (toFloat numDegrees)
                        , Angle.minutes (toFloat numMinutes)
                        , Angle.seconds numSeconds
                        ]
            in
            Expect.within (Expect.Absolute 1.0e-12)
                (Angle.inRadians angle1)
                (Angle.inRadians angle2)
        )


fromDmsNegative : Test
fromDmsNegative =
    Test.fuzz3
        (Fuzz.intRange 0 1000)
        (Fuzz.intRange 0 59)
        (Fuzz.floatRange 0 60)
        "toDms works for negative angles"
        (\numDegrees numMinutes numSeconds ->
            let
                angle1 =
                    Angle.fromDms
                        { sign = Angle.Negative
                        , degrees = numDegrees
                        , minutes = numMinutes
                        , seconds = numSeconds
                        }

                angle2 =
                    Quantity.negate <|
                        Quantity.sum
                            [ Angle.degrees (toFloat numDegrees)
                            , Angle.minutes (toFloat numMinutes)
                            , Angle.seconds numSeconds
                            ]
            in
            Expect.within (Expect.Absolute 1.0e-12)
                (Angle.inRadians angle1)
                (Angle.inRadians angle2)
        )


toDmsReconstructsAngle : Test
toDmsReconstructsAngle =
    Test.fuzz (Fuzz.map Angle.degrees (Fuzz.floatRange 0 1000))
        "toDms reconstructs angles properly"
        (\originalAngle ->
            let
                { degrees, minutes, seconds } =
                    Angle.toDms originalAngle

                reconstructedAngle =
                    Quantity.sum
                        [ Angle.degrees (toFloat degrees)
                        , Angle.minutes (toFloat minutes)
                        , Angle.seconds seconds
                        ]
            in
            Expect.within (Expect.Absolute 1.0e-12)
                (Angle.inRadians originalAngle)
                (Angle.inRadians reconstructedAngle)
        )


toDmsProducesValidValues : Test
toDmsProducesValidValues =
    Test.fuzz (Fuzz.map Angle.degrees (Fuzz.floatRange 0 1000))
        "toDms only produces values in the valid range"
        (\angle ->
            let
                dms =
                    Angle.toDms angle
            in
            dms
                |> Expect.all
                    [ .degrees >> Expect.atLeast 0
                    , .minutes >> Expect.atLeast 0
                    , .minutes >> Expect.lessThan 60
                    , .seconds >> Expect.atLeast 0
                    , .seconds >> Expect.lessThan 60
                    ]
        )


solidAngles : Test
solidAngles =
    equalPairs
        "SolidAngles"
        "sr"
        [ ( SolidAngle.spats 1
          , SolidAngle.steradians (4 * pi)
          )
        , ( SolidAngle.squareDegrees 1
          , SolidAngle.steradians ((pi / 180) ^ 2)
          )
        ]


luminances : Test
luminances =
    equalPairs
        "Luminance"
        "nt"
        [ ( Luminance.footLamberts 1
          , LuminousIntensity.candelas (1 / pi)
                |> Quantity.per (Area.squareFeet 1)
          )
        , ( Luminance.nits 1
          , LuminousIntensity.candelas 1 |> Quantity.per (Area.squareMeters 1)
          )
        ]


illuminances : Test
illuminances =
    equalPairs
        "Illuminance"
        "lx"
        [ ( Illuminance.footCandles 1
          , LuminousFlux.lumens 1 |> Quantity.per (Area.squareFeet 1)
          )
        ]
