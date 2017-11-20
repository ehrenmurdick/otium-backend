module HelloWorld where

import Prelude (Unit
               , (-)
               , (*)
               , bind
               , (<>)
               )
import Control.Monad.Eff (Eff, kind Effect)
import Control.Monad (pure)

foreign import data RESPONSE :: Effect
foreign import data REQUEST :: Effect

foreign import send :: forall eff. Int -> ResponseBody -> Eff (response :: RESPONSE | eff) Unit

foreign import get :: forall eff a. String -> Eff (request :: REQUEST | eff) a

newtype ResponseBody = ResponseBody
  { number :: Int
  , message :: String
  }

handle :: forall eff. Eff (response :: RESPONSE, request :: REQUEST | eff) Unit
handle = do
  resp <- makeResponseBody
  succeed resp

succeed :: forall eff. ResponseBody -> Eff (response :: RESPONSE | eff) Unit
succeed body = send 200 body

makeResponseBody :: forall eff. Eff (request :: REQUEST | eff) ResponseBody
makeResponseBody = do
  name <- get "name"
  number <- get "number"
  pure (ResponseBody {message: msg name, number: factorial number})
    where
      msg :: String -> String
      msg name = "hello " <> name <> "!"

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * (factorial (n - 1))
