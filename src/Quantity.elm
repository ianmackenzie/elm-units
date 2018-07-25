module Quantity
    exposing
        ( AccelerationUnits
        , AngleUnits
        , Conversion
        , LengthUnits
        , Quantity(..)
        , ScreenSpace
        , SpeedUnits
        , TemperatureUnits
        , TimeUnits
        , WorldSpace
        , accelerationTimesTime
        , convert
        , distanceOverTime
        , per
        , perDegreeCelsius
        , perDegreeFahrenheit
        , speedOverTime
        , speedTimesTime
        )


type TimeUnits
    = TimeUnits


type AngleUnits
    = AngleUnits


type WorldSpace
    = WorldSpace


type ScreenSpace
    = ScreenSpace


type LengthUnits space
    = LengthUnits


type SpeedUnits space
    = SpeedUnits


type AccelerationUnits space
    = AccelerationUnits


type TemperatureUnits
    = TemperatureUnits


type Quantity units
    = Quantity Float


type Conversion units1 units2
    = ConversionFactor Float
    | PerDegreeCelsius Float
    | PerDegreeFahrenheit Float


per : Quantity units1 -> Quantity units2 -> Conversion units1 units2
per (Quantity referenceValue) (Quantity equivalentValue) =
    ConversionFactor (equivalentValue / referenceValue)


perDegreeCelsius : Quantity units -> Conversion TemperatureUnits units
perDegreeCelsius (Quantity scale) =
    PerDegreeCelsius scale


perDegreeFahrenheit : Quantity units -> Conversion TemperatureUnits units
perDegreeFahrenheit (Quantity scale) =
    PerDegreeFahrenheit scale


convert : Conversion units1 units2 -> Quantity units1 -> Quantity units2
convert conversion (Quantity value) =
    case conversion of
        ConversionFactor scale ->
            Quantity (scale * value)

        PerDegreeCelsius scale ->
            -- value is in Kelvins, convert to degrees Celsius
            let
                degreesCelsius =
                    value - 273.15
            in
            Quantity (scale * degreesCelsius)

        PerDegreeFahrenheit scale ->
            -- value is in Kelvins, convert to degrees Fahrenheit
            let
                degreesCelsius =
                    value - 273.15

                degreesFahrenheit =
                    32 + 1.8 * degreesCelsius
            in
            Quantity (scale * degreesFahrenheit)


distanceOverTime : Quantity (LengthUnits space) -> Quantity TimeUnits -> Quantity (SpeedUnits space)
distanceOverTime (Quantity length) (Quantity duration) =
    Quantity (length / duration)


speedTimesTime : Quantity (SpeedUnits space) -> Quantity TimeUnits -> Quantity (LengthUnits space)
speedTimesTime (Quantity speed) (Quantity duration) =
    Quantity (speed * duration)


accelerationTimesTime : Quantity (AccelerationUnits space) -> Quantity TimeUnits -> Quantity (SpeedUnits space)
accelerationTimesTime (Quantity acceleration) (Quantity duration) =
    Quantity (acceleration * duration)


speedOverTime : Quantity (SpeedUnits space) -> Quantity TimeUnits -> Quantity (AccelerationUnits space)
speedOverTime (Quantity speed) (Quantity duration) =
    Quantity (speed / duration)
