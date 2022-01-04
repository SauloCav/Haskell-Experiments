module Main where

import Prelude (Eq , (==) , (/=) , 
	Int , (+) , Char ,
	IO , readFile , putStrLn , show , readFile ,
	(>>=), pure )

import Data.Char (toLower)
import System.Environment(getArgs)
import Bool
import Functions
import List
import Maybe

import qualified BSTree as BST

-- count
count :: [[Char]] -> BST.BSTree [Char] Int
count = foldl f BST.empty where
	f bst word = g lkp where
		lkp = BST.lookup bst word
		g Nothing = BST.insert bst (word, 1)
		g (Just _) = BST.update bst word (+1)

-- process
process :: [Char] -> [Char]
process = makeOutput . countWords . clean where
	clean = remove ',' . remove '(' . remove ')' . remove '?' . remove '!'
	countWords = count . concat . map words . lines . map toLower
	makeOutput = concat . intercalate "\n" . map f . BST.inOrder
	f (word , count) = word ++ ": " ++ show count

-- main
main :: IO ()
main = getArgs >>= readFile . head >>= pure . process >>= putStrLn
