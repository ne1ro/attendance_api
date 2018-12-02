{-# LANGUAGE OverloadedStrings #-}
module Lib
    ( server
    ) where

import Web.Scotty
import Data.Monoid (mconcat)

server :: IO ()
server = do
  putStrLn "Starting server ..."

  scotty 3000 $ do
    get "/:word" $ do
      beam <- param "word"
      html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]
