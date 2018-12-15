module Application
  (createAttendant,
  deleteAttendant,
  listAttendants,
  attend,
  hide,
  listAttendancies)
where

import Database.SQLite.Simple
import Data.Time.Calendar
import Domain.AttendanceMark
import Domain.Attendant
import Domain.ValidationError
import qualified Domain.Domain as Domain
import qualified Infrastructure.Persistence as Persistence

createAttendant :: String -> String -> Either ValidationError Attendant
createAttendant = Domain.saveAttendant

listAttendants :: Connection -> [Attendant]
listAttendants conn = [Attendant "Test" "User"]

deleteAttendant :: Attendant -> Maybe Attendant
deleteAttendant = Domain.deleteAttendant

attend :: Attendant -> Day -> Day -> Either ValidationError AttendanceMark
attend = Domain.attend

hide :: AttendanceMark -> Maybe AttendanceMark
hide = Domain.hide

listAttendancies :: Day -> [AttendanceMark]
listAttendancies day =
  [AttendanceMark (Attendant "Test" "User") day True]
