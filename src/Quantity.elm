module Quantity
    exposing
        ( Acceleration
        , AccelerationUnits
        , Angle
        , AngleUnits
        , Duration
        , Length
        , LengthUnits
        , Quantity(..)
        , ScreenSpace
        , Speed
        , SpeedUnits
        , Temperature
        , TemperatureUnits
        , TimeUnits
        , WorldSpace
        , abs
        , acceleration
        , acos
        , asin
        , atan
        , atan2
        , clamp
        , compare
        , cos
        , distance
        , greaterThan
        , lessThan
        , max
        , maximum
        , min
        , minimum
        , minus
        , negate
        , plus
        , ratio
        , sin
        , sort
        , speed
        , speedup
        , sqrt
        , squared
        , sum
        , tan
        , times
        )

-- Unit types


type Squared units
    = Squared Never


type TimeUnits
    = TimeUnits Never


type AngleUnits
    = AngleUnits Never


type WorldSpace
    = WorldSpace Never


type ScreenSpace
    = ScreenSpace Never


type LengthUnits space
    = LengthUnits Never


type SpeedUnits space
    = SpeedUnits Never


type AccelerationUnits space
    = AccelerationUnits Never


type TemperatureUnits
    = TemperatureUnits Never



-- Quantity types


type Quantity units
    = Quantity Float


type alias Duration =
    -- Seconds
    Quantity TimeUnits


type alias Angle =
    -- Radians
    Quantity AngleUnits


type alias Length space =
    -- Meters for WorldSpace
    -- Pixels for ScreenSpace
    Quantity (LengthUnits space)


type alias Speed space =
    -- Meters per second for WorldSpace
    -- Pixels per second for ScreenSpace
    Quantity (SpeedUnits space)


type alias Acceleration space =
    -- Meters per second squared for WorldSpace
    -- Pixels per second squared for ScreenSpace
    Quantity (AccelerationUnits space)


type alias Temperature =
    -- Kelvins
    Quantity TemperatureUnits


value : Quantity units -> Float
value (Quantity x) =
    x



-- 'Infix' operators


negate : Quantity units -> Quantity units
negate (Quantity x) =
    Quantity -x


plus : Quantity units -> Quantity units -> Quantity units
plus (Quantity y) (Quantity x) =
    Quantity (x + y)


minus : Quantity units -> Quantity units -> Quantity units
minus (Quantity y) (Quantity x) =
    Quantity (x - y)


times : Float -> Quantity units -> Quantity units
times scale (Quantity x) =
    Quantity (scale * x)


lessThan : Quantity units -> Quantity units -> Bool
lessThan (Quantity y) (Quantity x) =
    x < y


greaterThan : Quantity units -> Quantity units -> Bool
greaterThan (Quantity y) (Quantity x) =
    x > y



-- Comparison


compare : Quantity units -> Quantity units -> Order
compare (Quantity x) (Quantity y) =
    Basics.compare x y


max : Quantity units -> Quantity units -> Quantity units
max (Quantity x) (Quantity y) =
    Quantity (Basics.max x y)


min : Quantity units -> Quantity units -> Quantity units
min (Quantity x) (Quantity y) =
    Quantity (Basics.min x y)



-- Arithmetic


abs : Quantity units -> Quantity units
abs (Quantity x) =
    Quantity (Basics.abs x)


clamp : Quantity units -> Quantity units -> Quantity units -> Quantity units
clamp (Quantity lower) (Quantity upper) (Quantity x) =
    Quantity (Basics.clamp lower upper x)


squared : Quantity units -> Quantity (Squared units)
squared (Quantity x) =
    Quantity (x * x)


sqrt : Quantity (Squared units) -> Quantity units
sqrt (Quantity x) =
    Quantity (Basics.sqrt x)


ratio : Quantity units -> Quantity units -> Float
ratio (Quantity x) (Quantity y) =
    x / y



-- Trigonometry


sin : Angle -> Float
sin (Quantity angle) =
    Basics.sin angle


cos : Angle -> Float
cos (Quantity angle) =
    Basics.cos angle


tan : Angle -> Float
tan (Quantity angle) =
    Basics.tan angle


asin : Float -> Angle
asin x =
    Quantity (Basics.asin x)


acos : Float -> Angle
acos x =
    Quantity (Basics.acos x)


atan : Float -> Angle
atan x =
    Quantity (Basics.atan x)


atan2 : Quantity units -> Quantity units -> Angle
atan2 (Quantity y) (Quantity x) =
    Quantity (Basics.atan2 y x)



-- List functions


sum : List (Quantity units) -> Quantity units
sum quantities =
    List.foldl plus (Quantity 0) quantities


minimum : List (Quantity units) -> Maybe (Quantity units)
minimum quantities =
    case quantities of
        [] ->
            Nothing

        first :: rest ->
            Just (List.foldl min first rest)


maximum : List (Quantity units) -> Maybe (Quantity units)
maximum quantities =
    case quantities of
        [] ->
            Nothing

        first :: rest ->
            Just (List.foldl max first rest)


sort : List (Quantity units) -> List (Quantity units)
sort quantities =
    List.sortBy value quantities



-- Basic constructors/conversions


speed : Length space -> Duration -> Speed space
speed (Quantity d) (Quantity t) =
    Quantity (d / t)


distance : Duration -> Speed space -> Length space
distance (Quantity t) (Quantity v) =
    Quantity (v * t)


speedup : Duration -> Acceleration space -> Speed space
speedup (Quantity t) (Quantity a) =
    Quantity (a * t)


acceleration : Speed space -> Duration -> Acceleration space
acceleration (Quantity v) (Quantity t) =
    Quantity (v / t)
