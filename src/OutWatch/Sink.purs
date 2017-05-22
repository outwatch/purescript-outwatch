module OutWatch.Sink
  ( Handler
  , Observer(..)
  , SinkLike
  , Sink
  , createHandler
  , create
  , createStringHandler
  , createMouseHandler
  , createInputHandler
  , createNumberHandler
  , createKeyboardHandler
  , createBoolHandler
  , redirect
  , redirect2
  , redirect3
  , redirectMap
  )
  where

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Unsafe (unsafePerformEff)
import Control.Comonad (extract)
import DOM.Event.Types (InputEvent, KeyboardEvent, MouseEvent)
import Data.Functor.Contravariant (class Contravariant, cmap)
import Data.Profunctor (dimap)
import Data.Tuple (Tuple(..))
import Data.Tuple.Nested (Tuple3, tuple3)
import Prelude (Unit, (#), bind, map, (>>>), pure)
import RxJS.Observable (Observable, ObservableImpl, ObservableT(..), runObservableT)

newtype Observer e a = Observer (a -> Eff e Unit)

type SinkLike e a r = { sink :: Observer e a | r }

type HandlerT eff a =
  { src :: ObservableT (Eff eff) a
  , sink :: Observer eff a
  }

type Handler eff a =
  { src :: Observable a
  , sink :: Observer eff a
  }

type HandlerImpl eff a =
  { src :: ObservableImpl a
  , sink :: Observer eff a
  }


handlerImplToHandlerT :: forall e a. Eff e (HandlerImpl e a) -> HandlerT e a
handlerImplToHandlerT eff =
  let sink = eff # map (_.sink) # removeObserverEff
      src = eff # map (_.src) # ObservableT
  in {src , sink}

handlerImplToHandler :: forall e a. Eff e (HandlerImpl e a) -> Handler e a
handlerImplToHandler eff =
  let handler = unsafePerformEff eff
      sink = handler.sink
      src = ObservableT (pure handler.src)
  in {src, sink}



removeObserverEff :: forall e a. Eff e (Observer e a) -> Observer e a
removeObserverEff eff = Observer (\a -> (bind eff (\(Observer f) -> f a)))

type Sink e a = { sink :: Observer e a }

instance sinkContravariant :: Contravariant (Observer e) where
  cmap project (Observer observer) = Observer (\b -> observer (project b))

foreign import createHandlerImpl :: forall a e. Array a -> Eff e (HandlerImpl e a)

createHandler :: forall a e. Array a -> Handler e a
createHandler = createHandlerImpl >>> handlerImplToHandler

createInputHandler :: forall e. Array InputEvent -> Handler e InputEvent
createInputHandler = createHandler

createMouseHandler :: forall e. Array MouseEvent -> Handler e MouseEvent
createMouseHandler = createHandler

createKeyboardHandler :: forall e. Array KeyboardEvent -> Handler e KeyboardEvent
createKeyboardHandler = createHandler

createStringHandler :: forall e. Array String -> Handler e String
createStringHandler = createHandler

createBoolHandler :: forall e. Array Boolean -> Handler e Boolean
createBoolHandler = createHandler

createNumberHandler :: forall e. Array Number -> Handler e Number
createNumberHandler = createHandler

create :: forall a e. (a -> Eff e Unit) -> Sink e a
create fn = { sink : Observer fn }


foreign import redirectImpl :: forall a b e r. SinkLike e a r -> (ObservableImpl b -> ObservableImpl a) -> Sink e b

foreign import redirect2Impl :: forall a b c e r. SinkLike e a r -> (ObservableImpl b -> ObservableImpl c -> ObservableImpl a)
 -> (b -> c -> Tuple b c) -> Tuple (Sink e b) (Sink e c)

foreign import redirect3Impl :: forall a b c d e r. SinkLike e a r -> (ObservableImpl b -> ObservableImpl c -> ObservableImpl d -> ObservableImpl a)
 -> (a -> a -> a -> Tuple3 a a a) -> Tuple3 (Sink e b) (Sink e c) (Sink e d)

redirect :: forall a b e r. SinkLike e a r -> (Observable b -> Observable a) -> Sink e b
redirect observerLike f = redirectImpl observerLike (dimap (pure >>> ObservableT) (runObservableT >>> extract) f)

redirect2 :: forall a b c e r. SinkLike e a r -> (ObservableImpl b -> ObservableImpl c -> ObservableImpl a) -> Tuple (Sink e b) (Sink e c)
redirect2 observerLike f = redirect2Impl observerLike f Tuple

redirect3 :: forall a b c d e r. SinkLike e a r -> (ObservableImpl b -> ObservableImpl c -> ObservableImpl d -> ObservableImpl a) -> Tuple3 (Sink e b) (Sink e c) (Sink e d)
redirect3 observerLike f = redirect3Impl observerLike f tuple3

redirectMap :: forall a b e r. SinkLike e a r -> (b -> a) -> Sink e b
redirectMap observer f = { sink : (cmap f observer.sink) }
