{-# LANGUAGE DeriveGeneric #-}

module Domain.AttendanceMark
  (
  AttendanceMark(..),
  validateDate
  )
where

import Control.Monad.IO.Class
import Data.Aeson (FromJSON, ToJSON)
import Data.Time.Calendar
import Domain.Attendant
import Domain.ValidationError
import GHC.Generics

instance ToJSON AttendanceMark
instance FromJSON AttendanceMark

data Reason = Important | NotImportant deriving (Show)
data AttendanceMark = AttendanceMark
  {
    attendant :: Attendant,
    timestamp :: Day,
    status :: Bool
  }
  deriving (Show, Read, Generic)

validateDate :: Day -> Day -> Either ValidationError Day
validateDate dayToValidate dayToCompare
  | dayToValidate < dayToCompare = Left DateIsInvalid
  | otherwise                    = Right dayToValidate
