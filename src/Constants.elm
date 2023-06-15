module Constants exposing
    ( acre
    , astronomicalUnit
    , atmosphere
    , bushel
    , cssPixel
    , cubicFoot
    , cubicInch
    , cubicMeter
    , cubicYard
    , day
    , electricalHorsepower
    , foot
    , gee
    , hour
    , imperialFluidOunce
    , imperialGallon
    , imperialPint
    , imperialQuart
    , inch
    , julianYear
    , lightYear
    , liter
    , longTon
    , mechanicalHorsepower
    , meter
    , metricHorsepower
    , mile
    , mole
    , newton
    , newtonMeter
    , ounce
    , parsec
    , pascal
    , peck
    , pica
    , point
    , pound
    , poundFoot
    , poundForce
    , shortTon
    , squareFoot
    , squareInch
    , squareMile
    , squareYard
    , usDryGallon
    , usDryPint
    , usDryQuart
    , usFluidOunce
    , usLiquidGallon
    , usLiquidPint
    , usLiquidQuart
    , watt
    , week
    , yard
    )

{-| All conversion factors sourced from [National Institute of Standards and Technology (NIST)][1]
unless otherwise specified.

[1]: https://www.nist.gov/pml/weights-and-measures/publications/nist-handbooks/handbook-44

-}

---------- UNITS OF LENGTH (in meters)  ----------


astronomicalUnit : Float
astronomicalUnit =
    149597870700 * meter


lightYear : Float
lightYear =
    9460730472580800 * meter


parsec : Float
parsec =
    (648000 / pi) * astronomicalUnit


meter : Float
meter =
    1.0


inch : Float
inch =
    0.0254 * meter


foot : Float
foot =
    12 * inch


yard : Float
yard =
    3 * foot


mile : Float
mile =
    5280 * foot


cssPixel : Float
cssPixel =
    inch / 96


point : Float
point =
    inch / 72


pica : Float
pica =
    inch / 6



---------- UNITS OF AREA (in squared meters) ----------


squareInch : Float
squareInch =
    inch * inch


squareFoot : Float
squareFoot =
    foot * foot


squareYard : Float
squareYard =
    yard * yard


squareMile : Float
squareMile =
    mile * mile


acre : Float
acre =
    43560 * squareFoot



---------- UNITS OF VOLUME (in cubic meters) ----------


cubicMeter : Float
cubicMeter =
    meter * meter * meter


liter : Float
liter =
    0.001 * cubicMeter


{-| Sourced from [UK Weights and Measures Act][1]. One imperial gallon is equal to
4.54609 cubic decimeters (formerly defined as the volume of one kilogram
of pure water under standard conditions, now equal to 1 liter).

[1]: https://www.legislation.gov.uk/ukpga/1985/72#tgp10-tbl10-tbd1-tr22

-}
imperialGallon : Float
imperialGallon =
    4.54609 * liter


imperialQuart : Float
imperialQuart =
    imperialGallon / 4


imperialPint : Float
imperialPint =
    imperialQuart / 2


imperialFluidOunce : Float
imperialFluidOunce =
    imperialPint / 20


cubicInch : Float
cubicInch =
    inch * inch * inch


cubicFoot : Float
cubicFoot =
    foot * foot * foot


cubicYard : Float
cubicYard =
    yard * yard * yard


usLiquidGallon : Float
usLiquidGallon =
    231 * cubicInch


usLiquidQuart : Float
usLiquidQuart =
    usLiquidGallon / 4


usLiquidPint : Float
usLiquidPint =
    usLiquidQuart / 2


usFluidOunce : Float
usFluidOunce =
    usLiquidPint / 16


bushel : Float
bushel =
    2150.42 * cubicInch


peck : Float
peck =
    bushel / 4


usDryGallon : Float
usDryGallon =
    peck / 2


usDryQuart : Float
usDryQuart =
    67.200625 * cubicInch


usDryPint : Float
usDryPint =
    usDryQuart / 2



---------- UNITS OF  MASS (in kilograms) ----------


longTon : Float
longTon =
    2240 * pound


shortTon : Float
shortTon =
    2000 * pound


kilogram : Float
kilogram =
    1


pound : Float
pound =
    0.45359237 * kilogram


ounce : Float
ounce =
    pound / 16



---------- UNITS OF DURATION (in seconds) ----------


second : Float
second =
    1


minute : Float
minute =
    60 * second


hour : Float
hour =
    60 * minute


day : Float
day =
    24 * hour


week : Float
week =
    7 * day


julianYear : Float
julianYear =
    365.25 * day



---------- UNITS OF SUBSTANCE AMOUNT (in moles) ----------


mole : Float
mole =
    1



---------- UNITS OF ACELERATION (in meters per second squared) ----------


gee : Float
gee =
    9.80665 * meter / (second * second)



---------- UNITS OF FORCE (in newtons) ----------


poundForce : Float
poundForce =
    4.4482216152605 * newton


newton : Float
newton =
    kilogram * meter / (second * second)



---------- UNITS OF POWER (in watts) ----------


electricalHorsepower : Float
electricalHorsepower =
    746 * watt


mechanicalHorsepower : Float
mechanicalHorsepower =
    33000 * foot * poundForce / minute


metricHorsepower : Float
metricHorsepower =
    75 * kilogram * gee * meter / second


watt : Float
watt =
    newton * meter / second



---------- UNITS OF PRESSURE (in pascals) ----------


atmosphere : Float
atmosphere =
    101325 * pascal


pascal : Float
pascal =
    newton / (meter * meter)



-------- UNITS OF TORQUE (in newton-meters) ---------


newtonMeter : Float
newtonMeter =
    newton * meter


poundFoot : Float
poundFoot =
    poundForce * foot
