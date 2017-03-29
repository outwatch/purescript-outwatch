module OutWatch.Dom.Builder where

import Data.Functor (map)
import Data.List (fromFoldable)
import Data.Show (show)
import Data.Traversable (class Traversable)
import OutWatch.Dom.DomUtils (modifierToVNode)
import Prelude (class Show, Unit)
import RxJS.Observable (Observable)
import OutWatch.Dom.Types (Property(..), Receiver(..), VDom(..), VNode(..))


class AttributeBuilder builder value | builder -> value where
  setTo :: forall e. builder -> value -> VDom (|e)


class ReceiverBuilder builder stream eff | stream -> eff, builder -> stream where
  bindFrom :: builder -> stream -> VDom eff


-- Bool
newtype BoolAttributeBuilder = BoolAttributeBuilder String

toEmptyIfFalse :: Boolean -> String
toEmptyIfFalse b = if (b) then "true" else ""

instance boolAttributeBuilder :: AttributeBuilder BoolAttributeBuilder Boolean where
  setTo (BoolAttributeBuilder name) b =
    Property (Attribute { name : name , value : toEmptyIfFalse b })

instance boolReceiverBuilder :: ReceiverBuilder BoolAttributeBuilder (Observable Boolean) e where
  bindFrom (BoolAttributeBuilder name) obs =
    let attributeStream = map (\b -> { name : name , value : toEmptyIfFalse b }) obs
    in Receiver (AttributeStreamReceiver { attr : name, stream : attributeStream })


-- String
newtype StringAttributeBuilder = StringAttributeBuilder String

instance stringAttributeBuilder :: AttributeBuilder StringAttributeBuilder String where
  setTo (StringAttributeBuilder name) s =
    Property (Attribute { name : name , value : s })

instance stringAttributeReceiverBuilder :: ReceiverBuilder StringAttributeBuilder (Observable String) e where
  bindFrom (StringAttributeBuilder name) obs =
    let attributeStream = map (\s -> { name : name , value : s }) obs
    in Receiver (AttributeStreamReceiver { attr : name, stream : attributeStream })


-- Show 
newtype ShowAttributeBuilder a = ShowAttributeBuilder String
type NumberAttributeBuilder = ShowAttributeBuilder Number
type IntAttributeBuilder = ShowAttributeBuilder Int

instance showAttributeBuilder :: (Show a) => AttributeBuilder (ShowAttributeBuilder a) a where
  setTo (ShowAttributeBuilder name) a = Property (Attribute { name : name , value : show a })

instance attributeReceiverBuilder :: (Show a) => ReceiverBuilder (ShowAttributeBuilder a) (Observable a) e where
  bindFrom (ShowAttributeBuilder name) obs =
    let attributeStream = map (\a -> { name : name , value : show a }) obs
    in Receiver (AttributeStreamReceiver { attr : name, stream : attributeStream })


-- Child Stream
newtype ChildStreamReceiverBuilder = ChildStreamReceiverBuilder Unit

instance childReceiverBuilder :: ReceiverBuilder ChildStreamReceiverBuilder (Observable (VDom e)) e  where
  bindFrom builder obs =
    let valueStream = map modifierToVNode obs
    in Receiver (ChildStreamReceiver valueStream)


-- Child String
newtype ChildStringReceiverBuilder = ChildStringReceiverBuilder Unit

instance childShowReceiverBuilder :: (Show a) => ReceiverBuilder ChildStringReceiverBuilder (Observable a) e where
  bindFrom builder obs =
    let valueStream = map (\a -> StringNode (show a)) obs
    in Receiver (ChildStreamReceiver valueStream)


-- CHildren Stream
newtype ChildrenStreamReceiverBuilder = ChildrenStreamReceiverBuilder Unit

instance childrenStreamReceiverBuilder :: (Traversable t) => ReceiverBuilder ChildrenStreamReceiverBuilder (Observable (t (VDom e))) e where
  bindFrom builder obs =
    let valueStream = map (\t -> fromFoldable (map modifierToVNode t)) obs
    in Receiver (ChildrenStreamReceiver valueStream)


