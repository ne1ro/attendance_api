module Domain.ValidationError
  (ValidationError(..))
where

data ValidationError = InvalidIncomingData
  | NameIsTooShort
  | NameIsTooLong
  | DateIsInvalid
  deriving(Show)
