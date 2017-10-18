module OutWatch.Dom.SnabbdomHelpers (createVNodeData, emittersToEventObject, Properties) where

import Prelude
import Control.Comonad (extract)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Unsafe (unsafeCoerceEff, unsafePerformEff)
import DOM (DOM)
import DOM.Event.Event (Event, target)
import DOM.HTML.HTMLInputElement (checked, value, valueAsNumber)
import DOM.HTML.Types (HTMLInputElement)
import DOM.Node.Types (Element)
import Data.Array (fromFoldable) as Array
import Data.Foldable (traverse_)
import Data.List (List, groupBy)
import Data.List.NonEmpty (NonEmptyList, head)
import Data.Maybe (Maybe(..))
import Data.StrMap (StrMap, fromFoldable, union)
import Data.Traversable (sequence)
import Data.Tuple (Tuple(..))
import OutWatch.Dom.VDomModifier (Attribute, DestroyHook, Emitter(NumberEventEmitter, BoolEventEmitter, StringEventEmitter, KeyboardEventEmitter, DragEventEmitter, MouseEventEmitter, InputEventEmitter, EventEmitter), InsertHook, UpdateHook, VDom, modifierToVNode, toProxy)
import OutWatch.Helpers.Helpers (forEachMaybe, tupleMaybes)
import OutWatch.Helpers.Promise (Promise, foreach, success)
import OutWatch.Helpers.Promise (empty) as Promise
import OutWatch.Sink (Observer(Observer), toEff)
import RxJS.Observable (Observable, pairwise, startWith, subscribeNext)
import RxJS.Subscription (Subscription, unsubscribe)
import Snabbdom (VDOM, VNodeData, VNodeEventObject, VNodeProxy(..), getElement, h, patch, toVNodeEventObject, toVNodeHookObjectProxy, updateValueHook)
import Unsafe.Coerce (unsafeCoerce)


type Properties e =
  { attrs :: List Attribute
  , inserts :: List (InsertHook e)
  , destroys :: List (DestroyHook e)
  , updates :: List (UpdateHook e)
  }

emittersToEventObject :: forall e. List (Emitter e) -> VNodeEventObject e
emittersToEventObject list =
  let grouped = groupBy emittersEqual list
      tupled =  nonEmptyToTuple <$> grouped
      strMap = fromFoldable tupled
  in toVNodeEventObject strMap

createVNodeData :: forall e. Boolean -> Observable (Tuple (List Attribute) (List (VDom e)))
  -> Properties e -> VNodeEventObject e -> Boolean -> VNodeData e
createVNodeData recsNonEmpty changables props handlers valueExists =
  if recsNonEmpty then
    createReceiverVNodeData changables valueExists props handlers
  else
    createSimpleVNodeData props handlers


subscriberToEff :: forall e. Element -> InsertHook e -> Eff e Unit
subscriberToEff elem (Observer sink) =
  sink elem

updateSubscriberToEff :: forall e. Tuple Element Element -> UpdateHook e -> Eff e Unit
updateSubscriberToEff elems (Observer sink) =
  sink elems



mapHookToEff :: forall e. List (Observer e Element) -> Element -> Eff e Unit
mapHookToEff list elem =
  traverse_ (subscriberToEff elem) list


-- | Takes a Hook and returns a function from VNodeProxy to an Effect.
hookToSnabbdom :: forall e. List (Observer e Element) -> VNodeProxy e -> Eff e Unit
hookToSnabbdom list proxy =
  let maybe = map (\elem -> mapHookToEff list elem) (getElement proxy)
  in forEachMaybe maybe




createSimpleVNodeData :: forall e. Properties e -> VNodeEventObject e -> VNodeData e
createSimpleVNodeData { attrs , inserts , destroys , updates } eventObject =
  let attributes = attrsToSnabbdom attrs
      insertHook = Just (hookToSnabbdom inserts)
      deleteHook = Just (hookToSnabbdom destroys)
      updateHook = Just (createUpdateHook updates)

      hookObject = {insert: insertHook, destroy: deleteHook, update: updateHook}
  in {attrs: attributes, on: eventObject, hook: toVNodeHookObjectProxy hookObject}


