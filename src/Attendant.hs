module Attendant
  (Attendant(..))
where

data Attendant = Attendant { name :: String, lastName :: String } deriving (Show, Read)
