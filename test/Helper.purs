module Test.Helper (
    unsafeFindElement
  , createDomRoot
  , afterAll
  ) where

import Control.Monad.Eff.Class (class MonadEff, liftEff)
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Types (htmlDocumentToDocument)
import DOM.HTML.Window (document)
import DOM.Node.Document (createElement)
import DOM.Node.Element (setAttribute)
import DOM.Node.Node (appendChild, setTextContent)
import DOM.Node.ParentNode (QuerySelector(QuerySelector), querySelector)
import DOM.Node.Types (Document, Element, documentToParentNode, elementToNode)
import Data.Maybe (Maybe(Just, Nothing))
import Partial.Unsafe (unsafeCrashWith)
import Prelude (Unit, bind, pure, ($), (<#>), (<>), (>>=))
import Unsafe.Coerce (unsafeCoerce)


unsafeFindElement :: forall e m. (MonadEff (dom :: DOM | e) m) => String -> m Element
unsafeFindElement queryStr = liftEff do
  doc <- getDocument
  maybeElem <- querySelector (QuerySelector queryStr) (documentToParentNode doc)
  case maybeElem of
    Nothing -> unsafeCrashWith $ "Element for query '" <> queryStr <> "' was not found."
    Just elem -> pure elem

getDocument :: forall e m. (MonadEff (dom :: DOM | e) m) => m Document
getDocument = liftEff $ window >>= document <#> htmlDocumentToDocument

createDomRoot :: forall e m. (MonadEff (dom :: DOM | e) m) => m Unit
createDomRoot = liftEff do
  bdy <- unsafeFindElement "body"
  node <- getDocument >>= createElement "div"
  child <- appendChild (elementToNode node) (elementToNode bdy)
  setAttribute "id" "app" (unsafeCoerce child)

afterAll :: forall e m. (MonadEff (dom :: DOM | e) m) => m Unit
afterAll = liftEff do
  node <- getDocument >>= createElement "div"
  bdy <- unsafeFindElement "body"
  setTextContent "" (unsafeCoerce bdy)
