module HelloWorld where

import Prelude (Unit
               , (-)
               , (*)
               , bind
               , (<>)
               )
import Control.Monad.Eff (Eff, kind Effect)

foreign import data RESPONSE :: Effect
foreign import data REQUEST :: Effect

foreign import send :: forall eff. Int -> ResponseBody -> Eff (response :: RESPONSE | eff) Unit

foreign import get :: forall eff a. String -> Eff (request :: REQUEST | eff) a

newtype ResponseBody = ResponseBody
  { number :: Int
  , message :: String
  }

handle :: forall t4. Eff (response :: RESPONSE, request :: REQUEST | t4) Unit
handle = do
  name <- get "name"
  number <- get "number"
  send 200 (ResponseBody {number: fs number, message: msg name})
    where
      fs n  = factorial n
      msg n = "hello " <> n <> "!"

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * (factorial (n - 1))
