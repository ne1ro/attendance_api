module Domain.AttendanceMark
  (AttendanceMark(..))
where

import Domain.Attendant
import Data.Time.Calendar

data Reason = Important | NotImportant deriving (Show)
data AttendanceMark = AttendanceMark
  {
    attendant :: Attendant,
    timestamp :: Day,
    status :: Bool
  }
  deriving (Show, Read)
