{-# LANGUAGE OverloadedStrings #-}
module Infrastructure.Persistence
  (listAttendants,
  AttendantDB(..))
where

import Control.Applicative
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow

data AttendantDB = AttendantDB
  { attendantId :: Int, firstName :: String, lastName :: String }
  deriving (Eq, Read, Show)

instance FromRow AttendantDB where
  fromRow = AttendantDB <$> field <*> field <*> field

listAttendants :: Connection -> IO [AttendantDB]
listAttendants conn = query_ conn "SELECT * FROM attendants" :: IO [AttendantDB]
