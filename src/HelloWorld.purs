module HelloWorld where

import Prelude (Unit
               , (-)
               , (*)
               , (<>)
               )
import Control.Monad.Eff (Eff, kind Effect)
import Data.Generic.Rep (class Generic)

foreign import data RESPONSE :: Effect

foreign import send :: forall eff. Int -> ResponseBody -> Eff (response :: RESPONSE | eff) Unit

newtype ReqBody = ReqBody
  { number :: Int
  , text :: String
  }

newtype ResponseBody = ResponseBody
  { number :: Int
  , message :: String
  }

derive instance genericReqData :: Generic ReqBody _

handle :: forall t4. ReqBody -> Eff (response :: RESPONSE | t4) Unit
handle (ReqBody body) = send 200 (ResponseBody {number: body.number, message: "Hello, " <> body.text <> "!"})

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * (factorial (n - 1))
