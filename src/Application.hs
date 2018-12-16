{-# LANGUAGE OverloadedStrings #-}

module Application
  (createAttendant,
  deleteAttendant,
  listAttendants,
  attend,
  hide,
  listAttendancies)
where

import qualified Application.AttendantDTO as AttendantDTO
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

listAttendants :: Connection -> IO [AttendantDTO.AttendantDTO]
listAttendants conn = do
  attendants <- Persistence.listAttendants conn
  return $ map fromPersistenceToDTO attendants

deleteAttendant :: Attendant -> Maybe Attendant
deleteAttendant = Domain.deleteAttendant

attend :: Attendant -> Day -> Day -> Either ValidationError AttendanceMark
attend = Domain.attend

hide :: AttendanceMark -> Maybe AttendanceMark
hide = Domain.hide

listAttendancies :: Day -> [AttendanceMark]
listAttendancies day =
  [AttendanceMark (Attendant "Test" "User") day True]

fromPersistenceToDTO :: Persistence.Attendant -> AttendantDTO.AttendantDTO
fromPersistenceToDTO a =
  AttendantDTO.AttendantDTO
    (Persistence.Attendant.attendantId a)
    (Persistence.Attendant.firstName a)
    (Persistence.Attendant.lastName a)
