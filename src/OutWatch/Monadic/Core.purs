module OutWatch.Monadic.Core where

import Prelude
import OutWatch.Attributes as Attr

import Control.Monad.Eff (Eff)
import Control.Monad.RWS.Trans (lift)
import Control.Monad.State (class MonadState, StateT, execStateT, modify)
import Data.Array (snoc)
import Data.Array.Partial (head)
import OutWatch.Attributes (children)
import OutWatch.Dom.Builder (class AttributeBuilder, class ReceiverBuilder, bindFrom, setTo)
import OutWatch.Dom.EmitterBuilder (class EmitterBuilder, emitFrom)
import OutWatch.Dom.VDomModifier (VDom)
import OutWatch.Sink (Handler, SinkLike, createHandler)
import Partial.Unsafe (unsafePartial)
import RxJS.Observable (Observable)

---- types -----------------------------------------------------------------

foreign import data H :: !
type HTML e a = StateT (Array (VDom e)) (Eff (h::H|e)) a

push :: forall vdom m. (MonadState (Array vdom) m) => vdom -> m Unit
push = (\e l -> snoc l e) >>> modify

unsafeFirst :: forall a. Array a -> a 
unsafeFirst a = unsafePartial (head a)

build :: forall e a. HTML e a -> Eff (h::H|e) (Array (VDom e))
build b = execStateT b []

-- Handlers, Observables, Sinks --------------------------------------------

createHandlerE :: forall a e. Array a -> HTML e (Handler e a)
createHandlerE a = lift $ pure (createHandler a)

-- Elements ----------------------------------------------------------------

wrapTag :: forall e. (Array (VDom e) -> (VDom e)) -> HTML e Unit -> HTML e Unit
wrapTag e b = lift (e <$> execStateT b []) >>= push 

wrapTag_ :: forall attributes m e. (MonadState (Array (VDom e)) m) =>
   attributes -> (attributes -> VDom e) -> m Unit
wrapTag_ val tag =  push (tag val)

-- ul_ :: forall e. HTML e Unit -> HTML e Unit
-- ul_ = wrapTag Tags.ul

-- li_ :: forall e. HTML e Unit -> HTML e Unit
-- li_ = wrapTag Tags.li

-- div_ :: forall e. HTML e Unit -> HTML e Unit
-- div_ = wrapTag Tags.div

-- input_ :: forall e. HTML e Unit -> HTML e Unit
-- input_ = wrapTag Tags.input

-- tags not taking attributes
-- br_ :: forall m e. (MonadState (Array (VDom e)) m) => m Unit
-- br_ = push (Tags.br [])

-- hr_ :: forall m e. (MonadState (Array (VDom e)) m) => m Unit
-- hr_ = push (Tags.hr [])

-- text_ :: forall e. String -> HTML e Unit
-- text_ t =  push (Attr.text t)

-- Attributes --------------------------------------------------------------

wrapAttribyte :: forall builder value e. AttributeBuilder builder value =>  
    builder -> value -> HTML e Unit
wrapAttribyte b v = push (setTo b v)
-- infix 5 setTo as :=

type_ :: forall e. String -> HTML e Unit
type_ = wrapAttribyte Attr.tpe

valueShow_ :: forall s e. Show s => s -> HTML e Unit
valueShow_ = wrapAttribyte Attr.valueShow

max_ :: forall e. Number -> HTML e Unit
max_ = wrapAttribyte Attr.max

-- Emitter -----------------------------------------------------------------

wrapEmitter :: forall builder a e r. EmitterBuilder builder a e => 
  builder -> SinkLike e a r -> HTML e Unit
wrapEmitter b s = push (emitFrom b s)
-- infix 5 emitFrom as ==>

inputNumber_ :: forall e r. SinkLike e Number r -> HTML e Unit
inputNumber_ = wrapEmitter Attr.inputNumber

-- Receiver ----------------------------------------------------------------

wrapReceiver :: forall builder stream e. ReceiverBuilder builder stream e => 
  builder -> stream -> HTML e Unit
wrapReceiver b s = push (bindFrom b s)
-- infix 5 bindFrom as <==

children_ :: forall e. Observable (Array (VDom e)) -> HTML e Unit
children_ s = push (bindFrom children s)

-- -- instance childReceiverBuilder :: ReceiverBuilder ChildStreamReceiverBuilder (Observable (VDom e)) e  where
-- --   bindFrom builder obs =
-- --     let valueStream = map modifierToVNode obs
-- --     in Receiver (ChildStreamReceiver valueStream)

-- -- children_2 :: forall e. Observable (HTML e Unit) -> HTML e Unit
-- -- children_2 = do 
-- --     children

-- childShow_ :: forall a e. Show a => Observable a -> HTML e Unit
-- childShow_ = wrapReceiver childShow
-- -- ReceiverBuilder builder stream eff | stream -> eff, builder -> stream where
-- --   bindFrom :: builder -> stream -> VDom eff

