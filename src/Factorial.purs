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

data ResponseBody = Success { number :: Int }
                  | Error   { error :: String }

handle :: Eff (request :: REQUEST, response :: RESPONSE) Unit
handle = do
  resp <- makeResponseBody
  succeed resp

succeed :: forall eff a. a -> Eff (response :: RESPONSE | eff) Unit
succeed body = respondWithJson 200 body

makeResponseBody :: forall eff. Eff (request :: REQUEST | eff) ResponseBody
makeResponseBody = do
  number <- getRequestBody "number"
  pure (f number)
    where
      f (Just n)  = Success {number: factorial n}
      f (Nothing) = Error   {error: "missing key: number"}

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)
