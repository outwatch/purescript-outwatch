module Ok where


import Data.StrMap as StrMap
import Control.Alt (map)
import Control.Alternative (pure, when)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Eff.Random (RANDOM, randomInt)
import Control.Monad.Except.Trans (lift)
import Data.Array (length, unsafeIndex)
import Data.Eq ((==))
import Data.Foldable (sequence_)
import Data.Function (($))
import Data.Maybe (Maybe(..))
import Data.StrMap (StrMap, fromFoldable, keys)
import Data.Tuple (Tuple(..))
import Example.Monadic.CounterStore (app) as MonadicCounterStore
import Example.Monadic.LifeCycle (app) as MonadicLifeCycle
import Example.Monadic.LifeCycle2 (app) as MonadicLifeCycle2
import Example.Monadic.Counter (app) as MonadicCounter
import Example.Pure.BMICalculator (app) as BMICalculator
import Example.Pure.Counter (app) as Counter
import Example.Pure.CounterStore (app) as CounterStore
import OutWatch (build, child_, createHandler_, div_, h1_, option_, push, select_, selected_, style_, text_, value_)
import OutWatch.Dom.Types (VDom)
import OutWatch.Monadic.Attributes (children_, inputString_)
import OutWatch.Monadic.Core (unsafeFirst)
import OutWatch.Monadic.Types (HTML)
import OutWatch.Pure.Render (render)
import OutWatch.Pure.Tags (text)
import Partial.Unsafe (unsafePartial)
import Prelude (Unit, bind, (#), (-))
import RxJS.Observable (unwrap)
import Snabbdom (VDOM)
import Unsafe.Coerce (unsafeCoerce)

main :: forall eff. Eff ( vdom :: VDOM, console:: CONSOLE, random::RANDOM | eff ) Unit
main = do 
  log "starting examples"
  vdom <- build (view true)
  render "#app" (unsafeFirst vdom)


data Example e 
  = Pure (VDom e)
  | Monadic (HTML e Unit)

examples :: forall e. StrMap (Example e)
examples = fromFoldable 
  [ Tuple "BMICalculator.purs"       (Pure BMICalculator.app)
  , Tuple "Counter.purs"             (Pure Counter.app )
  , Tuple "CounterStore.purs"        (Pure CounterStore.app)
  , Tuple "MonadicCounter.purs"      (Monadic (unsafeCoerce MonadicCounter.app))
  , Tuple "MonadicCounterStore.purs" (Monadic (unsafeCoerce MonadicCounterStore.app))
  , Tuple "MonadicLifeCycle.purs"    (Monadic (unsafeCoerce MonadicLifeCycle.app))
  , Tuple "MonadicLifeCycle2.purs"    (Monadic (unsafeCoerce MonadicLifeCycle2.app))
  ]


view :: forall eff. Boolean -> HTML (random :: RANDOM | eff) Unit
view b = do
  -- initialExample <- lift $ pickOneFrom (keys examples)
  let initialExample = "MonadicCounter.purs"
  exampleH <- createHandler_ [initialExample]
  let eee = exampleH.src
        # map \val -> case StrMap.lookup val examples of 
            Nothing -> text_ "error: no example found"
            Just (Pure e) -> push e
            Just (Monadic e) -> e
  test <- lift (unwrap (map build eee))
  
  div_ do    
    h1_ (text_ "Examples")
    text_ "pickOneFrom one example:"
    select_ do 
        sequence_ (keys examples # map (mkOption initialExample))
        inputString_  exampleH
    h1_ (child_ $ exampleH.src # map \s -> text s)
    div_ do 
      children_ test
      style_ "border:1px solid black;"


mkOption :: forall e. String -> String -> HTML e Unit
mkOption def s = option_ do
  text_ s
  value_ s 
  when (s == def) (selected_ true)

pickOneFrom :: forall a e.Array a -> Eff (random :: RANDOM|e) a
pickOneFrom arr = do 
  ix <- randomInt 0 (length arr - 1)
  pure (unsafePartial $ unsafeIndex arr ix)