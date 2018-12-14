{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Lib
    ( server
    ) where

import qualified Application
import Data.Monoid (mconcat)
import Data.Time.Calendar
import Data.Time.Clock
import Web.Scotty

server :: IO ()
server = do
  putStrLn "Starting server ..."

  scotty 3000 $ do
    get "/attendants" $ do
      json Application.listAttendants

    get "/attendancies/:day" $ do
      day <- param "word" :: Day
      json $ Application.listAttendancies day

    -- get "/:word" $ do
      -- today <- fmap utctDay getCurrentTime
      -- beam <- param "word"
      -- html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]
