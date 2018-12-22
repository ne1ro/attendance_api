{-# LANGUAGE OverloadedStrings #-}
module Infrastructure.Persistence
  (listAttendants,
  createAttendant,
  deleteAttendant,
  listAttendanciesByDay,
  AttendantDB(..),
  AttendanceDB(..))
where

import           Control.Applicative
import           Data.Time.Calendar
import           Database.SQLite.Simple
import           Database.SQLite.Simple.FromRow

data AttendantDB = AttendantDB
  { attendantId :: Int, firstName :: String, lastName :: String }
  deriving (Eq, Read, Show)

data AttendanceDB = AttendanceDB
  { atId :: String, aFirstName :: String, aLastName :: String, status :: Bool, day :: Day }
  deriving (Eq, Read, Show)

instance FromRow AttendantDB where
  fromRow = AttendantDB <$> field <*> field <*> field

instance FromRow AttendanceDB where
  fromRow = AttendanceDB <$> field <*> field <*> field <*> field <*> field

instance ToRow AttendantDB where
  toRow (AttendantDB _aId aName aLastName) = toRow (aName, aLastName)

instance ToRow AttendanceDB where
  toRow (AttendanceDB attId _aFirstName _aLastName status day) = toRow (attId, status, day)

listAttendants :: Connection -> IO [AttendantDB]
listAttendants conn = query_ conn "SELECT * FROM attendants" :: IO [AttendantDB]

createAttendant :: Connection -> String -> String -> IO ()
createAttendant conn firstName lastName =
  execute
    conn
    "INSERT INTO attendants (firstName, lastName) VALUES (?, ?)"
    (AttendantDB 0 firstName lastName)

deleteAttendant :: Connection -> Int -> IO ()
deleteAttendant conn attendantId =
  execute conn "DELETE FROM attendants WHERE id = ?" (Only (attendantId :: Int))

listAttendanciesByDay :: Connection -> Day -> IO [AttendanceDB]
listAttendanciesByDay conn day =
  query
    conn
    "SELECT attendants.id AS attendantID, firstName, lastName, attendancies.status, attendancies.day FROM attendants LEFT JOIN attendancies ON attendants.id = attendancies.attendantId AND attendancies.day = ?"
    [day]

