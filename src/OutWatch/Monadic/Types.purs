module OutWatch.Monadic.Types where

-- import Prelude
import Control.Monad.Eff (Eff)
-- import Control.Monad.RWS.Trans (lift)
import Control.Monad.State (StateT)
-- import Data.Array (snoc)
-- import Data.Array.Partial (head)
-- import Data.Functor.Contravariant (cmap)
-- import OutWatch.Dom.Emitters (class EmitterBuilder, emitFrom)
-- import OutWatch.Dom.Receivers (class AttributeBuilder, class ReceiverBuilder, bindFrom, setTo)
import OutWatch.Dom.Types (VDom)
-- import OutWatch.Pure.Sink (Handler, SinkLike, createHandlerEff)
-- import Partial.Unsafe (unsafePartial)
import Snabbdom (VDOM)

type HTML e a = StateT (Array (VDom e)) (Eff (vdom :: VDOM | e)) a
