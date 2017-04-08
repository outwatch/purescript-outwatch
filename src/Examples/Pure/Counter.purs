module Example.Pure.Counter where

import Prelude (bind)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import OutWatch.Core.Emitters (mapE)
import OutWatch.Core.Types (VDom)
import OutWatch.Pure.Attributes (childShow, click, (<==), (==>))
import OutWatch.Pure.Render (render)
import OutWatch.Pure.Sink (createHandler)
import OutWatch.Pure.Tags (button, div, h1, h3, text)
import Prelude (Unit, (+), (#), const, negate)
import RxJS.Observable (merge, scan, startWith)
import Snabbdom (VDOM)

main :: forall e. Eff ( vdom :: VDOM, console :: CONSOLE | e ) Unit
main = do
    log "example"    
    render "#app" app
 
app :: forall e. VDom e
app =
    let incrementHandlder = createHandler [0]
        decrementHandlder = createHandler [0]
        count = merge incrementHandlder.src decrementHandlder.src
          # scan (+) 0
          # startWith 0

        root = div
          [ button
              [ text "Decrement"
              , mapE click (const (-1)) ==> decrementHandlder
              ]
          , button
              [ text "Increment"
              , mapE click (const 1) ==> incrementHandlder
              ]
          , h3
              [ text "Pure Counter: "
              , childShow <== count
              ]
          ]

    in root
