module Quantity
    exposing
        ( Quantity(..)
        , Rate
        , Squared
        , Units
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
        , toFloat
        , units
        , zero
        )


type Quantity number units
    = Quantity number


type Squared units
    = Squared Never


type RateUnits dependent independent
    = RateUnits Never


type alias Rate dependent independent =
    Quantity Float (RateUnits dependent independent)


unwrap : Quantity number units -> number
unwrap (Quantity value) =
    value


zero : Quantity number units
zero =
    Quantity 0


toFloat : Quantity Int units -> Quantity Float units
toFloat (Quantity value) =
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


ratio : Quantity Float units -> Quantity Float units -> Float
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


sqrt : Quantity Float (Squared units) -> Quantity Float units
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


per : Quantity Float independent -> Quantity Float dependent -> Rate dependent independent
per (Quantity independentValue) (Quantity dependentValue) =
    Quantity (dependentValue / independentValue)


for : Quantity Float independent -> Rate dependent independent -> Quantity Float dependent
for (Quantity independentValue) (Quantity rate) =
    Quantity (rate * independentValue)


at : Rate dependent independent -> Quantity Float independent -> Quantity Float dependent
at (Quantity rate) (Quantity independentValue) =
    Quantity (rate * independentValue)


at_ : Rate dependent independent -> Quantity Float dependent -> Quantity Float independent
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
