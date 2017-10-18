module OutWatch.Helpers.Promise where

import Prelude
import Control.Monad.Eff (Eff, kind Effect)



foreign import data Promise :: # Effect -> Type -> Type


foreign import success :: forall e a. Promise e a -> a -> Eff e Unit

foreign import foreach :: forall e a. Promise e a -> (a -> Eff e Unit) -> Eff e Unit

foreign import empty :: forall e a. Promise e a


foreign import data SingleRef :: Type -> Type

foreign import put :: forall a e. a -> SingleRef a -> Eff e Unit

foreign import get :: forall a e. SingleRef a -> Eff e a

foreign import update :: forall a e. (a -> a) -> SingleRef a -> Eff e a

foreign import newSingle :: forall a. SingleRef a