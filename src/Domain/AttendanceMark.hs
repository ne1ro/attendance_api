module Domain.AttendanceMark
  (
  AttendanceMark(..),
  validateDate
  )
where

import Data.Time.Calendar
import Data.Time.Clock
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

validateDate :: Day -> Either ValidationError Day
validateDate day = do
  currentDay <- today
  validateD day currentDay

validateD :: Day -> Day -> Either ValidationError Day
validateD day currentDay
  | day < currentDay = Left DateIsInvalid
  | otherwise        = Right day

today :: IO Day
today = fmap utctDay getCurrentTime
