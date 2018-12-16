{-# LANGUAGE DeriveGeneric #-}

module Application.AttendantDTO (AttendantDTO(..)) where

import           Data.Aeson   (FromJSON, ToJSON)
import           GHC.Generics

data AttendantDTO = AttendantDTO { attendantId :: Int, firstName :: String, lastName :: String } deriving (Show, Read, Generic)

instance ToJSON AttendantDTO
instance FromJSON AttendantDTO
