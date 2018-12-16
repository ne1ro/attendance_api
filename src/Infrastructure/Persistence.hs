{-# LANGUAGE OverloadedStrings #-}
module Infrastructure.Persistence
  (listAttendants,
  Attendant(..)
  )
where

import Control.Applicative
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow

data Attendant = Attendant
  { attendantId :: Int, firstName :: String, lastName :: String }
  deriving (Eq, Read, Show)

instance FromRow Attendant where
  fromRow = Attendant <$> field <*> field <*> field

listAttendants :: Connection -> IO [Attendant]
listAttendants conn = query_ conn "SELECT * FROM attendants" :: IO [Attendant]
