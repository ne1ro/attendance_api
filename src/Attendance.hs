module Attendance
  (createAttendant,
  deleteAttendant,
  listAttendants,
  attend,
  hide,
  listAttendancies)
where

import Attendant

data ValidationError = String deriving(Show)

createAttendant :: String -> String -> Attendant
createAttendant firstName lastName =
  Attendant firstName lastName

deleteAttendant :: Attendant -> Attendant
deleteAttendant a = a

listAttendants :: [Attendant]
listAttendants = [Attendant "Test" "User"]

attend :: a -> a
attend a = a

hide :: a -> a
hide a = a

listAttendancies :: a -> a
listAttendancies a = a
