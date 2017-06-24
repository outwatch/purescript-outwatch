module Test.OutWatchDomSpec where

import Control.Monad.Aff.AVar (AVAR)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Random (RANDOM)
import Control.Monad.Eff.Unsafe (unsafePerformEff)
import DOM (DOM)
import DOM.HTML.HTMLInputElement (value) as HTML
import DOM.Node.Node (textContent)
import Data.String (length)
import OutWatch.Attributes (className, id, value, (:=), (<==))
import OutWatch.Core (render)
import OutWatch.Dom.Builder (toEmptyIfFalse)
import OutWatch.Dom.DomUtils (hyperscriptHelper)
import OutWatch.Dom.VDomModifier (modifierToVNode, runVDomB, toProxy)
import OutWatch.Tags (div, input, strong, text)
import Prelude (bind, discard, (#), ($), (==), (>))
import RxJS.Observable (fromArray)
import Snabbdom (VDOM)
import Test.Helper (afterAll, createDomRoot, unsafeFindElement)
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
          vtree = div [className := "red", id := "msg", div [text "ABC"]]
            # runVDomB
            # unsafePerformEff
            # modifierToVNode
            # toProxy
      equal (stringify json) (stringify vtree)
    test "Builders should map falsy booleans to empty strings" do
      assert "falsy booleans should be empty strings" $ (false # toEmptyIfFalse # length) == 0
    test "Builders should map truthy booleans to non-empty strings" do
      assert "falsy booleans should be non-empty strings" $ (true # toEmptyIfFalse # length) > 0
    test "The hyperscriptHelper should construct correct Vtrees" do
      let vtree = hyperscriptHelper "div" [className := "red", id := "msg", text "Hello World!"]
            # runVDomB
            # unsafePerformEff
            # modifierToVNode
            # toProxy
          json = {"sel":"div","data":{"attrs":{"class":"red","id":"msg"},"on":{},"hook":{}},"children":[{"text":"Hello World!"}]}
      assert "should be equal when encoded to json" ((vtree # stringify) == (stringify json))
    test "The hyperscriptHelper should be able to patch into DOM correctly" do
      createDomRoot
      let msg = "HelloWorld!"
          root = hyperscriptHelper "strong" [ text msg ]
      liftEff (render "#app" root)
      elem <- unsafeFindElement "strong"
      val <- liftEff (textContent (unsafeCoerce elem))
      assert "Should be equal" $ val == msg
      afterAll
    test "The DOM Api should construct correct Vtrees" do
      let vtree = div [className := "red", id := "msg", text "Hello World!"]
            # runVDomB
            # unsafePerformEff
            # modifierToVNode
            # toProxy
          json = {"sel":"div","data":{"attrs":{"class":"red","id":"msg"},"on":{},"hook":{}},"children":[{"text":"Hello World!"}]}
      assert "should be equal when encoded to json" ((vtree # stringify) == (stringify json))
    test "The DOM Api should be able to patch into DOM correctly" do
      createDomRoot
      let msg = "HelloWorld!"
          root = strong [ text msg ]
      liftEff (render "#app" root)
      elem <- unsafeFindElement "strong"
      val <- liftEff (textContent (unsafeCoerce elem))
      assert "Should be equal" $ val == msg
      afterAll
    test "The DOM Api should be able to set the value of a text field" do
      createDomRoot
      let msg = "HelloWorld!"
          root = input [ value := msg ]
      liftEff (render "#app" root)
      elem <- unsafeFindElement "input"
      val <- liftEff (HTML.value (unsafeCoerce elem))
      assert "Should be equal" $ val == msg
      afterAll
    test "The DOM Api should be able to change the value of a text field" do
      createDomRoot
      let msg1 = "HelloWorld!"
          msg2 = "Another Message!"
          values = fromArray [ msg1, msg2 ]
          root = input [ value <== values ]
      liftEff (render "#app" root)
      elem <- unsafeFindElement "input"
      val <- liftEff (HTML.value (unsafeCoerce elem))
      assert "Should be equal" $ val == msg2
      afterAll
