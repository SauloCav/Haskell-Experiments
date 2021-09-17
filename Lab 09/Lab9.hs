module Main where

import Prelude (IO , putStrLn, getLine, print, (>=),
                (<$>), (<*>), pure,
                (*>), (>>=),
                Char, (==), Functor(fmap), Bool(True, False))

import Data.Char(isLower)
import Data.Char(isUpper)
import Data.Char(isDigit) 
import System.Environment(getArgs)
import Bool
import Functions
import List
import qualified SeqTree as ST
import qualified BSTree as BT
import Either

ask :: [Char] -> IO [Char]
ask _ = putStrLn "Enter your password: " *> getLine

getPasswd :: IO ([Char], [Char])
getPasswd = do
	p1 <- ask ""
	p2 <- ask ""
	-- pure ((,) <$> p1 <*> p2) 'failed idea'
	pure (p1, p2)

validPasswd :: IO [Char]
validPasswd = getPasswd >>= f where
	f (p1 , p2) = cond (p1 == p2) (pure p1) (incorrect *> validPasswd)
	incorrect = putStrLn "They don't match! Try again"

isStrong :: [Char] -> Bool
isStrong [] = False
isStrong (xs) = cond (opAnd (opAnd (hasUppercase xs) (hasLowercase xs)) (opAnd (isLongEnough xs) (hasDigit xs))) (True) (False)

hasUppercase :: [Char] -> Bool
hasUppercase [] = False
hasUppercase (xs) = cond (or (map isLower xs)) (True) (False)

hasLowercase :: [Char] -> Bool
hasLowercase [] = False
hasLowercase (xs) = cond (or (map isUpper xs)) (True) (False)

isLongEnough :: [Char] -> Bool
isLongEnough [] = False
isLongEnough (xs) = cond (length xs >= 8) (True) (False)

hasDigit :: [Char] -> Bool
hasDigit [] = False
hasDigit (xs) = cond (or (map isDigit xs)) (True) (False)

strongPasswd :: IO [Char]
strongPasswd = validPasswd >>= f where
	f (xs) = cond (isStrong xs) (pure xs) (incorrect *> strongPasswd)
	incorrect = putStrLn "Weak password! Try again"

main = strongPasswd


