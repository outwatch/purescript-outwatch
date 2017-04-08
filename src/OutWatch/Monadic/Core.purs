module OutWatch.Monadic.Core where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.RWS.Trans (lift)
import Control.Monad.State (class MonadState, execStateT, modify)
import Data.Array (snoc)
import Data.Array.Partial (head)
import Data.Functor.Contravariant (cmap)
import OutWatch.Dom.Emitters (class EmitterBuilder, emitFrom)
import OutWatch.Dom.Receivers (class AttributeBuilder, class ReceiverBuilder, bindFrom, setTo)
import OutWatch.Dom.Types (VDom)
import OutWatch.Monadic.Types (HTML)
import OutWatch.Pure.Sink (Handler, SinkLike, createHandlerEff)
import Partial.Unsafe (unsafePartial)
import Snabbdom (VDOM)

---- Core -----------------------------------------------------------------

push :: forall vdom m. (MonadState (Array vdom) m) => vdom -> m Unit
push = (\e l -> snoc l e) >>> modify

unsafeFirst :: forall a. Array a -> a 
unsafeFirst a = unsafePartial (head a)

build :: forall e a. HTML e a -> Eff (vdom :: VDOM | e) (Array (VDom e))
build b = execStateT b []

toVDom :: forall e. HTML e Unit -> Eff (vdom :: VDOM | e) (VDom e)
toVDom widget = unsafeFirst <$> build widget

-- Handlers, Observables, Sinks --------------------------------------------

createHandler_ :: forall a e. Array a -> HTML e (Handler e a)
createHandler_ a = lift $ (createHandlerEff a)

-- Elements ----------------------------------------------------------------

wrapTag :: forall e. (Array (VDom e) -> (VDom e)) -> HTML e Unit -> HTML e Unit
wrapTag e b = lift (e <$> execStateT b []) >>= push 

-- Emitter -----------------------------------------------------------------

wrapEmitter :: forall builder a e r. EmitterBuilder builder a e => 
  builder -> SinkLike e a r -> HTML e Unit
wrapEmitter b s = push (emitFrom b s)

cmapSink :: forall event action e r. 
  (event -> action) -> SinkLike e action r -> SinkLike e event r
cmapSink fn s = s { sink = cmap fn s.sink }

-- Receiver ----------------------------------------------------------------

-- Stream receiver
wrapStreamReceiver :: forall builder stream e. ReceiverBuilder builder stream e => 
  builder -> stream -> HTML e Unit
wrapStreamReceiver b s = push (bindFrom b s)

-- Static receiver
wrapConstantReceiver :: forall builder value e. AttributeBuilder builder value =>  
    builder -> value -> HTML e Unit
wrapConstantReceiver b v = push (setTo b v)

-- TODO

-- -- instance childReceiverBuilder :: ReceiverBuilder ChildStreamReceiverBuilder (Observable (VDom e)) e  where
-- --   bindFrom builder obs =
-- --     let valueStream = map modifierToVNode obs
-- --     in Receiver (ChildStreamReceiver valueStream)

-- -- children_2 :: forall e. Observable (HTML e Unit) -> HTML e Unit
-- -- children_2 = do 
-- --     children

-- childShow_ :: forall a e. Show a => Observable a -> HTML e Unit
-- childShow_ = wrapStreamReceiver childShow
-- -- ReceiverBuilder builder stream eff | stream -> eff, builder -> stream where
-- --   bindFrom :: builder -> stream -> VDom eff

