module HelloWorld where

import Prelude (Unit
               , bind
               , (<>)
               )
import Control.Monad.Eff (Eff, kind Effect)
import Control.Monad (pure)
import Data.Maybe ( Maybe(..) )

import Gcf (RESPONSE
           , REQUEST
           , getRequestBody
           , respondWithJson
           )

newtype ResponseBody = ResponseBody
  { message :: String
  }

handle :: forall eff. Eff (response :: RESPONSE, request :: REQUEST | eff) Unit
handle = do
  resp <- makeResponseBody
  succeed resp

succeed :: forall eff. ResponseBody -> Eff (response :: RESPONSE | eff) Unit
succeed body = respondWithJson 200 body

makeResponseBody :: forall eff. Eff (request :: REQUEST | eff) ResponseBody
makeResponseBody = do
  name <- getRequestBody "name"
  pure (ResponseBody {message: msg name})
    where
      msg (Just name) = "hello " <> name <> "!"
      msg Nothing = "error, missing key: name"
