{-# LANGUAGE OverloadedStrings #-}

module Application
  (createAttendant,
  deleteAttendant,
  listAttendants,
  attend,
  hide,
  listAttendancies)
where

import Data.Time.Calendar
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow
import Domain.AttendanceMark
import Domain.Attendant
import Domain.ValidationError
import qualified Domain.Domain as Domain
import qualified Infrastructure.Persistence as Persistence

createAttendant :: String -> String -> Either ValidationError Attendant
createAttendant = Domain.saveAttendant

listAttendants :: Connection -> IO [Persistence.TestField]
listAttendants = Persistence.listAttendants

deleteAttendant :: Attendant -> Maybe Attendant
deleteAttendant = Domain.deleteAttendant

attend :: Attendant -> Day -> Day -> Either ValidationError AttendanceMark
attend = Domain.attend

hide :: AttendanceMark -> Maybe AttendanceMark
hide = Domain.hide

listAttendancies :: Day -> [AttendanceMark]
listAttendancies day =
  [AttendanceMark (Attendant "Test" "User") day True]
