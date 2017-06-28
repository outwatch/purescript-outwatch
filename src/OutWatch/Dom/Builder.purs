module OutWatch.Dom.Builder where

import Prelude
import Data.Identity (Identity)
import Data.List (fromFoldable)
import Data.Traversable (class Traversable)
import OutWatch.Sink (VDomEff)
import OutWatch.Dom.VDomModifier (Property(Attribute), Receiver(ChildrenStreamReceiver, ChildStreamReceiver, AttributeStreamReceiver), VDom, VDomRepresentation(Receiver, VNode, Property), VNode(StringNode))
import RxJS.Observable (ObservableT)

newtype ShowAttributeBuilder a = ShowAttributeBuilder String
newtype BoolAttributeBuilder = BoolAttributeBuilder String
newtype StringAttributeBuilder = StringAttributeBuilder String
type NumberAttributeBuilder = ShowAttributeBuilder Number
type IntAttributeBuilder = ShowAttributeBuilder Int

class AttributeBuilder builder value | builder -> value where
  setTo :: forall e. builder -> value -> VDom e

instance showAttributeBuilder :: (Show a) => AttributeBuilder (ShowAttributeBuilder a) a where
  setTo (ShowAttributeBuilder name) a =
    pure $ Property (Attribute { name : name , value : show a })

instance stringAttributeBuilder :: AttributeBuilder StringAttributeBuilder String where
  setTo (StringAttributeBuilder name) s =
    pure $ Property (Attribute { name : name , value : s })

instance boolAttributeBuilder :: AttributeBuilder BoolAttributeBuilder Boolean where
  setTo (BoolAttributeBuilder name) b =
    pure $ Property (Attribute { name : name , value : toEmptyIfFalse b })

toEmptyIfFalse :: Boolean -> String
toEmptyIfFalse b = if (b) then "true" else ""

newtype ChildStreamReceiverBuilder = ChildStreamReceiverBuilder Unit
newtype ChildStringReceiverBuilder = ChildStringReceiverBuilder Unit
newtype ChildrenStreamReceiverBuilder = ChildrenStreamReceiverBuilder Unit

class ReceiverBuilder builder stream eff | stream -> eff, builder -> stream where
  bindFrom :: builder -> stream -> VDom eff

instance stringAttributeReceiverBuilder :: ReceiverBuilder StringAttributeBuilder (ObservableT Identity String) e where
  bindFrom (StringAttributeBuilder name) obs =
    let attributeStream = map (\s -> { name : name , value : s }) obs
    in pure $ Receiver
         (AttributeStreamReceiver { attr : name, stream : attributeStream })

instance attributeReceiverBuilder :: (Show a) => ReceiverBuilder (ShowAttributeBuilder a) (ObservableT Identity a) e where
  bindFrom (ShowAttributeBuilder name) obs =
    let attributeStream = map (\a -> { name : name , value : show a }) obs
    in pure $ Receiver
         (AttributeStreamReceiver { attr : name, stream : attributeStream })

instance boolReceiverBuilder :: ReceiverBuilder BoolAttributeBuilder (ObservableT Identity Boolean) e where
  bindFrom (BoolAttributeBuilder name) obs =
    let attributeStream = map (\b -> { name : name , value : toEmptyIfFalse b }) obs
    in pure $ Receiver
         (AttributeStreamReceiver { attr : name, stream : attributeStream })

instance childReceiverBuilder :: ReceiverBuilder ChildStreamReceiverBuilder (ObservableT Identity (VDomEff (VDomRepresentation e))) e  where
  bindFrom builder obs =
    pure $ Receiver (ChildStreamReceiver obs)

instance childShowReceiverBuilder :: (Show a) => ReceiverBuilder ChildStringReceiverBuilder (ObservableT Identity a) e where
  bindFrom builder obs =
    let valueStream = map (show >>> StringNode >>> VNode >>> pure) obs
    in pure $ Receiver (ChildStreamReceiver valueStream)

instance childrenStreamReceiverBuilder :: (Traversable t) => ReceiverBuilder ChildrenStreamReceiverBuilder (ObservableT Identity (t (VDomEff (VDomRepresentation e)))) e where
  bindFrom builder obs =
    let valueStream = map (\t -> fromFoldable t) obs
    in pure $ Receiver (ChildrenStreamReceiver valueStream)
