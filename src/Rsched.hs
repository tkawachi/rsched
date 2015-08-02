{-# LANGUAGE OverloadedStrings #-}
module Rsched
    ( app
    ) where

import Control.Exception (SomeException)
import Control.Exception.Lifted (handle)
import Control.Monad.IO.Class (liftIO)
import Data.Aeson (Value, encode, object, (.=))
import Data.Aeson.Parser (json)
import Data.Conduit (($$))
import Data.Conduit.Attoparsec (sinkParser)
import Data.Text ( Text )
import Network.HTTP.Types (Method, status200, status400)
import Network.Wai (Application, Request, Response, responseLBS)
import Network.Wai.Conduit (sourceRequestBody)

import qualified Rsched.Job as J

app :: Application
app req sendResponse = handle (sendResponse . invalidJson) $ do
  value <- sourceRequestBody req $$ sinkParser json
  newValue <- liftIO $ modValue req value
  sendResponse $ responseLBS
    status200
    [("Content-Type", "application/json")]
    $ encode newValue

invalidJson :: SomeException -> Response
invalidJson ex = responseLBS
  status400
  [("Content-Type", "application/json")]
  $ encode $ object
    [ ("message" .= show ex)
    ]

modValue :: Request -> Value -> IO Value
modValue req value = do
  return value
