module Operations exposing (..)

import Length exposing (..)
import Pixels exposing (..)
import Point2d
import Point3d
import Screen
import Sketch
import World


worldDistance : World.Point -> World.Point -> Length
worldDistance p1 p2 =
    Point3d.distanceFrom p1 p2


sketchDistance : Sketch.Point -> Sketch.Point -> Length
sketchDistance p1 p2 =
    Point2d.distanceFrom p1 p2


screenDistance : Screen.Point -> Screen.Point -> Pixels Float
screenDistance p1 p2 =
    Point2d.distanceFrom p1 p2
