module Test.DomEventSpec where

import Control.Monad.Aff.AVar (AVAR)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Eff.Random (RANDOM)
import Control.Monad.Eff.Ref (REF, modifyRef, newRef, readRef)
import DOM (DOM)
import DOM.Event.EventTarget (dispatchEvent)
import DOM.HTML (window)
import DOM.HTML.Document (body)
import DOM.HTML.Types (htmlDocumentToDocument, htmlElementToNode)
import DOM.HTML.Window (document)
import DOM.Node.Document (createElement)
import DOM.Node.Element (setAttribute)
import DOM.Node.Node (appendChild, setTextContent, textContent)
import DOM.Node.ParentNode (childElementCount, querySelector)
import DOM.Node.Types (Document, Node, documentToParentNode, elementToEventTarget, elementToNode)
import Data.Array (length) as Array
import OutWatch.Pure.Attributes (childShow, children, click, text, (<==), (==>))
import OutWatch.Pure.Render (render)
import OutWatch.Core.Emitters (mapE, override)
import OutWatch.Pure.Sink (create)
import OutWatch.Pure.Tags (div, span)
import Prelude (Unit, bind, const, map, not, pure, show, (#), ($), (==))
import RxJS.Observable (fromArray, just)
import Snabbdom (VDOM)
import Test.JsHelpers (newEvent)
import Test.Unit (TestSuite, suite, test)
import Test.Unit.Assert (assert)
import Test.Unit.Console (TESTOUTPUT)
import Unsafe.Coerce (unsafeCoerce)


domEventSuite :: forall e. TestSuite (console :: CONSOLE, testOutput :: TESTOUTPUT
  , avar :: AVAR, dom :: DOM, vdom :: VDOM, random :: RANDOM, ref :: REF,
   err :: EXCEPTION | e)
domEventSuite =
  suite "Dom Event Suite" do
    test "The DOM Events Api should be able to update the DOM correctly" do
      liftEff createDomRoot
      let msg1 = "HelloWorld!"
          msg2 = "Another Message!"
          childNodes = fromArray [ msg1, msg2 ]
          root = span [ childShow <== childNodes ]
      liftEff (render "#app" root)
      doc <- liftEff getDocument
      elem <- liftEff (querySelector "span" (documentToParentNode doc))
      val <- liftEff (textContent (unsafeCoerce elem))
      assert "Should be equal" $ val == show msg2
      liftEff (afterAll)
    test "The DOM Events Api should be able to set the children of a DOM element" do
      liftEff createDomRoot
      let arr = [1,2,3,4,5,6,7,8,5,4] # map (\n -> div [text $ show n])
          childValues = just arr
          root = span [ children <== childValues ]
      liftEff (render "#app" root)
      doc <- liftEff getDocument
      elem <- liftEff (querySelector "span" (documentToParentNode doc))
      numberOfChildren <- liftEff (childElementCount (unsafeCoerce elem))
      assert "Should be equal" $ numberOfChildren == (Array.length arr)
      liftEff (afterAll)
    test "The DOM Events Api should be able to emit events to a Sink" do
      refFlag <- liftEff (newRef false)
      liftEff createDomRoot
      let sink = create (\_ -> modifyRef refFlag (\_ -> true))
          root = div [ click ==> sink ]
      flagBeforeAll <- liftEff (readRef refFlag)
      assert "Emitter shouldn't emit before rendering" (not flagBeforeAll)
      liftEff (render "#app" root)
      flagAfterRendering <- liftEff (readRef refFlag)
      assert "Emitter shouldn't emit after initial render" (not flagAfterRendering)
      doc <- liftEff getDocument
      elem <- liftEff (querySelector "div" (documentToParentNode doc))
      let ev = newEvent "click"
          evTarget = elementToEventTarget $ unsafeCoerce elem
      liftEff (dispatchEvent ev evTarget)
      flagAfterClick <- liftEff (readRef refFlag)
      assert "Sink should've been called after click" (flagAfterClick)
      liftEff (afterAll)
    test "The DOM Events Api should be able to handle two events of the same type" do
      refFlag <- liftEff (newRef false)
      refFlag2 <- liftEff (newRef false)
      liftEff createDomRoot
      let sink = create (\_ -> modifyRef refFlag (\_ -> true))
          sink2 = create (\_ -> modifyRef refFlag2 (\_ -> true))
          root = div [ click ==> sink , click ==> sink2 ]
      liftEff (render "#app" root)
      doc <- liftEff getDocument
      elem <- liftEff (querySelector "div" (documentToParentNode doc))
      let ev = newEvent "click"
          evTarget = elementToEventTarget $ unsafeCoerce elem
      liftEff (dispatchEvent ev evTarget)
      flagAfterClick <- liftEff (readRef refFlag)
      flagAfterClick2 <- liftEff (readRef refFlag2)
      assert "Sink should've been called after click" (flagAfterClick)
      assert "Second Sink should've been called after click" (flagAfterClick2)
      liftEff (afterAll)
    test "Event emitters should be able to have their values mapped" do
      refFlag <- liftEff (newRef false)
      liftEff createDomRoot
      let sink = create (\b -> modifyRef refFlag (\_ -> b))
          root = div [ mapE click (const true) ==> sink ]
      liftEff (render "#app" root)
      doc <- liftEff getDocument
      elem <- liftEff (querySelector "div" (documentToParentNode doc))
      let ev = newEvent "click"
          evTarget = elementToEventTarget $ unsafeCoerce elem
      liftEff (dispatchEvent ev evTarget)
      flagAfterClick <- liftEff (readRef refFlag)
      assert "Sink should be called on click" (flagAfterClick)
      liftEff (afterAll)
    test "Event emitters should be able to have their values overriden by another Observable" do
      refFlag <- liftEff (newRef false)
      liftEff createDomRoot
      let sink = create (\b -> modifyRef refFlag (\_ -> b))
          stream = just true
          root = div [ override click stream ==> sink ]
      liftEff (render "#app" root)
      doc <- liftEff getDocument
      elem <- liftEff (querySelector "div" (documentToParentNode doc))
      let ev = newEvent "click"
          evTarget = elementToEventTarget $ unsafeCoerce elem
      liftEff (dispatchEvent ev evTarget)
      flagAfterClick <- liftEff (readRef refFlag)
      assert "Sink should be called on click" (flagAfterClick)
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
