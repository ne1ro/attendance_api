module Domain
  (saveAttendant,
  deleteAttendant,
  attend,
  hide)
where

import Data.Dates
import Attendant
import ValidationError

saveAttendant :: String -> String -> Either ValidationError Attendant
saveAttendant = Right $ Attendant firstName lastName

deleteAttendant :: Attendant -> Either ValidationError Attendant
deleteAttendant a = Right $ Attendant "Test" "User"

attend :: Attendant -> DateTime -> Either ValidationError Attendant
attend attendant date = Right attendant

hide :: a -> a
hide a = a
