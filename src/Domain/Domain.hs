module Domain.Domain
  (saveAttendant,
  deleteAttendant,
  attend,
  hide,
  Attendant(..),
  AttendanceMark(..),
  ValidationError(..)
  )
where

import           Data.Time.Calendar
import           Domain.AttendanceMark
import           Domain.Attendant
import           Domain.ValidationError

saveAttendant :: String -> String -> Either ValidationError Attendant
saveAttendant firstName lastName = do
  fN <- validateName firstName
  lN <- validateName lastName
  Right $ Attendant fN lN

deleteAttendant :: Attendant -> Maybe Attendant
deleteAttendant = Just

attend :: Attendant -> Day -> Day -> Either ValidationError AttendanceMark
attend attendant date today = do
  validDate <- validateDate date today
  Right $ AttendanceMark attendant validDate False

hide :: AttendanceMark -> Maybe AttendanceMark
hide = Just
