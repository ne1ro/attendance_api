{-# LANGUAGE OverloadedStrings #-}
module Lib
    ( server
    ) where

import Application
import Data.Time.Calendar
import Data.Time.Clock
import Data.Monoid (mconcat)
import Web.Scotty

server :: IO ()
server = do
  putStrLn "Starting server ..."

  scotty 3000 $ do
    get "/:word" $ do
      today <- fmap utctDay getCurrentTime
      beam <- param "word"
      html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]
