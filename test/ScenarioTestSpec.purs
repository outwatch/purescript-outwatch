module Test.ScenarioTestSpec where

import Control.Monad.Aff.AVar (AVAR)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Eff.Random (RANDOM)
import DOM (DOM)
import DOM.Event.EventTarget (dispatchEvent)
import DOM.HTML (window)
import DOM.HTML.Document (body)
import DOM.HTML.Types (htmlDocumentToDocument, htmlElementToNode)
import DOM.HTML.Window (document)
import DOM.Node.Document (createElement)
import DOM.Node.Element (setAttribute)
import DOM.Node.Node (appendChild, setTextContent, textContent)
import DOM.Node.ParentNode (querySelector)
import DOM.Node.Types (Document, Node, documentToParentNode, elementToEventTarget, elementToNode)
import OutWatch.Attributes (childShow, click, id, (:=), (<==), (==>))
import OutWatch.Core (render)
import OutWatch.Dom.EmitterBuilder (mapE)
import OutWatch.Sink (createHandler)
import OutWatch.Tags (button, div, span)
import Prelude (Unit, bind, const, negate, pure, (#), ($), (+), (==))
import RxJS.Observable (merge, scan, startWith)
import Snabbdom (VDOM) as Snabbdom
import Test.JsHelpers (newEvent)
import Test.Unit (TestSuite, suite, test)
import Test.Unit.Assert (assert)
import Test.Unit.Console (TESTOUTPUT)
import Unsafe.Coerce (unsafeCoerce)


scenarioSuite :: forall e. TestSuite (console :: CONSOLE, testOutput :: TESTOUTPUT, avar :: AVAR, dom :: DOM, vdom :: Snabbdom.VDOM, random :: RANDOM, err :: EXCEPTION | e)
scenarioSuite =
  suite "Real Scenario Suite" do
    test "A simple counter application should work correctly" do
      liftEff createDomRoot
      let plusHandler = createHandler []
          minusHandler = createHandler []
          counters = merge plusHandler.src minusHandler.src
            # scan (+) 0
            # startWith 0
          root = div [ button [id := "plus", mapE click (const 1) ==> plusHandler ]
            , button [id := "minus", mapE click (const (-1)) ==> minusHandler ]
            , span [ id := "counter", childShow <== counters ]
          ]
      liftEff (render "#app" root)
      doc <- liftEff getDocument
      plusElem <- liftEff (querySelector "#plus" (documentToParentNode doc))
      minusElem <- liftEff (querySelector "#minus" (documentToParentNode doc))
      counterElem <- liftEff (querySelector "#counter" (documentToParentNode doc))
      let ev = newEvent "click"
          plusTarget = elementToEventTarget $ unsafeCoerce plusElem
          minusTarget = elementToEventTarget $ unsafeCoerce minusElem
      initialCount <- liftEff (textContent $ unsafeCoerce counterElem)
      assert "Should be 0 at the begining" (initialCount == "0")

      liftEff (dispatchEvent ev minusTarget)

      afterFirstClick <- liftEff (textContent $ unsafeCoerce counterElem)
      assert "Should be 0 at the begining" (afterFirstClick == "-1")

      liftEff (dispatchEvent ev plusTarget)

      afterSecondClick <- liftEff (textContent $ unsafeCoerce counterElem)
      assert "Should be 0 at the begining" (afterSecondClick == "0")

      liftEff (dispatchEvent ev plusTarget)

      afterThirdClick <- liftEff (textContent $ unsafeCoerce counterElem)
      assert "Should be 0 at the begining" (afterThirdClick == "1")

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
