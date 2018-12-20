{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( server
    ) where

import qualified Application
import           Control.Applicative
import           Control.Monad
import           Control.Monad.IO.Class
import Data.Aeson (object, (.=))
import           Data.Time.Calendar
import           Data.Time.Clock
import           Database.SQLite.Simple
import           Network.HTTP.Types.Status
import           Web.Scotty

validationError :: String
validationError = "Validation Error"

router :: Connection -> ScottyM ()
router conn = do
  get "/attendants" $ do
    attendants <- liftIO $ Application.listAttendants conn
    json attendants

  post "/attendants" $ do
    body <- jsonData :: ActionM Application.AttendantDTO
    result <- liftIO $ Application.createAttendant conn body
    case result of
      Left err -> json $ object ["message" .= validationError]
      Right attendant -> json attendant

  delete "/attendants/:id" $ do
    id <- param "id" :: String
    liftIO $ Application.deleteAttendant conn id
    status status204

  defaultHandler $ \str -> do
    status status500
    json str

  -- get "/attendancies/:day" $ do
  --   day <- param "word" :: String
    -- today <- fmap utctDay getCurrentTime
  --   json $ Application.listAttendancies day

server :: IO ()
server = do
  putStrLn "Starting server ..."
  conn <- open "attendance.db"
  scotty 3000 $ router conn
  close conn
