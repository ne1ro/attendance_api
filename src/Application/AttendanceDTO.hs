{-# LANGUAGE DeriveGeneric #-}

module Application.AttendanceDTO (AttendanceDTO(..)) where

import           Application.AttendantDTO
import           Data.Aeson               (FromJSON, ToJSON)
import           Data.Time.Calendar
import           GHC.Generics

data AttendanceDTO = AttendanceDTO { aFirstName :: String, aLastName :: String, status :: Bool, day :: Day } deriving (Show, Read, Generic)

instance ToJSON AttendanceDTO
instance FromJSON AttendanceDTO
