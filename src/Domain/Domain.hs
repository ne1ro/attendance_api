module Domain.Domain
  (saveAttendant,
  deleteAttendant,
  attend,
  hide)
where

import Data.Time.Calendar
import Domain.Attendant
import Domain.AttendanceMark
import Domain.ValidationError

saveAttendant :: String -> String -> Either ValidationError Attendant
saveAttendant firstName lastName = do
  fN <- validateName firstName
  lN <- validateName lastName
  Right $ Attendant fN lN

deleteAttendant :: Attendant -> Maybe Attendant
deleteAttendant = Just

attend :: Attendant -> Day -> Either ValidationError AttendanceMark
attend attendant date = Right $ AttendanceMark attendant date False

hide :: AttendanceMark -> Maybe AttendanceMark
hide = Just
