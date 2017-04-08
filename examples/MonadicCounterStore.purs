module Example.MonadicCounterStore where

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Function (const)
import OutWatch (build, button_, childShow_, click_, div_, h1_, h3_, text_)
import OutWatch.Pure.Render (render)
import OutWatch.Monadic.Core (HTML, mapSink, unsafeFirst)
import OutWatch.Monadic.Store (createStore, Store)
import Prelude (Unit, bind, (#), (+), (-))
import Snabbdom (VDOM)

data Action = Increment | Decrement

type State = Int

initialState :: State
initialState = 0

update :: Action -> State -> State
update action state =
  case action of
    Increment -> state + 1
    Decrement -> state - 1

type AppStore eff = Store eff State Action

view :: forall eff. AppStore eff -> HTML eff Unit
view store = 
  div_ do
    h1_ (text_ "counter-store example")
    button_ do
        text_ "Decrement"
        click_ (store # mapSink (const Decrement))
    button_ do
        text_ "Increment"
        click_ (store # mapSink (const Increment))
    h3_ do
        text_ "Counter: "
        childShow_ store.src

main :: forall eff. Eff ( vdom :: VDOM, console:: CONSOLE | eff ) Unit
main = do 
  log "ok"
  store <- createStore initialState update
  vdom <- build (view store)
  render "#app" (unsafeFirst vdom)
