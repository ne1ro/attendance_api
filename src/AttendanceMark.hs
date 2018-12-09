module AttendanceMark
  (AttendanceMark(..))
where

import Attendant
import Data.Time.Calendar

data Reason = Important | NotImportant deriving (Show)
data AttendanceMark = AttendanceMark
  {
    attendant :: Attendant,
    timestamp :: Day,
    status :: Bool
  }
  deriving (Show, Read)
