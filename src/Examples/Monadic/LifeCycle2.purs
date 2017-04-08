module Example.Monadic.LifeCycle2 where


import Control.Alt (map)
import Control.Alternative (pure)

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Except.Trans (lift)
import Data.Int (round)
import Data.List.Lazy (replicateM)
import OutWatch (build, childShow_, createHandler_, div_, img_, inputNumber_, input_, li_, max_, ol_, src_, type_, valueShow_)
import OutWatch.Monadic.Attributes (children_, style_)
import OutWatch.Monadic.Utils (toVDom)
import OutWatch.Monadic.Types (HTML)
import OutWatch.Pure.Render (render)
import Prelude (Unit, bind, (#))
import RxJS.Observable (interval, startWith, unwrap)
import Snabbdom (VDOM)

initialSliderVal :: Number
initialSliderVal = 2.0

app :: forall eff. HTML eff Unit
app = do
  div_ do
    t <- pure ((interval 200 # startWith 0))
    sliderEvents <- createHandler_ [initialSliderVal]
    let imageLists = sliderEvents.src # map \n -> replicateM (round n) do      
          li_ do
            childShow_ t
            img_ do 
              src_ "img.png"
              style_ "width:32px;heught:32px"

    ol_ do
      input_ do
        type_ "range"
        inputNumber_ sliderEvents
        valueShow_ initialSliderVal
        max_ 5.0

      childShow_ sliderEvents.src
      test <- lift (unwrap (map build imageLists))
      div_ (children_ test)
      

main :: forall eff. Eff ( vdom :: VDOM, console:: CONSOLE | eff ) Unit
main = do 
  log "ok"
  vdom <- toVDom app
  render "#app" vdom
