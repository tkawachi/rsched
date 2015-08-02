{-# LANGUAGE OverloadedStrings #-}
module Rsched.Job (
  Job ()
  ) where

import Control.Applicative ((<$>), (<*>))
import Control.Monad (mzero)
import Data.Aeson (FromJSON, ToJSON, Value(..), (.:), (.=), parseJSON, toJSON, object)
import Data.Text (Text)

-- | Job
data Job = Job {
  jobId :: Text,
  jobMethod :: Text,
  jobUrl :: Text,
  jobBody :: Text
  } deriving Show

instance FromJSON Job where
  parseJSON (Object v) = Job <$>
                         v .: "id" <*>
                         v .: "method" <*>
                         v .: "url" <*>
                         v .: "body"
  parseJSON _ = mzero

instance ToJSON Job where
  toJSON (Job id method url body) = object [
    "id" .= id,
    "method" .= method,
    "url" .= url,
    "body" .= body
    ]
