module Test.OutWatchDomSpec where

import Control.Monad.Aff.AVar (AVAR)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Random (RANDOM)
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Document (body)
import DOM.HTML.HTMLInputElement (value) as HTML
import DOM.HTML.Types (htmlDocumentToDocument, htmlElementToNode)
import DOM.HTML.Window (document)
import DOM.Node.Document (createElement)
import DOM.Node.Element (setAttribute)
import DOM.Node.Node (appendChild, setTextContent, textContent)
import DOM.Node.ParentNode (querySelector)
import DOM.Node.Types (Document, Node, documentToParentNode, elementToNode)
import Data.String (length)
import OutWatch.Attributes (className, id, text, value, (:=), (<==))
import OutWatch.Core (render)
import OutWatch.Dom.Builder (toEmptyIfFalse)
import OutWatch.Dom.DomUtils (hyperscriptHelper, modifierToVNode)
import OutWatch.Dom.Types (toProxy)
import OutWatch.Tags (div, input, strong)
import Prelude (Unit, bind, pure, (#), ($), (==), (>))
import RxJS.Observable (fromArray)
import Snabbdom (VDOM)
import Test.JsHelpers (stringify)
import Test.Unit (TestSuite, suite, test)
import Test.Unit.Assert (assert, equal)
import Test.Unit.Console (TESTOUTPUT)
import Unsafe.Coerce (unsafeCoerce)


outWatchDomSuite :: forall e. TestSuite (console :: CONSOLE, testOutput :: TESTOUTPUT
  , avar :: AVAR, dom :: DOM, vdom :: VDOM, random :: RANDOM | e)
outWatchDomSuite =
  suite "OutWatch Dom Suite" do
    test "Nested VTrees should be constructed correctly" do
      let json = {"sel":"div","data":{"attrs":{"class":"red","id":"msg"},"on":{},"hook":{}},"children":[{"sel":"div","data":{"attrs":{},"on":{},"hook":{}},"children":[{"text":"ABC"}]}]}
          vtree = div [className := "red", id := "msg", div [text "ABC"]] # modifierToVNode # toProxy
      equal (stringify json) (stringify vtree)
    test "Builders should map falsy booleans to empty strings" do
      assert "falsy booleans should be empty strings" $ (false # toEmptyIfFalse # length) == 0
    test "Builders should map truthy booleans to non-empty strings" do
      assert "falsy booleans should be non-empty strings" $ (true # toEmptyIfFalse # length) > 0
    test "The hyperscriptHelper should construct correct Vtrees" do
      let vtree = hyperscriptHelper "div" [className := "red", id := "msg", text "Hello World!"] # modifierToVNode # toProxy
          json = {"sel":"div","data":{"attrs":{"class":"red","id":"msg"},"on":{},"hook":{}},"children":[{"text":"Hello World!"}]}
      assert "should be equal when encoded to json" ((vtree # stringify) == (stringify json))
    test "The hyperscriptHelper should be able to patch into DOM correctly" do
      liftEff createDomRoot
      let msg = "HelloWorld!"
          root = hyperscriptHelper "strong" [ text msg ]
      liftEff (render "#app" root)
      doc <- liftEff getDocument
      elem <- liftEff (querySelector "strong" (documentToParentNode doc))
      val <- liftEff (textContent (unsafeCoerce elem))
      assert "Should be equal" $ val == msg
      liftEff (afterAll)
    test "The DOM Api should construct correct Vtrees" do
      let vtree = div [className := "red", id := "msg", text "Hello World!"] # modifierToVNode # toProxy
          json = {"sel":"div","data":{"attrs":{"class":"red","id":"msg"},"on":{},"hook":{}},"children":[{"text":"Hello World!"}]}
      assert "should be equal when encoded to json" ((vtree # stringify) == (stringify json))
    test "The DOM Api should be able to patch into DOM correctly" do
      liftEff createDomRoot
      let msg = "HelloWorld!"
          root = strong [ text msg ]
      liftEff (render "#app" root)
      doc <- liftEff getDocument
      elem <- liftEff (querySelector "strong" (documentToParentNode doc))
      val <- liftEff (textContent (unsafeCoerce elem))
      assert "Should be equal" $ val == msg
      liftEff (afterAll)
    test "The DOM Api should be able to set the value of a text field" do
      liftEff createDomRoot
      let msg = "HelloWorld!"
          root = input [ value := msg ]
      liftEff (render "#app" root)
      doc <- liftEff getDocument
      elem <- liftEff (querySelector "input" (documentToParentNode doc))
      val <- liftEff (HTML.value (unsafeCoerce elem))
      assert "Should be equal" $ val == msg
      liftEff (afterAll)
    test "The DOM Api should be able to change the value of a text field" do
      liftEff createDomRoot
      let msg1 = "HelloWorld!"
          msg2 = "Another Message!"
          values = fromArray [ msg1, msg2 ]
          root = input [ value <== values ]
      liftEff (render "#app" root)
      doc <- liftEff getDocument
      elem <- liftEff (querySelector "input" (documentToParentNode doc))
      val <- liftEff (HTML.value (unsafeCoerce elem))
      assert "Should be equal" $ val == msg2
      liftEff (afterAll)


getDocument :: forall e. Eff (dom :: DOM | e) Document
getDocument = do
  wndow <- window
  doc <- document wndow
  pure $ htmlDocumentToDocument doc

createDomRoot :: forall e. Eff (dom :: DOM | e) Node
createDomRoot = do
  doc <- getDocument
  node <- createElement "div" doc
  bdy <- body $ unsafeCoerce doc
  child <- appendChild (elementToNode node) (htmlElementToNode (unsafeCoerce bdy))
  setAttribute "id" "app" (unsafeCoerce child)
  pure child

afterAll :: forall e. Eff (dom :: DOM | e) Unit
afterAll = do
  wndow <- window
  doc <- document wndow
  node <- createElement "div" (htmlDocumentToDocument doc)
  bdy <- body doc
  setTextContent "" (unsafeCoerce bdy)
