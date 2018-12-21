{-# LANGUAGE OverloadedStrings #-}

module Application
  (createAttendant,
  deleteAttendant,
  listAttendants,
  attend,
  hide,
  listAttendancies,
  AttendantDTO(..),
  AttendanceDTO(..)
  )
where

import           Application.AttendanceDTO
import           Application.AttendantDTO
import           Control.Monad
import           Control.Monad.IO.Class
import           Control.Monad.Trans.Except
import           Data.Time.Calendar
import           Data.Time.Clock
import           Database.SQLite.Simple
import           Database.SQLite.Simple.FromRow
import qualified Domain.Domain                  as Domain
import qualified Infrastructure.Persistence     as Persistence

createAttendant :: Connection -> AttendantDTO -> IO (Either Domain.ValidationError AttendantDTO)
createAttendant conn body =
  case saveAndConvertAttendant body of
    Left err -> return $ Left err
    Right attendant -> do
      Persistence.createAttendant conn (firstName attendant) (lastName attendant)
      return $ Right attendant

listAttendants :: Connection -> IO [AttendantDTO]
listAttendants conn = do
  attendants <- Persistence.listAttendants conn
  return $ map fromPersistenceToDTO attendants

deleteAttendant :: Connection -> Int -> IO ()
deleteAttendant = Persistence.deleteAttendant

listAttendancies :: Connection -> Day -> IO [AttendanceDTO]
listAttendancies conn day = do
  attendancies <- Persistence.listAttendanciesByDay conn day
  return $ map fromPersistenceToDTO attendancies

attend :: Domain.Attendant -> Day -> Day -> Either Domain.ValidationError Domain.AttendanceMark
attend = Domain.attend

hide :: Domain.AttendanceMark -> Maybe Domain.AttendanceMark
hide = Domain.hide

-- Private functions

saveAndConvertAttendant :: AttendantDTO -> Either Domain.ValidationError AttendantDTO
saveAndConvertAttendant body =
  case Domain.saveAttendant (firstName body) (lastName body) of
    Left err -> Left err
    Right a  -> Right $ fromDomainToDTO a

fromPersistenceToDTO :: Persistence.AttendantDB -> AttendantDTO
fromPersistenceToDTO a =
  AttendantDTO
    (Persistence.attendantId a)
    (Persistence.firstName a)
    (Persistence.lastName a)

fromDomainToDTO :: Domain.Attendant -> AttendantDTO
fromDomainToDTO a =
  AttendantDTO 0
    (Domain.firstName a)
    (Domain.lastName a)
