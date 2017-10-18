module OutWatch.Util.Store ( Store
  , getStore
  ) where
import Prelude
import Control.Monad.Aff (Aff, runAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Unsafe (unsafeCoerceEff)
import Data.Foldable (traverse_)
import Data.Identity (Identity(..))
import Data.Maybe (Maybe)
import Data.Tuple (Tuple(..))
import OutWatch.Dom (render, VDOM)
import OutWatch.Dom.VDomModifier (VDom)
import OutWatch.Helpers.Promise (SingleRef, newSingle, put, get)
import OutWatch.Sink (Handler, Observer(..), VDomEff(..), createHandler, toEff)
import RxJS.Observable (Observable, ObservableT(..), runObservableT, scanM, share, startWith, unwrapEff)

type Store eff state action  =
  { src :: Observable state
  , sink :: Observer eff action
  }

type Reducer e a s = (a -> s -> Tuple s (Maybe (Aff e a)))

storeRef :: forall e state action. SingleRef (Store e state action)
storeRef = newSingle

getStore :: forall e state action. VDomEff (Store e state action)
getStore = VDomEff $ get storeRef


foldInner :: forall e s a. Observer e a -> Reducer e a s -> a -> s -> Eff e s
foldInner (Observer sink) reducer action state =
  let (Tuple newState next) = reducer action state
      nextAction = next # traverse_ (runAff (const $ pure unit) sink)
  in nextAction *> (pure newState)


newStore :: forall e state action. state -> Reducer e action state -> Handler e action -> Eff e (Store e state action)
newStore initial reducer handler =
  let sink = handler.sink
      source = handler.src
        # scanM (foldInner sink reducer) initial
        # startWith (pure initial)
        # unwrapEff >>> runObservableT
        # map (Identity >>> ObservableT >>> share)
  in source # map (\src -> { src, sink })



renderWithStore :: forall e state action.
                   state ->
                   Reducer e action state ->
                   String ->
                   VDom e ->
                   Eff (vdom :: VDOM | e) Unit
renderWithStore initialState reducer selector root = unsafeCoerceEff do
  handler <- toEff $ createHandler []
  store <- newStore initialState reducer handler
  put store storeRef
  unsafeCoerceEff $ render selector root
