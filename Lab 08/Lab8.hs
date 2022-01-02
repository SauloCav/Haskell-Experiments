module Main where

import Prelude (IO, Char, Ord, Bool(True, False), (<=), print, putStrLn, readFile, writeFile, getContents, (>>=))

import System.Environment(getArgs)
import Data.List(sortBy)
import Data.List(isInfixOf)
import Functions
import List
import Maybe

main = program5

program1 :: IO ()
program1 = getArgs >>= print

program2 :: IO ()
program2 = getArgs >>= readFile . head >>= putStrLn

program3 :: IO ()
program3 = getArgs >>= readFile . head >>= putStrLn . concat . intercalate "\n" . mergesort . lines

program4 :: IO ()
program4 = getArgs >>= treatArgs where
treatArgst [from , to] = readFile from >>= writeFile to
treatArgst _ = putStrLn "You must pass exactly two arguments."

program5 :: IO ()
program5 = getArgs >>= treatArgs where
treatArgs [from , to] = readFile from >>= writeFile to
treatArgs [] = getContents >>= putStrLn
treatArgs [x] = getContents >>= putStrLn
treatArgs _ = putStrLn "You must pass exactly two arguments."

program6 :: IO ()
program6 = getArgs >>= treatArgs where 
	treatArgst [xs , y] = readFile xs >>= putStrLn . concat . intercalate "\n" . cond (isInfixOf x xs) . lines
	treatArgst _ = putStrLn "You must pass exactly two arguments."

-- Extra Questions:

-- Questão 19
-- instance Eq a => Eq (Maybe a) where  
    -- Just x == Just y = x == y  
    -- Nothing == Nothing = True  
    -- _ == _ = False 

-- Questão 21
-- instance Ord a => Ord (Maybe a) where
   -- Nothing <= _ = True
   -- Just _ <= Nothing = False
   -- Just x <= Just y = x <= y

-- Questão 22
-- instance Show a => Show (Maybe a) where 
	-- newShow _ (Maybe Nothing)  = id
	-- newShow n (Maybe (Just x)) = newShow n x
