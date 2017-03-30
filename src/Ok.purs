module Ok where

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import OutWatch (text_)
import OutWatch.Attributes (childShow, click, (<==), (==>))
import OutWatch.Core (render)
import OutWatch.Dom.Emitters (mapE)
import OutWatch.Dom.Types (VDom)
import OutWatch.Monadic.Core (HTML)
import OutWatch.Tags (button, div, h1, h3, text)
import OutWatch.Util.Store (Store, createStore)
import Prelude (bind)
import Prelude (Unit, (+), (-), ($), const)
import Snabbdom (VDOM)

xx :: forall e. HTML e Unit
xx = text_ "ok"

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

view :: forall eff. AppStore eff -> VDom eff
view store =
  div
    [ h1 [ text "counter-store example" ]
    , button
        [ text "Decrement"
        , mapE click (const Decrement) ==> store
        ]
    , button
        [ text "Increment"
        , mapE click (const Increment) ==> store
        ]
    , h3
        [ text "Counter: "
        , childShow <== store.src
        ]
    ]

main :: forall eff. Eff ( vdom :: VDOM, console:: CONSOLE | eff ) Unit
main = do 
  log "ok"
  render "#app" $ view store

store :: forall eff. AppStore eff
store = createStore initialState update

