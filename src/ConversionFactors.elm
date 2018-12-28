module ConversionFactors exposing (usLiquidGallonsPerCubicMeter, usDryGallonsPerCubicMeter)

{-| `ConversionFactors` contains constants that are used in converting
from one standard unit of measurement to another. Unless otherwise stated, the given values are sourced from
(Frink language units)[https://frinklang.org/frinkdata/units.txt]


## Imperial

@docs usLiquidGallonsPerCubicMeter, usDryGallonsPerCubicMeter

-}

---------- SOURCE CONSTANTS ----------


{-| The number of centimeters in an inch.
-}
centimetersPerInch : Float
centimetersPerInch =
    2.54


{-| The number cubic inches in a US liquid gallon.
-}
cubicInchesPerUsLiquidGallon : Float
cubicInchesPerUsLiquidGallon =
    231


{-| The number of centimeters in a meter.
-}
centimetersPerMeter : Float
centimetersPerMeter =
    100



---------- DERIVED CONSTANTS ----------


{-| The number of meters per inch.
100
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
-}
usDryGallonsPerCubicMeter : Float
usDryGallonsPerCubicMeter =
    227.0208


{-| The number of imperial gallons in a cubic meter.
-}
imperialGallonsPerCubicMeter : Float
imperialGallonsPerCubicMeter =
    219.969157
