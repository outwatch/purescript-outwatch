module Builder where

import Data.Functor (map)
import Data.List (fromFoldable)
import Data.Show (show)
import Data.Traversable (class Traversable)
import DomUtils (modifierToVNode)
import Prelude (class Show, Unit)
import RxJS.Observable (Observable)
import VDomModifier (Property(..), Receiver(..), VDom(..), VNode(..))

newtype ShowAttributeBuilder a = ShowAttributeBuilder String
newtype BoolAttributeBuilder = BoolAttributeBuilder String
newtype StringAttributeBuilder = StringAttributeBuilder String
type NumberAttributeBuilder = ShowAttributeBuilder Number
type IntAttributeBuilder = ShowAttributeBuilder Int

class AttributeBuilder builder value | builder -> value where
  setTo :: forall e. builder -> value -> VDom (|e)

instance showAttributeBuilder :: (Show a) => AttributeBuilder (ShowAttributeBuilder a) a where
  setTo (ShowAttributeBuilder name) a = Property (Attribute { name : name , value : show a })

instance stringAttributeBuilder :: AttributeBuilder StringAttributeBuilder String where
  setTo (StringAttributeBuilder name) s =
    Property (Attribute { name : name , value : s })

instance boolAttributeBuilder :: AttributeBuilder BoolAttributeBuilder Boolean where
  setTo (BoolAttributeBuilder name) b =
    Property (Attribute { name : name , value : toEmptyIfFalse b })

toEmptyIfFalse :: Boolean -> String
toEmptyIfFalse b = if (b) then "true" else ""

newtype ChildStreamReceiverBuilder = ChildStreamReceiverBuilder Unit
newtype ChildStringReceiverBuilder = ChildStringReceiverBuilder Unit
newtype ChildrenStreamReceiverBuilder = ChildrenStreamReceiverBuilder Unit

class ReceiverBuilder builder stream eff | stream -> eff, builder -> stream where
  bindFrom :: builder -> stream -> VDom eff

instance stringAttributeReceiverBuilder :: ReceiverBuilder StringAttributeBuilder (Observable String) e where
  bindFrom (StringAttributeBuilder name) obs =
    let attributeStream = map (\s -> { name : name , value : s }) obs
    in Receiver (AttributeStreamReceiver { attr : name, stream : attributeStream })

instance attributeReceiverBuilder :: (Show a) => ReceiverBuilder (ShowAttributeBuilder a) (Observable a) e where
  bindFrom (ShowAttributeBuilder name) obs =
    let attributeStream = map (\a -> { name : name , value : show a }) obs
    in Receiver (AttributeStreamReceiver { attr : name, stream : attributeStream })

instance boolReceiverBuilder :: ReceiverBuilder BoolAttributeBuilder (Observable Boolean) e where
  bindFrom (BoolAttributeBuilder name) obs =
    let attributeStream = map (\b -> { name : name , value : toEmptyIfFalse b }) obs
    in Receiver (AttributeStreamReceiver { attr : name, stream : attributeStream })

instance childReceiverBuilder :: ReceiverBuilder ChildStreamReceiverBuilder (Observable (VDom e)) e  where
  bindFrom builder obs =
    let valueStream = map modifierToVNode obs
    in Receiver (ChildStreamReceiver valueStream)

instance childShowReceiverBuilder :: (Show a) => ReceiverBuilder ChildStringReceiverBuilder (Observable a) e where
  bindFrom builder obs =
    let valueStream = map (\a -> StringNode (show a)) obs
    in Receiver (ChildStreamReceiver valueStream)

instance childrenStreamReceiverBuilder :: (Traversable t) => ReceiverBuilder ChildrenStreamReceiverBuilder (Observable (t (VDom e))) e where
  bindFrom builder obs =
    let valueStream = map (\t -> fromFoldable (map modifierToVNode t)) obs
    in Receiver (ChildrenStreamReceiver valueStream)
