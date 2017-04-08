module OutWatch.Monadic.Types where

import Control.Monad.Eff (Eff)
import Control.Monad.State (StateT)
import OutWatch.Dom.Types (VDom)
import Snabbdom (VDOM)

type HTML e a = StateT (Array (VDom e)) (Eff (vdom :: VDOM | e)) a
