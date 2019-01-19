module Constants exposing (bushel, centimeter, cubicFoot, cubicInch, cubicMeter, cubicYard, foot, imperialGallon, inch, liter, meter, mile, peck, usLiquidGallon, usLiquidQuart, yard)

-- Sourced from National Institute of Standards and Technology (NIST) unless otherwise specified.
---------- LENGTHS ----------


meter : Float
meter =
    1.0


centimeter : Float
centimeter =
    0.01 * meter


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
    0.25 * usLiquidGallon


bushel : Float
bushel =
    2150.42 * cubicInch


peck : Float
peck =
    0.25 * bushel
