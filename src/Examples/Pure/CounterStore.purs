module Example.Pure.CounterStore where

import Control.Monad.Eff (Eff)
import OutWatch.Pure.Attributes (childShow, click, (<==), (==>))
import OutWatch.Pure.Render (render)
import OutWatch.Core.Emitters (mapE)
import OutWatch.Core.Types (VDom)
import OutWatch.Pure.Tags (button, div, h3, text)
import OutWatch.Pure.Store (Store, createStore)
import Prelude (Unit, const, (+), (-))
import Snabbdom (VDOM)

data Action
  = Increment
  | Decrement

type State = Int

initialState :: State
initialState = 11

update :: Action -> State -> State
update action state =
  case action of
    Increment -> state + 1
    Decrement -> state - 1

app :: forall eff. VDom eff
app =
  div
    [ button
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

type AppStore eff = Store eff State Action

store :: forall eff. AppStore eff
store = createStore initialState update

main :: forall eff. Eff ( vdom :: VDOM | eff ) Unit
main = render "#app" app
