module OutWatch.Helpers.Promise where

import Prelude
import Control.Monad.Eff (Eff)


foreign import data Promise :: # ! -> * -> *


foreign import success :: forall e a. Promise e a -> a -> Eff e Unit

foreign import foreach :: forall e a. Promise e a -> (a -> Eff e Unit) -> Eff e Unit

foreign import empty :: forall e a. Promise e a
