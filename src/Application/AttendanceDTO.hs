{-# LANGUAGE DeriveGeneric #-}

module Application.AttendanceDTO (AttendanceDTO(..)) where

import Application.AttendantDTO
import Data.Time.Calendar
import           Data.Aeson   (FromJSON, ToJSON)
import           GHC.Generics

data AttendanceDTO = AttendanceDTO { attendant :: AttendantDTO, status :: Bool, date :: Day } deriving (Show, Read, Generic)

instance ToJSON AttendanceDTO
instance FromJSON AttendanceDTO
