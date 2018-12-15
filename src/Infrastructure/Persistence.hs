{-# LANGUAGE OverloadedStrings #-}
module Infrastructure.Persistence
  (listAttendants,
  TestField
  )
where

import Control.Applicative
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow

data TestField = TestField Int String deriving (Show)

instance FromRow TestField where
  fromRow = TestField <$> field <*> field

listAttendants :: Connection -> IO [TestField]
listAttendants conn = do
  query_ conn "SELECT * FROM attendants" :: IO [TestField]
