# Custom Units

`elm-units` defines many standard unit types, but you can easily define your
own! For example, if you were working on a 2D tile-based game, you might define
a new `Tiles` units type:

```elm
module Game

import Quantity exposing (Quantity(..))

{-| Units in the game world
-}
type Tiles =
    Tiles
```

You would then add a matching pair of constructor/extractor functions:

```elm
{-| Construct a quantity representing a given number of tiles
-}
tiles : number -> Quantity number Tiles
tiles numTiles =
    Quantity numTiles

{-| Convert a quantity of tiles back to a plain Float or Int
-}
inTiles : Quantity number Tiles -> number
inTiles (Quantity numTiles) =
    numTiles
```

Note that using the generic `number` type when defining these functions means
that they can be used to define/work with either whole (`Int`) or partial
(`Float`) numbers of tiles.

Then you can start doing math with tiles, converting safely back and forth
between tiles and pixels, etc.:

```elm
import Game exposing (tiles, inTiles)
import Pixels exposing (pixels, inPixels)
import Duration exposing (seconds, milliseconds)
import Quantity

Quantity.sum [ tiles 5, tiles 2.3, tiles 0.6 ]
--> tiles 7.9

pixelsPerTile : Quantity Float (Rate Pixels Tiles)
pixelsPerTile =
    pixels 24 |> Quantity.per (tiles 1)

tiles 3 |> Quantity.at pixelsPerTile
--> pixels 72

speed : Quantity Float (Rate Tiles Seconds)
speed =
    tiles 12 |> Quantity.per (seconds 1)

milliseconds 30 |> Quantity.at speed
--> tiles 0.36
```
