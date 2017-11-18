module HelloWorld where

import Prelude
import Control.Monad.Eff

foreign import data Response :: Type
foreign import data RESPONSE :: Effect


foreign import send :: forall eff. Response -> Int -> String -> Eff (response :: RESPONSE | eff) Unit

handle :: forall t4. Response -> Eff (response :: RESPONSE | t4) Unit
handle r = send r 200 (show (factorial 5) <> "\n")

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * (factorial (n - 1))
