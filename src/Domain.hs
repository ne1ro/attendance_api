module Domain
  (saveAttendant,
  deleteAttendant,
  attend,
  hide)
where

import Attendant
import AttendanceMark
import ValidationError

saveAttendant :: String -> String -> Either ValidationError Attendant
saveAttendant firstName lastName = Right $ Attendant firstName lastName

deleteAttendant :: Attendant -> Maybe Attendant
deleteAttendant a = Just a

attend :: Attendant -> String -> Either ValidationError AttendanceMark
attend attendant date = Right $ AttendanceMark attendant date False

hide :: AttendanceMark -> Maybe AttendanceMark
hide attendanceMark = Just attendanceMark
