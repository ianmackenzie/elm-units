module Quantity
    exposing
        ( Fractional
        , Quantity(..)
        , Rate
        , Squared
        , Units
        , Whole
        , abs
        , add
        , at
        , at_
        , clamp
        , compare
        , difference
        , for
        , greaterThan
        , inUnits
        , lessThan
        , max
        , maximum
        , min
        , minimum
        , negate
        , per
        , product
        , ratio
        , scaleBy
        , sort
        , sqrt
        , squared
        , sum
        , toFractional
        , units
        , zero
        )


type Quantity number units
    = Quantity number


type alias Whole units =
    Quantity Int units


type alias Fractional units =
    Quantity Float units


type Squared units
    = Squared Never


type RateUnits dependentUnits independentUnits
    = RateUnits Never


type alias Rate dependentUnits independentUnits =
    Fractional (RateUnits dependentUnits independentUnits)


unwrap : Quantity number units -> number
unwrap (Quantity value) =
    value


zero : Quantity number units
zero =
    Quantity 0


toFractional : Whole units -> Fractional units
toFractional (Quantity value) =
    Quantity (Basics.toFloat value)



-- Comparison


lessThan : Quantity number units -> Quantity number units -> Bool
lessThan (Quantity y) (Quantity x) =
    x < y


greaterThan : Quantity number units -> Quantity number units -> Bool
greaterThan (Quantity y) (Quantity x) =
    x > y


compare : Quantity number units -> Quantity number units -> Order
compare (Quantity x) (Quantity y) =
    Basics.compare x y


max : Quantity number units -> Quantity number units -> Quantity number units
max (Quantity x) (Quantity y) =
    Quantity (Basics.max x y)


min : Quantity number units -> Quantity number units -> Quantity number units
min (Quantity x) (Quantity y) =
    Quantity (Basics.min x y)



-- Arithmetic


negate : Quantity number units -> Quantity number units
negate (Quantity value) =
    Quantity -value


add : Quantity number units -> Quantity number units -> Quantity number units
add (Quantity x) (Quantity y) =
    Quantity (x + y)


difference : Quantity number units -> Quantity number units -> Quantity number units
difference (Quantity x) (Quantity y) =
    Quantity (x - y)


product : Quantity number units -> Quantity number units -> Quantity number (Squared units)
product (Quantity x) (Quantity y) =
    Quantity (x * y)


ratio : Fractional units -> Fractional units -> Float
ratio (Quantity x) (Quantity y) =
    x / y


scaleBy : number -> Quantity number units -> Quantity number units
scaleBy scale (Quantity value) =
    Quantity (scale * value)


abs : Quantity number units -> Quantity number units
abs (Quantity value) =
    Quantity (Basics.abs value)


clamp : Quantity number units -> Quantity number units -> Quantity number units -> Quantity number units
clamp (Quantity lower) (Quantity upper) (Quantity value) =
    Quantity (Basics.clamp lower upper value)


squared : Quantity number units -> Quantity number (Squared units)
squared (Quantity value) =
    Quantity (value * value)


sqrt : Fractional (Squared units) -> Fractional units
sqrt (Quantity value) =
    Quantity (Basics.sqrt value)



-- List functions


sum : List (Quantity number units) -> Quantity number units
sum quantities =
    List.foldl add (Quantity 0) quantities


minimum : List (Quantity number units) -> Maybe (Quantity number units)
minimum quantities =
    case quantities of
        [] ->
            Nothing

        first :: rest ->
            Just (List.foldl min first rest)


maximum : List (Quantity number units) -> Maybe (Quantity number units)
maximum quantities =
    case quantities of
        [] ->
            Nothing

        first :: rest ->
            Just (List.foldl max first rest)


sort : List (Quantity number units) -> List (Quantity number units)
sort quantities =
    List.sortBy unwrap quantities



-- Working with rates


per : Fractional independentUnits -> Fractional dependentUnits -> Rate dependentUnits independentUnits
per (Quantity independentValue) (Quantity dependentValue) =
    Quantity (dependentValue / independentValue)


for : Fractional independentUnits -> Rate dependentUnits independentUnits -> Fractional dependentUnits
for (Quantity independentValue) (Quantity rate) =
    Quantity (rate * independentValue)


at : Rate dependentUnits independentUnits -> Fractional independentUnits -> Fractional dependentUnits
at (Quantity rate) (Quantity independentValue) =
    Quantity (rate * independentValue)


at_ : Rate dependentUnits independentUnits -> Fractional dependentUnits -> Fractional independentUnits
at_ (Quantity rate) (Quantity dependentValue) =
    Quantity (dependentValue / rate)



-- Generic quantities


type Units
    = Units


units : number -> Quantity number Units
units value =
    Quantity value


inUnits : Quantity number Units -> number
inUnits (Quantity value) =
    value
