module OutWatch.Util.Store where

import OutWatch.Sink (Observer, createHandler, toEff)
import Prelude ((#), ($))
import Control.Monad.Eff.Unsafe (unsafePerformEff)
import RxJS.Observable (Observable, scan, startWith)


type Store eff state action  =
  { src :: Observable state
  , sink :: Observer eff action
  }


createStore :: forall eff state action. state -> (action -> state -> state) -> Store eff state action
createStore initialState reducer =
  let handler = unsafePerformEff $ toEff $ createHandler[]
      src = handler.src
        # scan reducer initialState
        # startWith initialState
      sink = handler.sink
  in { src, sink }
