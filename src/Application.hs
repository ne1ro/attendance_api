{-# LANGUAGE OverloadedStrings #-}

module Application
  (createAttendant,
  deleteAttendant,
  listAttendants,
  attend,
  hide,
  listAttendancies)
where

import           Application.AttendantDTO
import           Data.Time.Calendar
import           Database.SQLite.Simple
import           Database.SQLite.Simple.FromRow
import           Domain.AttendanceMark
import           Domain.Attendant
import qualified Domain.Domain                  as Domain
import           Domain.ValidationError
import qualified Infrastructure.Persistence     as Persistence

createAttendant :: Connection -> AttendantDTO -> IO (Either ValidationError [AttendantDTO])
createAttendant conn body = do
  return $ Right body

listAttendants :: Connection -> IO [AttendantDTO]
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

fromPersistenceToDTO :: Persistence.AttendantDB -> AttendantDTO
fromPersistenceToDTO a =
  AttendantDTO
    (Persistence.attendantId a)
    (Persistence.firstName a)
    (Persistence.lastName a)
