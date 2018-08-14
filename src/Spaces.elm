module Spaces exposing (ScreenSpace, WorldSpace)

{-| Quantity types in `elm-units` are divided into spatial ones (`Length`,
`Area`, `Speed`, and `Acceleration`) and non-spatial ones (`Duration`, `Mass`,
`Temperature`, and `Angle`). All spatial quantities are associated with a
'space' type, which prevents nonsensical operations. For example, it makes sense
to add '2 feet' and '3 meters', but it doesn't make sense to add '3 meters' and
'5 pixels'!

In `elm-units`, both `feet 2` and `meters 3` have type `Length WorldSpace`,
while `pixels 5` has type `Length ScreenSpace`. Since those are different types,
you will get a compile-time error if you try to combine them (add, subtract
etc.) without an explicit conversion.

In contrast, there generally aren't different kinds of time, so there's no need
to distinguish between 'a time in world space' and 'a time in screen space'.
Similarly, although angle might intuitively be considered a spatial type, 45
degrees means the same thing in the real world and on a screen so there's no
real need to distinguish between the two.

Although this module defines `WorldSpace` and `ScreenSpace` as the two most
common spaces you will likely need to use, you can absolutely define your own
space types if you want! See TODO for an example.

-}


{-| World space refers to dimensions in the real, physical world.
-}
type WorldSpace
    = WorldSpace Never


{-| Screen space refers to dimensions on a computer screen.
-}
type ScreenSpace
    = ScreenSpace Never
