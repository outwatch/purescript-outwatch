module OutWatch.Sink where

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Unsafe (unsafePerformEff)
import DOM.Event.Types (InputEvent, KeyboardEvent, MouseEvent)
import Data.Functor.Contravariant (class Contravariant, cmap)
import Data.Tuple (Tuple(..))
import Data.Tuple.Nested (Tuple3, tuple3)
import Prelude (Unit)
import RxJS.Observable (Observable, RX)

newtype Observer e a = Observer (a -> Eff e Unit)

type SinkLike e a r = { sink :: Observer e a | r }

type Handler eff a =
  { src :: Observable a
  , sink :: Observer eff a
  }

type Sink e a = { sink :: Observer e a }

instance sinkContravariant :: Contravariant (Observer e) where
  cmap project (Observer observer) = Observer (\b -> observer (project b))


foreign import createHandlerImpl :: forall a e. Array a -> Eff (rx ::RX | e) (Handler e a)

createHandler :: forall a e. Array a -> Handler e a
createHandler arr = unsafePerformEff (createHandlerImpl arr)

createInputHandler :: forall e. Array InputEvent -> Handler e InputEvent
createInputHandler arr = unsafePerformEff (createHandlerImpl arr)

createMouseHandler :: forall e. Array MouseEvent -> Handler e MouseEvent
createMouseHandler arr = unsafePerformEff (createHandlerImpl arr)

createKeyboardHandler :: forall e. Array KeyboardEvent -> Handler e KeyboardEvent
createKeyboardHandler arr = unsafePerformEff (createHandlerImpl arr)

createStringHandler :: forall e. Array String -> Handler e String
createStringHandler arr = unsafePerformEff (createHandlerImpl arr)

createBoolHandler :: forall e. Array Boolean -> Handler e Boolean
createBoolHandler arr = unsafePerformEff (createHandlerImpl arr)

createNumberHandler :: forall e. Array Number -> Handler e Number
createNumberHandler arr = unsafePerformEff (createHandlerImpl arr)

create :: forall a e. (a -> Eff e Unit) -> Sink e a
create fn = { sink : Observer fn }


foreign import redirect :: forall a b e r. SinkLike e a r -> (Observable b -> Observable a) -> Sink e b

foreign import redirect2Impl :: forall a b c e r. SinkLike e a r -> (Observable b -> Observable c -> Observable a)
 -> (b -> c -> Tuple b c) -> Tuple (Sink e b) (Sink e c)

foreign import redirect3Impl :: forall a b c d e r. SinkLike e a r -> (Observable b -> Observable c -> Observable d -> Observable a)
 -> (a -> a -> a -> Tuple3 a a a) -> Tuple3 (Sink e b) (Sink e c) (Sink e d)

redirect2 :: forall a b c e r. SinkLike e a r -> (Observable b -> Observable c -> Observable a) -> Tuple (Sink e b) (Sink e c)
redirect2 observerLike project = redirect2Impl observerLike project Tuple

redirect3 :: forall a b c d e r. SinkLike e a r -> (Observable b -> Observable c -> Observable d -> Observable a) -> Tuple3 (Sink e b) (Sink e c) (Sink e d)
redirect3 observerLike project = redirect3Impl observerLike project tuple3

redirectMap :: forall a b e r. SinkLike e a r -> (b -> a) -> Sink e b
redirectMap observer project = { sink : (cmap project observer.sink) }
