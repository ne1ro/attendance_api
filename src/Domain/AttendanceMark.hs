module Domain.AttendanceMark
  (
  AttendanceMark(..),
  validateDate
  )
where

import Control.Monad.IO.Class
import Data.Time.Calendar
import Domain.Attendant
import Domain.ValidationError

data Reason = Important | NotImportant deriving (Show)
data AttendanceMark = AttendanceMark
  {
    attendant :: Attendant,
    timestamp :: Day,
    status :: Bool
  }
  deriving (Show, Read)

validateDate :: Day -> Day -> Either ValidationError Day
validateDate dayToValidate dayToCompare
  | dayToValidate < dayToCompare = Left DateIsInvalid
  | otherwise                    = Right dayToValidate
