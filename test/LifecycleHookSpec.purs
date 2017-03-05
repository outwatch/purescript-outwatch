module Test.LifecycleHookSpec where

import OutWatch
import OutWatch.Attributes
import Control.Applicative (pure)
import Control.Monad.Aff.AVar (AVAR)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Random (RANDOM)
import Control.Monad.Eff.Ref (REF, modifyRef, newRef, readRef)
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Document (body)
import DOM.HTML.Types (htmlDocumentToDocument, htmlElementToNode)
import DOM.HTML.Window (document)
import DOM.Node.Document (createElement)
import DOM.Node.Element (setAttribute)
import DOM.Node.Node (appendChild, setTextContent)
import DOM.Node.Types (Node, elementToNode)
import Data.Unit (Unit)
import OutWatch.Sink (createSink)
import Prelude (bind, not)
import RxJS.Observable (fromArray)
import Test.Unit (TestSuite, suite, test)
import Test.Unit.Assert (assert)
import Test.Unit.Console (TESTOUTPUT)
import Unsafe.Coerce (unsafeCoerce)



lifecycleHookSuite :: forall e. TestSuite (console :: CONSOLE, testOutput :: TESTOUTPUT, avar :: AVAR, dom :: DOM, vdom :: VDOM, random :: RANDOM, ref :: REF | e)
lifecycleHookSuite =
  suite "lifecycle hook suite" do
    test "insertion hooks should be called when a VNode is inserted" do
      refFlag <- liftEff (newRef false)
      liftEff createDomRoot
      let sink = createSink (\_ -> modifyRef refFlag (\_ -> true))
          root = div [ insert ==> sink ]
      flagBeforeRendering <- liftEff (readRef refFlag)
      assert "Insert hook shouldn't be called before rendering" (not flagBeforeRendering)
      liftEff (render "#app" root)
      flagAfterRendering <- liftEff (readRef refFlag)
      assert "Insert hook should have been called after rendering" (flagAfterRendering)
      liftEff (afterAll)
    test "destruction hooks should be called when a VNode is destroyed" do
      refFlag <- liftEff (newRef false)
      liftEff createDomRoot
      let sink = createSink (\_ -> modifyRef refFlag (\_ -> true))
          innerChild = fromArray [ span [ destroy ==> sink ], h3 [] ]
          root = div [ child <== innerChild ]
      flagBeforeRendering <- liftEff (readRef refFlag)
      assert "Destroy hook shouldn't be called before rendering" (not flagBeforeRendering)
      liftEff (render "#app" root)
      flagAfterRendering <- liftEff (readRef refFlag)
      assert "Destroy hook should have been called after rendering" (flagAfterRendering)
      liftEff (afterAll)
    test "update hooks should be called when a VNode is updated" do
      refFlag <- liftEff (newRef false)
      liftEff createDomRoot
      let sink = createSink (\_ -> modifyRef refFlag (\_ -> true))
          innerChild = fromArray [ span [ update ==> sink, text "First" ], span [ update ==> sink , text "second" ] ]
          root = div [ child <== innerChild ]
      flagBeforeRendering <- liftEff (readRef refFlag)
      assert "Update hook shouldn't be called before rendering" (not flagBeforeRendering)
      liftEff (render "#app" root)
      flagAfterRendering <- liftEff (readRef refFlag)
      assert "Update hook should have been called after rendering" (flagAfterRendering)
      liftEff (afterAll)

createDomRoot :: forall e. Eff (dom :: DOM | e) Node
createDomRoot = do
  wndow <- window
  doc <- document wndow
  node <- createElement "div" (htmlDocumentToDocument doc)
  bdy <- body doc
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
