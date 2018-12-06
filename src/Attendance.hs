module Attendance
  (createAttendant,
  deleteAttendant,
  listAttendants,
  attend,
  hide,
  listAttendancies)
where

import Attendant
import ValidationError

createAttendant :: String -> String -> Either ValidationError Attendant
createAttendant firstName lastName =
  Right $ Attendant firstName lastName

listAttendants :: [Attendant]
listAttendants = [Attendant "Test" "User"]

deleteAttendant :: Attendant -> Either ValidationError Attendant
deleteAttendant a =
  Right $ Attendant "Test" "User"

attend :: a -> a
attend a = a

hide :: a -> a
hide a = a

listAttendancies :: a -> a
listAttendancies a = a
