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
saveAttendant = Right $ Attendant firstName lastName

deleteAttendant :: Attendant -> Either ValidationError Attendant
deleteAttendant a = Right $ Attendant "Test" "User"

attend :: Attendant -> String -> Either ValidationError Attendant
attend attendant date = Right $ AttendanceMark attendant date false

hide :: AttendanceMark -> Either ValidationError AttendanceMark
hide attendanceMark = Right $ attendanceMark
