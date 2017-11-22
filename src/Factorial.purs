module Factorial where

import Prelude (Unit
               , bind
               , (*)
               , (-)
               )
import Control.Monad.Eff (Eff, kind Effect)
import Control.Monad (pure)
import Data.Maybe ( Maybe(..) )

import Gcf (RESPONSE
           , REQUEST
           , getRequestBody
           , respondWithJson
           )

data ResponseBody = Success Int
                  | Error String

handle :: Eff (request :: REQUEST, response :: RESPONSE) Unit
handle = do
  resp <- makeResponseBody
  encodeResponse resp

encodeResponse :: forall eff. ResponseBody -> Eff (response :: RESPONSE | eff) Unit
encodeResponse (Success i) = respondWithJson 200 { number: i }
encodeResponse (Error s)   = respondWithJson 200 { error: s }

makeResponseBody :: forall eff. Eff (request :: REQUEST | eff) ResponseBody
makeResponseBody = do
  number <- getRequestBody "number"
  pure (f number)
    where
      f (Just n)  = Success (factorial n)
      f (Nothing) = Error "missing key: number"

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)
