module OutWatch.Dom.EmitterBuilder where

import DOM.Event.Event (Event)
import DOM.Event.KeyboardEvent (KeyboardEvent)
import DOM.Event.Types (InputEvent, MouseEvent)
import DOM.HTML.Event.Types (DragEvent)
import DOM.Node.Types (Element)
import Data.Tuple (Tuple)
import Data.Unit (Unit)
import OutWatch.Sink (Observer, SinkLike, redirect, redirectMap)
import RxJS.Observable (Observable, withLatestFrom)
import OutWatch.Dom.VDomModifier (Emitter(..), Property(..), VDom(..))

newtype EventEmitterBuilder = EventEmitterBuilder String
newtype InputEmitterBuilder = InputEmitterBuilder String
newtype MouseEmitterBuilder = MouseEmitterBuilder String
newtype DragEmitterBuilder = DragEmitterBuilder String
newtype KeyEmitterBuilder = KeyEmitterBuilder String
newtype StringEmitterBuilder = StringEmitterBuilder String
newtype BoolEmitterBuilder = BoolEmitterBuilder String
newtype NumberEmitterBuilder = NumberEmitterBuilder String

newtype GenericMappedEmitterBuilder a b eff = GenericMappedEmitterBuilder
  { constructor :: Observer eff b -> Emitter eff , mapping :: b -> a }
newtype WithLatestFromEmitterBuilder a = WithLatestFromEmitterBuilder
  { event :: String , stream :: Observable a }


class WithLatestFromBuilder builder a | builder -> a where
  override :: builder -> Observable a -> WithLatestFromEmitterBuilder a

instance withLatestFromEventBuilder :: WithLatestFromBuilder EventEmitterBuilder a where
  override (EventEmitterBuilder event) stream = WithLatestFromEmitterBuilder { event , stream }

instance withLatestFromInputBuilder :: WithLatestFromBuilder InputEmitterBuilder a where
  override (InputEmitterBuilder event) stream = WithLatestFromEmitterBuilder { event , stream }

instance withLatestFromStringBuilder :: WithLatestFromBuilder StringEmitterBuilder a where
  override (StringEmitterBuilder event) stream = WithLatestFromEmitterBuilder { event , stream }

instance withLatestFromMouseBuilder :: WithLatestFromBuilder MouseEmitterBuilder a where
  override (MouseEmitterBuilder event) stream = WithLatestFromEmitterBuilder { event , stream }

instance withLatestFromDragBuilder :: WithLatestFromBuilder DragEmitterBuilder a where
  override (DragEmitterBuilder event) stream = WithLatestFromEmitterBuilder { event , stream }

instance withLatestFromKeyBuilder :: WithLatestFromBuilder KeyEmitterBuilder a where
  override (KeyEmitterBuilder event) stream = WithLatestFromEmitterBuilder { event , stream }

instance withLatestFromNumberBuilder :: WithLatestFromBuilder NumberEmitterBuilder a where
  override (NumberEmitterBuilder event) stream = WithLatestFromEmitterBuilder { event , stream }

instance withLatestFromBoolBuilder :: WithLatestFromBuilder BoolEmitterBuilder a where
  override (BoolEmitterBuilder event) stream = WithLatestFromEmitterBuilder { event , stream }

class MappableBuilder builder a b eff | builder -> eff, builder -> b where
  mapE :: builder -> (b -> a) -> GenericMappedEmitterBuilder a b eff

instance mappableEventBuilder :: MappableBuilder EventEmitterBuilder a Event e where
  mapE (EventEmitterBuilder event) mapping =
    let constructor = (\s -> EventEmitter { event , sink : s })
    in GenericMappedEmitterBuilder { constructor , mapping }

instance mappableInputBuilder :: MappableBuilder InputEmitterBuilder a InputEvent e where
  mapE (InputEmitterBuilder event) mapping =
    let constructor = (\s -> InputEventEmitter { event , sink : s })
    in GenericMappedEmitterBuilder { constructor , mapping }

instance mappableStringBuilder :: MappableBuilder StringEmitterBuilder a String e where
  mapE (StringEmitterBuilder event) mapping =
    let constructor = (\s -> StringEventEmitter { event , sink : s })
    in GenericMappedEmitterBuilder { constructor , mapping }

instance mappableMouseBuilder :: MappableBuilder MouseEmitterBuilder a MouseEvent e where
  mapE (MouseEmitterBuilder event) mapping =
    let constructor = (\s -> MouseEventEmitter { event , sink : s })
    in GenericMappedEmitterBuilder { constructor , mapping }

