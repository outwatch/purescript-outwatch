module OutWatch.Dom.VDomModifier where

import DOM.Event.Event (Event)
import DOM.Event.Types (InputEvent, KeyboardEvent, MouseEvent)
import DOM.HTML.Event.Types (DragEvent)
import DOM.Node.Types (Element)
import Data.List (List)
import Data.Tuple (Tuple)
import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Unsafe (unsafeCoerceEff)
import RxJS.Observable (Observable, ObservableT(..))
import OutWatch.Sink (Observer, Handler, HandlerImpl, createHandlerImpl)
import Snabbdom (VNodeProxy, VNodeData, h, text)


type VTree e = {
  nodeType :: String,
  children :: Array (VNode e),
  attributes :: VNodeData e,
  changables :: Observable (Tuple (List Attribute) (List (VDomB e)))
}

data VNode e = VTree (VTree e)
  | StringNode String

type Attribute = { name :: String, value :: String }
type InsertHook e = Observer e Element
type DestroyHook e = Observer e Element
type UpdateHook e = Observer e (Tuple Element Element)

data Property e = Attribute Attribute
  | InsertHook (InsertHook e)
  | DestroyHook (DestroyHook e)
  | UpdateHook (UpdateHook e)


type ChildStreamReceiver e = Observable (VDomB e)
type ChildrenStreamReceiver e = Observable (List (VDomB e))
type AttributeStreamReceiver = { attr :: String, stream :: Observable Attribute }

data Receiver e = AttributeStreamReceiver AttributeStreamReceiver
  | ChildStreamReceiver (ChildStreamReceiver e)
  | ChildrenStreamReceiver (ChildrenStreamReceiver e)


type EmitterRepr e a = { event :: String, sink :: Observer e a}

type ConstantEmitterRepr a e = { constant :: a, emitter :: EmitterRepr e a}

data Emitter e = EventEmitter (EmitterRepr e Event)
  | InputEventEmitter (EmitterRepr e InputEvent)
  | MouseEventEmitter (EmitterRepr e MouseEvent)
  | KeyboardEventEmitter (EmitterRepr e KeyboardEvent)
  | DragEventEmitter (EmitterRepr e DragEvent)
  | StringEventEmitter (EmitterRepr e String)
  | BoolEventEmitter (EmitterRepr e Boolean)
  | NumberEventEmitter (EmitterRepr e Number)

data VDom e = Emitter (Emitter e)
  | Property (Property e)
  | Receiver (Receiver e)
  | VNode (VNode e)


newtype VDomEff e a = VDomEff (Eff e a)
derive newtype instance vdomMonad :: Monad (VDomEff e)
derive newtype instance vdomBind :: Bind (VDomEff e)
derive newtype instance vdomApplicative :: Applicative (VDomEff e)
derive newtype instance vdomApply :: Apply (VDomEff e)
derive newtype instance vdomFunctor :: Functor (VDomEff e)

type VDomB e = VDomEff () (VDom e)

runVDomB :: forall e a. VDomEff () a -> Eff e a
runVDomB (VDomEff v) = unsafeCoerceEff v

handlerImplToHandler' :: forall e e2 a. Eff e2 (HandlerImpl e a) -> VDomEff e2 (Handler e a)
handlerImplToHandler' eff = VDomEff do
  handler <- eff
  let sink = handler.sink
  let src = ObservableT (pure handler.src)
  pure {src, sink}

createHandler' :: forall a e e2. Array a -> VDomEff e2 (Handler e a)
createHandler' = createHandlerImpl >>> handlerImplToHandler'

modifierToVNode :: forall e. VDom e -> VNode e
modifierToVNode mod = case mod of
  (VNode vnode) -> vnode
  (Emitter _) -> StringNode ""
  (Receiver _) -> StringNode ""
  (Property _) -> StringNode ""

toProxy :: forall e. VNode e -> VNodeProxy e
toProxy node = case node of
  (VTree tree) -> h tree.nodeType tree.attributes (map toProxy tree.children)
  (StringNode s) -> text s
