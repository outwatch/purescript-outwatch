module Test.LifecycleHookSpec where

import Control.Monad.Aff.AVar (AVAR)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Random (RANDOM)
import Control.Monad.Eff.Ref (REF, modifyRef, newRef, readRef)
import DOM (DOM)
import OutWatch.Attributes (child, destroy, insert, update, (<==), (==>))
import OutWatch.Core (VDOM, render)
import OutWatch.Sink (create)
import OutWatch.Tags (div, h3, span, text)
import Prelude (bind, discard, not)
import RxJS.Observable (fromArray)
import Test.Helper (afterAll, createDomRoot)
import Test.Unit (TestSuite, suite, test)
import Test.Unit.Assert (assert)
import Test.Unit.Console (TESTOUTPUT)



lifecycleHookSuite :: forall e. TestSuite (console :: CONSOLE, testOutput :: TESTOUTPUT
  , avar :: AVAR, dom :: DOM, vdom :: VDOM, random :: RANDOM, ref :: REF | e)
lifecycleHookSuite =
  suite "lifecycle hook suite" do
    test "insertion hooks should be called when a VNode is inserted" do
      refFlag <- liftEff (newRef false)
      createDomRoot
      let sink = create (\_ -> modifyRef refFlag (\_ -> true))
          root = div [ insert ==> sink ]
      flagBeforeRendering <- liftEff (readRef refFlag)
      assert "Insert hook shouldn't be called before rendering" (not flagBeforeRendering)
      liftEff (render "#app" root)
      flagAfterRendering <- liftEff (readRef refFlag)
      assert "Insert hook should have been called after rendering" (flagAfterRendering)
      afterAll
    test "destruction hooks should be called when a VNode is destroyed" do
      refFlag <- liftEff (newRef false)
      createDomRoot
      let sink = create (\_ -> modifyRef refFlag (\_ -> true))
          innerChild = fromArray [ span [ destroy ==> sink ], h3 [] ]
          root = div [ child <== innerChild ]
      flagBeforeRendering <- liftEff (readRef refFlag)
      assert "Destroy hook shouldn't be called before rendering" (not flagBeforeRendering)
      liftEff (render "#app" root)
      flagAfterRendering <- liftEff (readRef refFlag)
      assert "Destroy hook should have been called after rendering" (flagAfterRendering)
      afterAll
    test "update hooks should be called when a VNode is updated" do
      refFlag <- liftEff (newRef false)
      createDomRoot
      let sink = create (\_ -> modifyRef refFlag (\_ -> true))
          innerChild = fromArray [ span [ update ==> sink, text "First" ], span [ update ==> sink , text "second" ] ]
          root = div [ child <== innerChild ]
      flagBeforeRendering <- liftEff (readRef refFlag)
      assert "Update hook shouldn't be called before rendering" (not flagBeforeRendering)
      liftEff (render "#app" root)
      flagAfterRendering <- liftEff (readRef refFlag)
      assert "Update hook should have been called after rendering" (flagAfterRendering)
      afterAll