instance mappableDragBuilder :: MappableBuilder DragEmitterBuilder a DragEvent e where
  mapE (DragEmitterBuilder event) mapping =
    let constructor = (\s -> DragEventEmitter { event , sink : s })
    in GenericMappedEmitterBuilder { constructor , mapping }

instance mappableKeyBuilder :: MappableBuilder KeyEmitterBuilder a KeyboardEvent e where
  mapE (KeyEmitterBuilder event) mapping =
    let constructor = (\s -> KeyboardEventEmitter { event , sink : s })
    in GenericMappedEmitterBuilder { constructor , mapping }

instance mappableNumberBuilder :: MappableBuilder NumberEmitterBuilder a Number e where
  mapE (NumberEmitterBuilder event) mapping =
    let constructor = (\s -> NumberEventEmitter { event , sink : s })
    in GenericMappedEmitterBuilder { constructor , mapping }

instance mappableBoolBuilder :: MappableBuilder BoolEmitterBuilder a Boolean e where
  mapE (BoolEmitterBuilder event) mapping =
    let constructor = (\s -> BoolEventEmitter { event , sink : s })
    in GenericMappedEmitterBuilder { constructor , mapping }


class EmitterBuilder builder a eff | builder -> eff, builder -> a where
  emitFrom :: forall r. builder -> SinkLike eff a r  -> VDom eff

instance genericEmitterBuilder :: EmitterBuilder (GenericMappedEmitterBuilder a b e) a e where
  emitFrom (GenericMappedEmitterBuilder { constructor , mapping }) {sink} =
    Emitter (constructor (redirectMap { sink } mapping).sink)

instance latestFromEmitterBuilder :: EmitterBuilder (WithLatestFromEmitterBuilder a) a e where
  emitFrom (WithLatestFromEmitterBuilder { event , stream }) sink =
    let proxy = redirect sink (\obs -> withLatestFrom (\a b -> b) obs stream)
    in  Emitter (EventEmitter { event : event, sink : proxy.sink })

instance eventEmitterBuilder :: EmitterBuilder EventEmitterBuilder Event e where
  emitFrom (EventEmitterBuilder event) {sink} =
    Emitter (EventEmitter { event : event, sink : sink })

instance inputEmitterBuilder :: EmitterBuilder InputEmitterBuilder InputEvent e where
  emitFrom (InputEmitterBuilder event) {sink} =
    Emitter (InputEventEmitter { event : event, sink : sink })

instance mouseEmitterBuilder :: EmitterBuilder MouseEmitterBuilder MouseEvent e where
  emitFrom (MouseEmitterBuilder event) {sink} =
    Emitter (MouseEventEmitter { event : event, sink : sink })

instance dragEmitterBuilder :: EmitterBuilder DragEmitterBuilder DragEvent e where
  emitFrom (DragEmitterBuilder event) {sink} =
    Emitter (DragEventEmitter { event : event, sink : sink })

instance keyEmitterBuilder :: EmitterBuilder KeyEmitterBuilder KeyboardEvent e where
  emitFrom (KeyEmitterBuilder event) {sink} =
    Emitter (KeyboardEventEmitter { event : event, sink : sink })

instance stringEmitterBuilder :: EmitterBuilder StringEmitterBuilder String e where
  emitFrom (StringEmitterBuilder event) {sink} =
    Emitter (StringEventEmitter { event : event, sink : sink })

instance boolEmitterBuilder :: EmitterBuilder BoolEmitterBuilder Boolean e where
  emitFrom (BoolEmitterBuilder event) {sink} =
    Emitter (BoolEventEmitter { event : event, sink : sink })

instance numberEmitterBuilder :: EmitterBuilder NumberEmitterBuilder Number e where
  emitFrom (NumberEmitterBuilder event) {sink} =
    Emitter (NumberEventEmitter { event : event, sink : sink })




newtype InsertHookBuilder = InsertHookBuilder Unit
newtype DestroyHookBuilder = DestroyHookBuilder Unit
newtype UpdateHookBuilder = UpdateHookBuilder Unit

instance insertHookBuilder :: EmitterBuilder InsertHookBuilder Element e where
  emitFrom builder {sink} =
    Property (InsertHook sink)

instance destroyHookBuilder :: EmitterBuilder DestroyHookBuilder Element e where
  emitFrom builder {sink} =
    Property (DestroyHook sink)

instance updateHookBuilder :: EmitterBuilder UpdateHookBuilder (Tuple Element Element) e where
  emitFrom builder {sink} =
    Property (UpdateHook sink)
