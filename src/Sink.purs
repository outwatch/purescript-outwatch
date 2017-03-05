module OutWatch.Sink where

import Control.Monad.Eff (Eff)
import Data.Functor.Contravariant (class Contravariant, cmap)
import Data.Tuple (Tuple(..))
import Data.Tuple.Nested (Tuple3, tuple3)
import Prelude (Unit)
import RxJS.Observable (Observable)

newtype Observer e a = Observer (a -> Eff e Unit)

type ObserverLike e a r = { sink :: Observer e a | r }

type Handler eff a =
  { src :: Observable a
  , sink :: Observer eff a
  }

type Sink e a = { sink :: Observer e a }

instance sinkContravariant :: Contravariant (Observer e) where
  cmap project (Observer observer) = Observer (\b -> observer (project b))

foreign import createHandlerImpl :: forall a e. Array a -> Handler e a

createHandler :: forall a e. Array a -> Handler e a
createHandler = createHandlerImpl

createSink :: forall a e. (a -> Eff e Unit) -> Sink e a
createSink fn = { sink : Observer fn }


foreign import redirect :: forall a b e r. ObserverLike e a r -> (Observable b -> Observable a) -> Sink e b

foreign import redirect2Impl :: forall a b c e r. ObserverLike e a r -> (Observable b -> Observable c -> Observable a)
 -> (b -> c -> Tuple b c) -> Tuple (Sink e b) (Sink e c)

foreign import redirect3Impl :: forall a b c d e r. ObserverLike e a r -> (Observable b -> Observable c -> Observable d -> Observable a)
 -> (a -> a -> a -> Tuple3 a a a) -> Tuple3 (Sink e b) (Sink e c) (Sink e d)

redirect2 :: forall a b c e r. ObserverLike e a r -> (Observable b -> Observable c -> Observable a) -> Tuple (Sink e b) (Sink e c)
redirect2 observerLike project = redirect2Impl observerLike project Tuple

redirect3 :: forall a b c d e r. ObserverLike e a r -> (Observable b -> Observable c -> Observable d -> Observable a) -> Tuple3 (Sink e b) (Sink e c) (Sink e d)
redirect3 observerLike project = redirect3Impl observerLike project tuple3

redirectMap :: forall a b e r. ObserverLike e a r -> (b -> a) -> Sink e b
redirectMap observer project = { sink : (cmap project observer.sink) }
