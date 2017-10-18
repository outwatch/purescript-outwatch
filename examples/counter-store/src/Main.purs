module Main where

import OutWatch.Util.Store
import Control.Monad.Aff (Aff)
import Control.Monad.Eff (Eff)
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..))
import OutWatch.Attributes (childShow, click, (<==), (==>))
import OutWatch.Core (render)
import OutWatch.Dom.EmitterBuilder (mapE)
import OutWatch.Dom.VDomModifier (VDom)
import OutWatch.Sink (VDomEff(..))
import OutWatch.Tags (button, div, h1, h3, text)
import Prelude (Unit, (+), (-), ($), const, bind)
import Snabbdom (VDOM)

data Action
  = Increment
  | Decrement

type State = Int

initialState :: State
initialState = 0

update :: forall e. Action -> State -> Tuple State (Maybe (Aff e Action))
update action state =
  case action of
    Increment -> Tuple (state + 1) Nothing
    Decrement -> Tuple (state - 1) Nothing

type AppStore eff = Store eff State Action

appStore :: forall e. VDomEff (AppStore e)
appStore = getStore

view :: forall eff. VDom eff
view = do
  store <- appStore
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

main :: forall eff. Eff ( vdom :: VDOM | eff ) Unit
main =
  renderWithStore initialState update "#app" view
