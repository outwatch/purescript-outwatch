module OutWatch.Core (VDOM, render) where

import Prelude
import Control.Monad.Eff (Eff)
import OutWatch.Dom.VDomModifier (VDom, VDomRepresentation(..), VNode(..), toProxy)
import OutWatch.Sink (toEff)
import Snabbdom (patchInitialSelector)
import Snabbdom (VDOM) as Snabbdom

type VDOM = Snabbdom.VDOM


renderRepresentation :: forall e. String -> VDomRepresentation e -> Eff (vdom :: VDOM | e) Unit
renderRepresentation sel mod = case mod of
  (VNode vnode) -> patchInitialSelector sel (toProxy vnode)
  (Emitter _) -> patchInitialSelector "" (toProxy (StringNode ""))
  (Receiver _) -> patchInitialSelector "" (toProxy (StringNode ""))
  (Property _) -> patchInitialSelector "" (toProxy (StringNode ""))

render :: forall e. String -> VDom e -> Eff (vdom :: VDOM | e) Unit
render sel builder = do
  mod <- toEff builder
  renderRepresentation sel mod
