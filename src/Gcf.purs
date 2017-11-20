module Gcf where

import Prelude (Unit)
import Data.Function.Uncurried ( Fn3
                               , runFn3
                               , Fn2
                               , runFn2
                               )
import Control.Monad.Eff (Eff, kind Effect)
import Data.Maybe ( Maybe(..) )

foreign import data RESPONSE :: Effect
foreign import data REQUEST :: Effect

foreign import respondWithJsonImpl :: forall eff a. Fn2 Int a (Eff (response :: RESPONSE | eff) Unit)

respondWithJson :: forall eff a. Int -> a -> (Eff (response :: RESPONSE | eff) Unit)
respondWithJson code body = runFn2 respondWithJsonImpl code body 

foreign import getRequestBodyImpl :: forall eff a. Fn3 (Maybe a) (a -> Maybe a) String (Eff (request :: REQUEST | eff) (Maybe a))

getRequestBody :: forall eff a. String -> Eff (request :: REQUEST | eff) (Maybe a)
getRequestBody key = runFn3 getRequestBodyImpl Nothing Just key
