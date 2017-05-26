module OutWatch.Helpers.Helpers where

import Control.Apply ((<*>))
import Control.Monad.Eff (Eff)
import Data.Foldable (foldl, sequence_)
import Data.List (List(..), (:))
import Data.Maybe (Maybe)
import Data.Tuple (Tuple(..))
import Prelude (Unit, (<$>))
import RxJS.Observable (Observable, combineLatest, just)

forEachMaybe :: forall e. Maybe (Eff e Unit) -> Eff e Unit
forEachMaybe m = sequence_ m

tupleMaybes :: forall a b. Maybe a -> Maybe b -> Maybe (Tuple a b)
tupleMaybes ma mb = Tuple <$> ma <*> mb

combineLatestAll :: forall a. List (Observable a) -> Observable (List a)
combineLatestAll list = foldl (\acc cur -> combineLatest (\x y -> y : x) acc cur) (just Nil) list
