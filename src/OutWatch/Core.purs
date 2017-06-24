module OutWatch.Core (VDOM, render) where

import Control.Monad.Eff (Eff)
import Prelude
import OutWatch.Dom.VDomModifier (VDom(..), VDomB(..), VNode(..), runVDomB, toProxy)
import Snabbdom (patchInitialSelector)
import Snabbdom (VDOM) as Snabbdom

type VDOM = Snabbdom.VDOM


renderRepresentation :: forall e. String -> VDom e -> Eff (vdom :: VDOM | e) Unit
renderRepresentation sel mod = case mod of
  (VNode vnode) -> patchInitialSelector sel (toProxy vnode)
  (Emitter _) -> patchInitialSelector "" (toProxy (StringNode ""))
  (Receiver _) -> patchInitialSelector "" (toProxy (StringNode ""))
  (Property _) -> patchInitialSelector "" (toProxy (StringNode ""))

render :: forall e. String -> VDomB e -> Eff (vdom :: VDOM | e) Unit
render sel builder = do
  mod <- runVDomB builder
  renderRepresentation sel mod
