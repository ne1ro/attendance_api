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
import qualified Domain

createAttendant :: String -> String -> Either ValidationError Attendant
createAttendant = Domain.saveAttendant

listAttendants :: [Attendant]
listAttendants = [Attendant "Test" "User"]

deleteAttendant :: Attendant -> Either ValidationError Attendant
deleteAttendant = Domain.deleteAttendant

attend :: Attendant -> DateTime -> Either ValidationError Attendant
attend = Domain.attend

hide :: a -> a
hide = Domain.hide

listAttendancies :: a -> a
listAttendancies a = a
