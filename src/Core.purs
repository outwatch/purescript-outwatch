module OutWatch.Core where

import Control.Monad.Eff (Eff)
import DOM.Event.KeyboardEvent (KeyboardEvent)
import DOM.Event.Types (InputEvent, MouseEvent)
import Data.Unit (Unit)
import OutWatch.Sink (Handler, createHandlerImpl)
import Snabbdom (patchInitialSelector)
import Snabbdom (VDOM) as Snabbdom
import VDomModifier (VDom(..), VNode(..), toProxy)

type VDOM = Snabbdom.VDOM


render :: forall e. String -> VDom e -> Eff (vdom :: VDOM | e) Unit
render sel mod = case mod of
  (VNode vnode) -> patchInitialSelector sel (toProxy vnode)
  (Emitter _) -> patchInitialSelector "" (toProxy (StringNode ""))
  (Receiver _) -> patchInitialSelector "" (toProxy (StringNode ""))
  (Property _) -> patchInitialSelector "" (toProxy (StringNode ""))

createHandler :: forall a e. Array a -> Handler e a
createHandler = createHandlerImpl

createInputHandler :: forall e. Array InputEvent -> Handler e InputEvent
createInputHandler = createHandlerImpl

createMouseHandler :: forall e. Array MouseEvent -> Handler e MouseEvent
createMouseHandler = createHandlerImpl

createKeyboardHandler :: forall e. Array KeyboardEvent -> Handler e KeyboardEvent
createKeyboardHandler = createHandlerImpl

createStringHandler :: forall e. Array String -> Handler e String
createStringHandler = createHandlerImpl

createBoolHandler :: forall e. Array Boolean -> Handler e Boolean
createBoolHandler = createHandlerImpl

createNumberHandler :: forall e. Array Number -> Handler e Number
createNumberHandler = createHandlerImpl
