module OutWatch.Dom.DomUtils (hyperscriptHelper, separateModifiers, separateReceivers, separateProperties) where

import Prelude
import Data.Array (fromFoldable)
import Data.Foldable (class Foldable, elem, foldr)
import Data.List (List(..), head, null)
import Data.Maybe (maybe)
import Data.Traversable (class Traversable, sequence)
import Data.Tuple (Tuple(..))
import OutWatch.Dom.SnabbdomHelpers (createVNodeData, emittersToEventObject, Properties)
import OutWatch.Dom.VDomModifier (Attribute, AttributeStreamReceiver, ChildStreamReceiver, ChildrenStreamReceiver, Emitter, Property(..), Receiver(..), VDom, VDomRepresentation(..), VNode(..))
import OutWatch.Helpers.Helpers (combineLatestAll)
import RxJS.Observable (Observable, combineLatest)


hyperscriptHelper :: forall e f. (Traversable f) => String -> f (VDom e) -> VDom e
hyperscriptHelper sel ts = do
  args <- sequence ts
  let modifiers = separateModifiers args
      receivers = separateReceivers modifiers.receivers
      changables = toChangables receivers
      recsEmpty = (null receivers.childStreams) &&
        (null receivers.childrenStreams) && (null receivers.attrStreams)
      valueStreamExists = elem "value" (map (\rec -> rec.attr) receivers.attrStreams)
      eventHandlers = emittersToEventObject modifiers.emitters
      props = separateProperties modifiers.props
      children = fromFoldable modifiers.vnodes
      vnodeData = createVNodeData (not recsEmpty) changables props eventHandlers valueStreamExists
  pure $ VNode $ VTree
    { nodeType : sel , children : children , attributes : vnodeData , changables : changables }


-- Private

toChangables :: forall e. Receivers e -> Observable (Tuple (List Attribute) (List (VDom e)))
toChangables { childStreams, childrenStreams, attrStreams } =
  let childReceivers = combineLatestAll childStreams
      attributeReceivers = combineLatestAll (map (\attr -> attr.stream) attrStreams)
      childMaybe = head childrenStreams
      allChildReceivers = maybe childReceivers id childMaybe
  in combineLatest Tuple attributeReceivers allChildReceivers

type Modifiers eff =
  { emitters :: List (Emitter eff)
  , receivers :: List (Receiver eff)
  , props :: List (Property eff)
  , vnodes :: List (VNode eff)
  }

emptyMods :: forall eff . Modifiers eff
emptyMods = { emitters : Nil , receivers : Nil, props : Nil, vnodes : Nil }

separateModifiers :: forall eff f. (Foldable f) => f (VDomRepresentation eff) -> Modifiers eff
separateModifiers modifiers = foldr separateMod emptyMods modifiers

separateMod :: forall eff . VDomRepresentation eff -> Modifiers eff -> Modifiers eff
separateMod (Emitter e) mods = mods { emitters = Cons e mods.emitters }
separateMod (Receiver r) mods = mods { receivers = Cons r  mods.receivers }
separateMod (Property p) mods = mods { props = Cons p  mods.props }
separateMod (VNode v) mods = mods { vnodes = Cons v  mods.vnodes }

type Receivers eff =
  { childStreams :: List (ChildStreamReceiver eff)
  , childrenStreams :: List (ChildrenStreamReceiver eff)
  , attrStreams :: List AttributeStreamReceiver
  }

emptyRecs :: forall eff. Receivers eff
emptyRecs = { childStreams : Nil , childrenStreams : Nil, attrStreams : Nil }

separateReceivers :: forall e. List (Receiver e) -> Receivers e
separateReceivers recs = foldr separateRec emptyRecs recs

separateRec :: forall eff. Receiver eff -> Receivers eff -> Receivers eff
separateRec (ChildStreamReceiver c) recs = recs { childStreams = Cons c recs.childStreams }
separateRec (ChildrenStreamReceiver cs) recs = recs { childrenStreams = Cons cs recs.childrenStreams }
separateRec (AttributeStreamReceiver a) recs = recs { attrStreams = Cons a recs.attrStreams }



emptyProps :: forall e. Properties (|e)
emptyProps = { attrs : Nil, inserts : Nil, destroys : Nil, updates : Nil }

separateProperties :: forall e. List (Property e) -> Properties e
separateProperties props = foldr separateProp emptyProps props

separateProp :: forall e. Property e -> Properties e -> Properties e
separateProp (Attribute a) props = props { attrs = Cons a props.attrs }
separateProp (InsertHook i) props = props { inserts = Cons i props.inserts }
separateProp (DestroyHook d) props = props { destroys = Cons d props.destroys }
separateProp (UpdateHook u) props = props { updates = Cons u props.updates }
