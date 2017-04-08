module OutWatch.Dom.Types where

import DOM.Event.Event (Event)
import DOM.Event.Types (InputEvent, KeyboardEvent, MouseEvent)
import DOM.HTML.Event.Types (DragEvent)
import DOM.Node.Types (Element)
import Data.List (List)
import Data.Tuple (Tuple)
import Prelude (map)
import RxJS.Observable (Observable)
import OutWatch.Pure.Sink (Observer)
import Snabbdom (VNodeProxy, VNodeData, h, text)


type VTree e = {
  nodeType :: String,
  children :: Array (VNode e),
  attributes :: VNodeData e,
  changables :: Observable (Tuple (List Attribute) (List (VNode e)))
}

data VNode e 
  = VTree (VTree e)
  | StringNode String

type Attribute = { name :: String, value :: String }
type InsertHook e = Observer e Element
type DestroyHook e = Observer e Element
type UpdateHook e = Observer e (Tuple Element Element)

data Property e 
  = Attribute Attribute
  | InsertHook (InsertHook e)
  | DestroyHook (DestroyHook e)
  | UpdateHook (UpdateHook e)


type ChildStreamReceiver e = Observable (VNode e)
type ChildrenStreamReceiver e = Observable (List (VNode e))
type AttributeStreamReceiver = { attr :: String, stream :: Observable Attribute }

data Receiver e 
  = AttributeStreamReceiver AttributeStreamReceiver
  | ChildStreamReceiver (ChildStreamReceiver e)
  | ChildrenStreamReceiver (ChildrenStreamReceiver e)


type EmitterRepr e a = { event :: String, sink :: Observer e a}

type ConstantEmitterRepr a e = { constant :: a, emitter :: EmitterRepr e a}

data Emitter e 
  = EventEmitter (EmitterRepr e Event)
  | InputEventEmitter (EmitterRepr e InputEvent)
  | MouseEventEmitter (EmitterRepr e MouseEvent)
  | KeyboardEventEmitter (EmitterRepr e KeyboardEvent)
  | DragEventEmitter (EmitterRepr e DragEvent)
  | StringEventEmitter (EmitterRepr e String)
  | BoolEventEmitter (EmitterRepr e Boolean)
  | NumberEventEmitter (EmitterRepr e Number)

data VDom e 
  = Emitter (Emitter e)
  | Property (Property e)
  | Receiver (Receiver e)
  | VNode (VNode e)

toProxy :: forall e. VNode e -> VNodeProxy e
toProxy node = case node of
  (VTree tree) -> h tree.nodeType tree.attributes (map toProxy tree.children)
  (StringNode s) -> text s
