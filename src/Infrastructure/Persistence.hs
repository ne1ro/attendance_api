{-# LANGUAGE OverloadedStrings #-}
module Infrastructure.Persistence
  (listAttendants,
  createAttendant,
  deleteAttendant,
  AttendantDB(..))
where

import           Control.Applicative
import           Database.SQLite.Simple
import           Database.SQLite.Simple.FromRow

data AttendantDB = AttendantDB
  { attendantId :: Int, firstName :: String, lastName :: String }
  deriving (Eq, Read, Show)

instance FromRow AttendantDB where
  fromRow = AttendantDB <$> field <*> field <*> field

instance ToRow AttendantDB where
  toRow (AttendantDB _aId aName aLastName) = toRow (aName, aLastName)

listAttendants :: Connection -> IO [AttendantDB]
listAttendants conn = query_ conn "SELECT * FROM attendants" :: IO [AttendantDB]

createAttendant :: Connection -> String -> String -> IO ()
createAttendant conn firstName lastName =
  execute conn "INSERT INTO attendants (firstName, lastName) VALUES (?, ?)" (AttendantDB 0 firstName lastName)

deleteAttendant :: Connection -> Int -> IO ()
deleteAttendant conn attendantId =
  execute conn "DELETE FROM attendants WHERE id = ?" (Only (attendantId :: Int))
