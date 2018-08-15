# Custom Spaces

`elm-units` defines a couple of standard spaces (`RealWorld` and `OnScreen`),
but you can easily define your own! For example, if you were working on a 2D
tile-based game, you might define a new space type, a corresponding units type
and a matching pair of constructor/extractor functions:

```elm
module Game

import Quantity exposing (Quantity(..))
import Length exposing (Length, LengthUnits)

{-| Game world space
-}
type InGameWorld
    = InGameWorld Never

{-| Units in the game world
-}
type alias Tiles =
    LengthUnits InGameWorld

{-| Construct a `Length InGameWorld` from a given number of tiles
-}
tiles : Float -> Length InGameWorld
tiles numTiles =
    Quantity numTiles

{-| Extract number of tiles from a `Length InGameWorld`
-}
inTiles : Length InGameWorld -> Float
inTiles (Quantity numTiles) =
    numTiles
```

Then you can immediately start doing math with game-space quantities, converting
safely back and forth between tiles and pixels, etc.:

```elm
import Game exposing (tiles, inTiles)
import Quantity
import Length exposing (pixels, inPixels)
import Duration exposing (seconds)

Quantity.sum [ tiles 5, tiles 2.3, tiles 0.6 ]
--> tiles 7.9

tilesToPixels =
    pixels 24 |> Quantity.per (tiles 1)

Length.convert tilesToPixels (tiles 3)
--> pixels 72

speed =
    tiles 12 |> Quantity.per (seconds 1)

milliseconds 30 |> Quantity.at speed
--> tiles 0.36
```

If you wanted to restrict some functions/variables to use whole (integral)
numbers of tiles, you could make the constructor/extractor functions more
generic and add a function to round a fractional number of tiles to a whole
number of tiles:

```elm
tiles : number -> Quantity number Tiles
tiles numTiles =
    Quantity numTiles

inTiles : Quantity number Tiles -> number
inTiles (Quantity numTiles) =
    numTiles

roundToNearestTile : Fractional Tiles -> Whole Tiles
roundToNearestTile (Quantity numTiles) =
    Quantity (round numTiles)
```

Then `tiles 3.5` would be accepted by a function with argument type `Length
InGameWorld` (or its equivalent, `Fractional Tiles`), but not one with argument
type `Whole Tiles`. In contrast, `tiles 3` would be accepted by either.
