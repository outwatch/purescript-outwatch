module Example.Monadic.Counter where

import Control.Monad.Eff.Random (RANDOM, randomInt)
import Control.Monad.Except.Trans (lift)
import OutWatch.Monadic.Attributes (childShow_, click_, text_)
import OutWatch.Monadic.Tags (button_, div_, h3_)
import OutWatch.Monadic.Types (HTML)
import OutWatch.Monadic.Utils (createHandler_, cmapSink)
import Prelude (bind, Unit, (+), (#), const, negate, ($), show)
import RxJS.Observable (merge, scan, startWith)

app :: forall e. HTML (random :: RANDOM|e) Unit
app = do
    rnd <- lift $ randomInt 10 90
    div_ do
        div_ do 
            text_ "some random number:"
            text_ (show rnd)
        incrementHandlder <- createHandler_ [0]
        decrementHandlder <- createHandler_ [0]
        let count = merge incrementHandlder.src decrementHandlder.src
                # scan (+) 0
                # startWith 0
        button_ do
            text_ "Decrement"
            click_ (decrementHandlder # cmapSink (const (-2)))
        button_ do
            text_ "Increment"
            click_ (incrementHandlder # cmapSink (const ( 2)))
        h3_ do
            text_ "Monadic Counter: "
            childShow_ count
