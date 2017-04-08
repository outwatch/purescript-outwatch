module Example.Monadic.CounterStore where

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

import Data.Function (const)
import OutWatch (button_, childShow_, click_, div_, h3_, text_)
import OutWatch.Monadic.Utils (cmapSink, toVDom)
import OutWatch.Monadic.Store (Store, createStore_)
import OutWatch.Monadic.Types (HTML)
import OutWatch.Pure.Render (render)
import Prelude (Unit, bind, (#), (+), (-))
import Snabbdom (VDOM)

data Action = Increment | Decrement

type State = Int

initialState :: State
initialState = 0

update :: Action -> State -> State
update action state =
  case action of
    Increment -> state + 10
    Decrement -> state - 5

type AppStore eff = Store eff State Action

app :: forall eff. HTML (console:: CONSOLE|eff) Unit
app =  do
  -- lift $ log "loading Monadic Counter Store..."
  store <- createStore_ initialState update
  div_ do
    button_ do
        text_ "Decrement"
        click_ (store # cmapSink (const Decrement))
    button_ do
        text_ "Increment"
        click_ (store # cmapSink (const Increment))
    h3_ do
        text_ "Counter: "
        childShow_ store.src
  -- lift $ log "loaded!"

main :: forall eff. Eff ( vdom :: VDOM, console:: CONSOLE | eff ) Unit
main = do 
  log "ok"
  vdom <- toVDom app
  render "#app" vdom