createDestroyHook :: forall e. Promise e Subscription -> List (DestroyHook e) -> VNodeProxy e -> Eff e Unit
createDestroyHook promise hooks proxy =
  let callbackEff = hooksToEff hooks proxy
      promisedEff = foreach promise unsubscribe
  in callbackEff *> promisedEff



createSubscription :: forall e. Observable (Tuple (List Attribute) (List (VDom e))) -> VNodeProxy e -> Eff e Subscription
createSubscription changables proxy = changables
  # map (changablesToProxy proxy)
  # startWith proxy
  # pairwise
  # subscribeNext (patchPair >>> unsafeCoerceEff)
  # extract

createInsertHook :: forall e. Observable (Tuple (List Attribute) (List (VDom e)))
  -> Promise e Subscription -> List (InsertHook e) -> VNodeProxy e -> Eff e Unit
createInsertHook changables promise hooks proxy =
  let subscriptionEff = unsafeCoerceEff (createSubscription changables proxy)
      callbackEff = hooksToEff hooks proxy
  in do
    sub <- subscriptionEff
    unsafeCoerceEff (success promise sub)
    (unsafeCoerceEff callbackEff)

-- | Takes a list of Update Hooks and returns a function from VNodeProxy to VNodeProxy to an Effect.
createUpdateHook :: forall e. List (UpdateHook e) -> VNodeProxy e -> VNodeProxy e -> Eff e Unit
createUpdateHook hooks old cur =
  let tupled = tupleMaybes (getElement old) (getElement cur)
      maybe = map (updateHooksToEff hooks) tupled
  in forEachMaybe maybe

createUpdateHookWithValue :: forall e. List (UpdateHook e) -> VNodeProxy e -> VNodeProxy e -> Eff e Unit
createUpdateHookWithValue hooks old cur =
  let tupled = tupleMaybes (getElement old) (getElement cur)
      maybe = map (updateHooksToEff hooks) tupled
  in do
    updateValueHook old cur
    forEachMaybe maybe



updateHooksToEff :: forall e. List (UpdateHook e) -> Tuple Element Element -> Eff e Unit
updateHooksToEff hooks tuple =
  traverse_ (callNextUpdate tuple) hooks

callNextUpdate :: forall e. Tuple Element Element -> UpdateHook e -> Eff e Unit
callNextUpdate tuple (Observer sink) = sink tuple


hooksToEff :: forall e. List (Observer e Element) -> VNodeProxy e -> Eff e Unit
hooksToEff hooks proxy =
  let callback = hooksToCallback hooks proxy
      maybe = (map callback (getElement proxy))
  in forEachMaybe maybe

hooksToCallback :: forall e. List (InsertHook e) -> VNodeProxy e -> Element -> Eff e Unit
hooksToCallback hooks (VNodeProxy proxy) element =
  traverse_ (subscriberToEff element) hooks



createReceiverVNodeData :: forall e. Observable (Tuple (List Attribute) (List (VDom e)))
  -> Boolean -> Properties e -> VNodeEventObject e -> VNodeData e
createReceiverVNodeData changables valueExists props handlers =
  let attrs = attrsToSnabbdom props.attrs
      promise = Promise.empty
      insert = Just (createInsertHook changables promise props.inserts)
      destroy = Just (createDestroyHook promise props.destroys)
      update = Just (if (valueExists) then createUpdateHookWithValue props.updates else createUpdateHook props.updates)
      hookObject = toVNodeHookObjectProxy { insert , destroy, update }
   in { attrs : attrs , on : handlers , hook : hookObject}



