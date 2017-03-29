module OutWatch.Core where

import Control.Monad.Eff (Eff)
import Data.Unit (Unit)
import OutWatch.Dom.Types (VDom(..), VNode(..), toProxy)
import Snabbdom (patchInitialSelector)
import Snabbdom (VDOM) as Snabbdom

type VDOM = Snabbdom.VDOM

render :: forall e. String -> VDom e -> Eff (vdom :: VDOM | e) Unit
render sel mod = case mod of
  (VNode vnode) -> patchInitialSelector sel (toProxy vnode)
  (Emitter _) -> patchInitialSelector "" (toProxy (StringNode ""))
  (Receiver _) -> patchInitialSelector "" (toProxy (StringNode ""))
  (Property _) -> patchInitialSelector "" (toProxy (StringNode ""))
