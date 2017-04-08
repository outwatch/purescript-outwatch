module OutWatch.Monadic.Store where

import Control.Alternative (pure)
import Control.Monad.Eff (Eff)
import Control.Monad.Except.Trans (lift)
import OutWatch.Helpers.Helpers (debug)
import OutWatch.Monadic.Types (HTML)
import OutWatch.Pure.Sink (Observer, createHandlerEff)
import Prelude ((#), bind)
import RxJS.Observable (Observable, scan, startWith)
import Snabbdom (VDOM)

type Store eff state action  =
  { src :: Observable state
  , sink :: Observer eff action
  }

createStore :: forall eff state action. 
  state ->
  (action -> state -> state) ->  -- reducer
  Eff (vdom :: VDOM | eff) (Store eff state action)
createStore initialState reducer = do
  handler <- createHandlerEff []
  debug "creating a store"
  let src = handler.src
        # scan reducer initialState
        # startWith initialState
      sink = handler.sink
  pure { src, sink }

-- lifted version
createStore_ :: forall eff state action. 
  state ->
  (action -> state -> state) -> 
  HTML eff (Store eff state action)
createStore_ initialState reducer = lift (createStore initialState reducer)
