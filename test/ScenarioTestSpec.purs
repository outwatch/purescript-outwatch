module Test.ScenarioTestSpec where

import Control.Monad.Aff.AVar (AVAR)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Eff.Random (RANDOM)
import DOM (DOM)
import DOM.Event.EventTarget (dispatchEvent)
import DOM.Node.Node (textContent)
import DOM.Node.Types (elementToEventTarget)
import OutWatch.Attributes (childShow, click, id, (:=), (<==), (==>))
import OutWatch.Core (render)
import OutWatch.Dom.EmitterBuilder (mapE)
import OutWatch.Sink (createHandler)
import OutWatch.Tags (button, div, span)
import Prelude (bind, const, discard, negate, (#), ($), (+), (==))
import RxJS.Observable (merge, scan, startWith)
import Snabbdom (VDOM) as Snabbdom
import Test.Helper (afterAll, createDomRoot, unsafeFindElement)
import Test.JsHelpers (newEvent)
import Test.Unit (TestSuite, suite, test)
import Test.Unit.Assert (assert)
import Test.Unit.Console (TESTOUTPUT)
import Unsafe.Coerce (unsafeCoerce)


scenarioSuite :: forall e. TestSuite (console :: CONSOLE, testOutput :: TESTOUTPUT, avar :: AVAR, dom :: DOM, vdom :: Snabbdom.VDOM, random :: RANDOM, err :: EXCEPTION | e)
scenarioSuite =
  suite "Real Scenario Suite" do
    test "A simple counter application should work correctly" do
      createDomRoot
      let root = do
            plusHandler <- createHandler []
            minusHandler <- createHandler []
            let counters = merge plusHandler.src minusHandler.src
                 # scan (+) 0
                 # startWith 0
            div [ button [id := "plus", mapE click (const 1) ==> plusHandler ]
             , button [id := "minus", mapE click (const (-1)) ==> minusHandler ]
             , span [ id := "counter", childShow <== counters ]
            ]
      liftEff (render "#app" root)
      plusElem <-  unsafeFindElement "#plus"
      minusElem <-  unsafeFindElement "#minus"
      counterElem <-  unsafeFindElement "#counter"
      let ev = newEvent "click"
          plusTarget = elementToEventTarget $ unsafeCoerce plusElem
          minusTarget = elementToEventTarget $ unsafeCoerce minusElem
      initialCount <- liftEff (textContent $ unsafeCoerce counterElem)
      assert "Should be 0 at the begining" (initialCount == "0")

      _ <- liftEff (dispatchEvent ev minusTarget)

      afterFirstClick <- liftEff (textContent $ unsafeCoerce counterElem)
      assert "Should be 0 at the begining" (afterFirstClick == "-1")

      _ <- liftEff (dispatchEvent ev plusTarget)

      afterSecondClick <- liftEff (textContent $ unsafeCoerce counterElem)
      assert "Should be 0 at the begining" (afterSecondClick == "0")

      _ <- liftEff (dispatchEvent ev plusTarget)

      afterThirdClick <- liftEff (textContent $ unsafeCoerce counterElem)
      assert "Should be 0 at the begining" (afterThirdClick == "1")

      afterAll
