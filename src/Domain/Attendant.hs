{-# LANGUAGE DeriveGeneric #-}

module Domain.Attendant
  (
  Attendant(..),
  validateName
  )
where

import           Data.Aeson             (FromJSON, ToJSON)
import           Domain.ValidationError
import           GHC.Generics

instance ToJSON Attendant
instance FromJSON Attendant

data Attendant = Attendant { name :: String, lastName :: String } deriving (Show, Read, Generic)

validateName :: String -> Either ValidationError String
validateName name
  | len < 3   = Left NameIsTooShort
  | len > 25  = Left NameIsTooLong
  | otherwise = Right name
  where len = length name
