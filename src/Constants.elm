module Constants exposing (acre, bushel, cubicFoot, cubicInch, cubicMeter, cubicYard, foot, imperialGallon, inch, liter, meter, mile, peck, squareFoot, squareInch, squareMile, squareYard, usDryGallon, usDryPint, usDryQuart, usFluidOunce, usLiquidGallon, usLiquidPint, usLiquidQuart, yard)

-- Sourced from National Institute of Standards and Technology (NIST) unless otherwise specified.
---------- LENGTHS ----------


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



---------- AREAS ----------


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



---------- VOLUMES ----------


cubicMeter : Float
cubicMeter =
    meter * meter * meter


liter : Float
liter =
    0.001 * cubicMeter



-- Sourced from UK Weights and Measures Act


imperialGallon : Float
imperialGallon =
    4.54609 * liter


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