patchPair :: forall e. Tuple (VNodeProxy e) (VNodeProxy e) -> Eff (vdom :: VDOM | e) Unit
patchPair (Tuple first second) =
  patch first second


changablesToProxy :: forall e. VNodeProxy e -> Tuple (List Attribute) (List (VDom e)) -> VNodeProxy e
changablesToProxy (VNodeProxy proxy)(Tuple attributes builders) =
  let vnodes = builders # sequence # toEff # unsafePerformEff
      updatedData = updateVNodeData attributes proxy.data
      nodeProxies = Array.fromFoldable (vnodes # map (modifierToVNode >>> toProxy))
      updatedChildren = proxy.children <> nodeProxies
  in h proxy.sel updatedData updatedChildren

updateVNodeData :: forall e. List Attribute -> VNodeData e -> VNodeData e
updateVNodeData list vdata =
  let strMap = attrsToSnabbdom list
  in vdata { attrs = (union strMap vdata.attrs) }

emitterToEventFn :: forall e. Emitter e -> (Event -> Eff e Unit)
emitterToEventFn (EventEmitter { sink : (Observer fn)}) = fn
emitterToEventFn (InputEventEmitter { sink : (Observer fn)}) = unsafeCoerce fn
emitterToEventFn (MouseEventEmitter { sink : (Observer fn)}) = unsafeCoerce fn
emitterToEventFn (DragEventEmitter { sink : (Observer fn)}) = unsafeCoerce fn
emitterToEventFn (KeyboardEventEmitter { sink : (Observer fn)}) = unsafeCoerce fn
emitterToEventFn (StringEventEmitter { sink : (Observer fn)}) = callbackToEventFn fn value -- fn :: String -> Eff e Unit
emitterToEventFn (NumberEventEmitter { sink : (Observer fn)}) = callbackToEventFn fn valueAsNumber
emitterToEventFn (BoolEventEmitter { sink : (Observer fn)}) = callbackToEventFn fn checked

eventToInputElement :: Event -> HTMLInputElement
eventToInputElement ev = unsafeCoerce (target ev)

constantEmitterToEventFn :: forall a e. a -> Observer e a -> Event -> Eff e Unit
constantEmitterToEventFn constant (Observer fn) ev =
  fn constant

callbackToEventFn :: forall a e. (a -> Eff e Unit) -> (HTMLInputElement -> Eff (dom :: DOM) a) -> Event -> Eff e Unit
callbackToEventFn callback extractor ev =
  let inputValue = unsafePerformEff (extractor (eventToInputElement ev))
  in callback inputValue

combineEventFns :: forall e. NonEmptyList (Event -> Eff e Unit) -> Event -> Eff e Unit
combineEventFns list ev = traverse_ (\fn -> fn ev) list

emittersToEventFn :: forall e. NonEmptyList (Emitter e) -> Event -> Eff e Unit
emittersToEventFn list ev =
  let mapped = emitterToEventFn <$> list
  in combineEventFns mapped ev

emittersEqual :: forall e1 e2. Emitter e1 -> Emitter e2 -> Boolean
emittersEqual a b = getEventType a == getEventType b


getEventType :: forall e. Emitter e -> String
getEventType emitter = case emitter of
  (EventEmitter e) -> e.event
  (InputEventEmitter e) -> e.event
  (MouseEventEmitter e) -> e.event
  (DragEventEmitter e) -> e.event
  (KeyboardEventEmitter e) -> e.event
  (StringEventEmitter e) -> e.event
  (BoolEventEmitter e) -> e.event
  (NumberEventEmitter e) -> e.event

nonEmptyToTuple :: forall e. NonEmptyList (Emitter e) -> Tuple String (Event -> Eff e Unit)
nonEmptyToTuple list = Tuple (getEventType (head list)) (emittersToEventFn list)



attrsToSnabbdom :: List Attribute -> StrMap String
attrsToSnabbdom list =
  let tupled = map (\a -> Tuple a.name a.value) list
  in fromFoldable tupled
