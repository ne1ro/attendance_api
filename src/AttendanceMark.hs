module AttendanceMark
  (Attendant(..))
where

import Attendant

data Reason = Important | NotImportant deriving (Show)
data AttendanceMark = AttendanceMark
  {
    attendant :: Attendant,
    timestamp :: String,
    status :: Bool
  }
  deriving (Show, Read)
