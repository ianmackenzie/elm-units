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
