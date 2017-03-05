module Helpers where

import Control.Bind (bind)
import Control.Monad.Eff (Eff)
import Data.Foldable (foldl, traverse_)
import Data.List (List(..), (:))
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..))
import Prelude (Unit, id, map)
import RxJS.Observable (Observable, combineLatest, just)

maybeToArr :: forall a. Maybe a -> Array a
maybeToArr m = case m of
  (Just val) -> [val]
  Nothing -> []

forEachMaybe :: forall e. Maybe (Eff e Unit) -> Eff e Unit
forEachMaybe m = traverse_ id (maybeToArr m)

tupleMaybes :: forall a b. Maybe a -> Maybe b -> Maybe (Tuple a b)
tupleMaybes ma mb =
  bind ma (\a -> map (\b -> Tuple a b) mb)

combineLatestAll :: forall a. List (Observable a) -> Observable (List a)
combineLatestAll list = foldl (\acc cur -> combineLatest (\x y -> y : x) acc cur) (just Nil) list
