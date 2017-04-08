module Ok where


import Control.Alt (map)
import Control.Alternative (pure)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Except.Trans (lift)
import Data.Function (const, ($))
import Data.Int (round)
import Data.List.Lazy (replicateM)
import Data.Show (show)
import OutWatch (build, button_, childShow_, click_, createHandler_, div_, h1_, h3_, img_, inputNumber_, input_, max_, src_, text_, type_, ul_, valueShow_)
import OutWatch.Pure.Render (render)
import OutWatch.Dom.Types (VDom)
import OutWatch.Monadic.Attributes (children_, style_)
import OutWatch.Monadic.Core (mapSink, unsafeFirst)
import OutWatch.Monadic.Store (createStore, Store)
import OutWatch.Monadic.Types (HTML)
import Prelude (Unit, bind, (#), (*), (+), (-))
import RxJS.Observable (interval, startWith, timer, unwrap)
import Snabbdom (VDOM)

data Action
  = Increment
  | Decrement

type State = Int

initialState :: State
initialState = 0

update :: Action -> State -> State
update action state =
  case action of
    Increment -> state + 1
    Decrement -> state - 1

type AppStore eff = Store eff State Action

view :: forall eff. Boolean -> HTML eff Unit
view b = do
  store <- lift (createStore initialState update)
  div_ do
    h1_ (text_ "counters store example")
    button_ do
        text_ "Decrement"
        click_ (store # mapSink (const Decrement))
    button_ do
        text_ "Incremsssent"
        click_ (store # mapSink (const Increment))
    h3_ do
        text_ "Counter: "
        childShow_ store.src
    

    let initialSliderVal = 5.0

    sliderEvents <- createHandler_ [initialSliderVal]
    let imageLists = sliderEvents.src
          # map \n -> replicateM (round n) do
              t <- pure ((interval 1000
                  # map (_ * 10)
                  # startWith 0))
              div_ do
                style_ "display:inline-block;"
                childShow_ t
                img_ do 
                  src_ "img.png"
                  style_ "width:32px;heught:32px"

    ul_ do
      input_ do
        type_ "range"
        inputNumber_ sliderEvents
        valueShow_ initialSliderVal
        max_ 10.0

      childShow_ sliderEvents.src
      test <- lift (unwrap (map build imageLists))
      div_ (children_ test)
      

main :: forall eff. Eff ( vdom :: VDOM, console:: CONSOLE | eff ) Unit
main = do 
  log "ok"
  vdom <- build (view true)
  render "#app" (unsafeFirst vdom)

