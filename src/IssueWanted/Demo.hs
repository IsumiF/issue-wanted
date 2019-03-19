{-# LANGUAGE ExistentialQuantification #-}

module IssueWanted.Demo
    (
    ) where

import           Control.Exception (ArithException (..), AsyncException (..))
import           Data.Typeable
import qualified Text.Show         as Show

data ImpossibleCodePath = ImpossibleCodePath
    deriving (Eq, Show)

instance Exception ImpossibleCodePath where

data MyException = forall e. (Show e, Typeable e) => MyException e

instance Show MyException where
    show (MyException e) =
      Show.show e

multiError :: Int -> Either MyException Int
multiError n =
    case n of
      0 -> Left (MyException DivideByZero)
      1 -> Left (MyException StackOverflow)
      _ -> Right n
