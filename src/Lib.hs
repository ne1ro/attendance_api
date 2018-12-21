{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( server
    ) where

import qualified Application
import           Control.Applicative
import           Control.Monad
import           Control.Monad.IO.Class
import           Data.Aeson                (object, (.=))
import           Data.Time.Calendar
import           Database.SQLite.Simple
import           Network.HTTP.Types.Status
import           Web.Scotty

instance Parsable Day where parseParam = readEither

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
      Left err        -> json $ object ["message" .= validationError]
      Right attendant -> json attendant

  delete "/attendants/:id" $ do
    attendantId <- param "id" :: ActionM Int
    liftIO $ Application.deleteAttendant conn attendantId
    status status204

  get "/attendancies/:day" $ do
    day <- param "day" :: ActionM Day
    attendants <- liftIO $ Application.listAttendancies conn day
    json attendants

  defaultHandler $ \str -> do
    status status500
    json str

server :: IO ()
server = do
  putStrLn "Starting server ..."
  conn <- open "attendance.db"
  scotty 3000 $ router conn
  close conn
