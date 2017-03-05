module Test.JsHelpers where

import DOM.Event.Event (Event)

foreign import stringify :: forall a. a -> String

foreign import newEvent :: String -> Event
