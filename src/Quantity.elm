module Quantity
    exposing
        ( AccelerationUnits
        , AngleUnits
        , LengthUnits
        , Quantity(..)
        , ScreenSpace
        , SpeedUnits
        , TemperatureUnits
        , TimeUnits
        , WorldSpace
        , accelerationTimesTime
        , distanceOverTime
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
