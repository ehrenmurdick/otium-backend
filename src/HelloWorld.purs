module HelloWorld where

import Prelude (Unit
               , (-)
               , (*)
               , (<>)
               , show
               )
import Control.Monad.Eff (Eff, kind Effect)
import Data.Generic (class Generic)

foreign import data RESPONSE :: Effect

foreign import send :: forall eff. Int -> String -> Eff (response :: RESPONSE | eff) Unit

newtype ReqBody = ReqBody
  { number :: Int
  , text :: String
  }

derive instance genericReqData :: Generic ReqBody

handle :: forall t4. ReqBody -> Eff (response :: RESPONSE | t4) Unit
handle (ReqBody body) = send 200 msg
  where
    n = factorial body.number
    ns = show n
    msg = ns <> " " <> body.text

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * (factorial (n - 1))
