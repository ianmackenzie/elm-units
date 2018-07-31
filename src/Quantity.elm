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
        , perUnit
        , product
        , ratio
        , scaleBy
        , sort
        , sqrt
        , squared
        , sum
        , units
        , zero
        )


type Quantity units
    = Quantity Float


type Squared units
    = Squared Never


type Rate dependent independent
    = Rate Never


value : Quantity units -> Float
value (Quantity x) =
    x


zero : Quantity units
zero =
    Quantity 0



-- Comparison


lessThan : Quantity units -> Quantity units -> Bool
lessThan (Quantity y) (Quantity x) =
    x < y


greaterThan : Quantity units -> Quantity units -> Bool
greaterThan (Quantity y) (Quantity x) =
    x > y


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


negate : Quantity units -> Quantity units
negate (Quantity x) =
    Quantity -x


add : Quantity units -> Quantity units -> Quantity units
add (Quantity x) (Quantity y) =
    Quantity (x + y)


difference : Quantity units -> Quantity units -> Quantity units
difference (Quantity x) (Quantity y) =
    Quantity (x - y)


product : Quantity units -> Quantity units -> Quantity (Squared units)
product (Quantity x) (Quantity y) =
    Quantity (x * y)


ratio : Quantity units -> Quantity units -> Float
ratio (Quantity x) (Quantity y) =
    x / y


scaleBy : Float -> Quantity units -> Quantity units
scaleBy scale (Quantity x) =
    Quantity (scale * x)


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



-- List functions


sum : List (Quantity units) -> Quantity units
sum quantities =
    List.foldl add (Quantity 0) quantities


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



-- Working with rates


per : Quantity independent -> Quantity dependent -> Quantity (Rate dependent independent)
per (Quantity independentValue) (Quantity dependentValue) =
    Quantity (dependentValue / independentValue)


for : Quantity independent -> Quantity (Rate dependent independent) -> Quantity dependent
for (Quantity independentValue) (Quantity rate) =
    Quantity (rate * independentValue)


at : Quantity (Rate dependent independent) -> Quantity independent -> Quantity dependent
at (Quantity rate) (Quantity independentValue) =
    Quantity (rate * independentValue)


at_ : Quantity (Rate dependent independent) -> Quantity dependent -> Quantity independent
at_ (Quantity rate) (Quantity dependentValue) =
    Quantity (dependentValue / rate)



-- Generic quantities


type Units
    = Units


units : Float -> Quantity Units
units x =
    Quantity x


inUnits : Quantity Units -> Float
inUnits (Quantity x) =
    x


perUnit : Quantity units -> Quantity (Rate units Units)
perUnit quantity =
    per (units 1) quantity
