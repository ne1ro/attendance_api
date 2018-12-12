module Application
  (createAttendant,
  deleteAttendant,
  listAttendants,
  attend,
  hide,
  listAttendancies)
where

import Data.Time.Calendar
import Domain.AttendanceMark
import Domain.Attendant
import Domain.ValidationError
import qualified Domain.Domain as Domain

createAttendant :: String -> String -> Either ValidationError Attendant
createAttendant = Domain.saveAttendant

listAttendants :: [Attendant]
listAttendants = [Attendant "Test" "User"]

deleteAttendant :: Attendant -> Maybe Attendant
deleteAttendant = Domain.deleteAttendant

attend :: Attendant -> Day -> Either ValidationError AttendanceMark
attend = Domain.attend

hide :: AttendanceMark -> Maybe AttendanceMark
hide = Domain.hide

listAttendancies :: Day -> [AttendanceMark]
listAttendancies day = []
