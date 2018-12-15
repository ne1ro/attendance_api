{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( server
    ) where

import qualified Application
import Control.Applicative
import Data.Monoid (mconcat)
import Data.Time.Calendar
import Data.Time.Clock
import Database.SQLite.Simple
import Web.Scotty

server :: IO ()
server = do
  putStrLn "Starting server ..."
  conn <- open "attendance.db"

  scotty 3000 $ do
    get "/attendants" $ do
      json $ Application.listAttendants conn

    -- get "/attendancies/:day" $ do
    --   day <- param "word" :: String
    --   json $ Application.listAttendancies day

    -- get "/:word" $ do
      -- today <- fmap utctDay getCurrentTime
      -- beam <- param "word"
      -- html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]

  close conn
