module ConversionFactors exposing (metersPerInch, usLiquidGallonsPerCubicMeter, usDryGallonsPerCubicMeter)

{-| `ConversionFactors` contains constants that are used in converting
from one standard unit of measurement to another.
Unless otherwise stated, the given values are sourced from
(Frink language units)[https://frinklang.org/frinkdata/units.txt]
-}

---------- SOURCE CONSTANTS ----------
---------- LENGTHS ----------


{-| The number of centimeters in an inch.
-}
centimetersPerInch : Float
centimetersPerInch =
    2.54


{-| The number of centimeters in a meter.
-}
centimetersPerMeter : Float
centimetersPerMeter =
    100



----------VOLUMES ----------


{-| The number cubic inches in a US liquid gallon.
-}
cubicInchesPerUsLiquidGallon : Float
cubicInchesPerUsLiquidGallon =
    231


{-| The number cubic inches in a bushel.
(Rounded from 8 inch high cylinder with 18.5 inch diameter)
-}
cubicInchesPerBushel : Float
cubicInchesPerBushel =
    2150.42


{-| The number of bushels in a peck.
0.25
-}
pecksPerBushel : Float
pecksPerBushel =
    1 / 4


{-| The number of US dry gallons in a peck.
0.5
-}
usDryGallonsPerPeck : Float
usDryGallonsPerPeck =
    1 / 2



---------- DERIVED CONSTANTS ----------


{-| The number of meters per inch.
0.0254
-}
metersPerInch : Float
metersPerInch =
    centimetersPerInch / centimetersPerMeter


{-| The number of US liquid gallons in a cubic meter.
264.17205235814845
-}
usLiquidGallonsPerCubicMeter : Float
usLiquidGallonsPerCubicMeter =
    1 / (cubicInchesPerUsLiquidGallon * metersPerInch * metersPerInch * metersPerInch)


{-| The number of US dry gallons in a cubic meter.
227.02074606721402
-}
usDryGallonsPerCubicMeter : Float
usDryGallonsPerCubicMeter =
    (1 / (cubicInchesPerBushel * metersPerInch * metersPerInch * metersPerInch)) / pecksPerBushel / usDryGallonsPerPeck


{-| The number of imperial gallons in a cubic meter.
-}
imperialGallonsPerCubicMeter : Float
imperialGallonsPerCubicMeter =
    219.969157
