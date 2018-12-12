module Domain.Attendant
  (
  Attendant(..),
  validateName
  )
where

import Domain.ValidationError

data Attendant = Attendant { name :: String, lastName :: String } deriving (Show, Read)

validateName :: String -> Either ValidationError String
validateName name
  | len < 3   = Left NameIsTooShort
  | len > 25  = Left NameIsTooLong
  | otherwise = Right name
  where len = length name
