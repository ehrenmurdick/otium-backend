module HelloWorld where

import Control.Monad.Eff
import Prelude
import Data.Generic.Rep (class Generic)

foreign import data RESPONSE :: Effect

foreign import send :: forall eff. Int -> String -> Eff (response :: RESPONSE | eff) Unit

newtype ReqBody = ReqBody
  { number :: Int
  , text :: String
  }

derive instance genericReqData :: Generic ReqBody _

handle :: forall t4. ReqBody -> Eff (response :: RESPONSE | t4) Unit
handle (ReqBody body) = send 200 msg
  where
    n = factorial body.number
    ns = show n
    msg = ns <> " " <> body.text

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * (factorial (n - 1))
