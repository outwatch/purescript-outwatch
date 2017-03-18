module Main where

import Control.Monad.Eff (Eff)
import OutWatch.Attributes (childShow, click, (<==), (==>))
import OutWatch.Core (render)
import OutWatch.Dom.EmitterBuilder (mapE)
import OutWatch.Sink (createHandler)
import OutWatch.Tags (button, div, h1, h3, text)
import Prelude (Unit, (+), (#), const, negate)
import RxJS.Observable (merge, scan, startWith)
import Snabbdom (VDOM)

main :: forall e. Eff ( vdom :: VDOM | e ) Unit
main =
    let incrementHandlder = createHandler[]
        decrementHandlder = createHandler[]
        count = merge incrementHandlder.src decrementHandlder.src
          # scan (+) 0
          # startWith 0

        root = div
          [ h1 [ text "counter example" ]
          , button
              [ text "Decrement"
              , mapE click (const (-1)) ==> decrementHandlder
              ]
          , button
              [ text "Increment"
              , mapE click (const 1) ==> incrementHandlder
              ]
          , h3
              [ text "Counter: "
              , childShow <== count
              ]
          ]

    in render "#app" root
