module Main where

import Prelude (Eq , (==) , (/=) , 
	Int , Float , (+) , (-) , (<=) , Char , Ord , 
	IO , readFile , putStrLn , show ,
	(>>=), pure , flip , snd )

import Data.Char (toLower)
import Data.Ord (compare)
import Data.List (sortBy)
import Data.Function (on)

import Bool
import Functions
import List
import Maybe

import qualified BSTree as BST

-- (!?)
(!?) :: [a] -> Int -> Maybe a
[] !? _ = Nothing
(x:_) !? 0 = Just(x)
(_:xs) !? k = xs !? (k - 1)

-- remove
removeList :: Eq a => a -> [a] -> [a]
removeList _ [] = []
removeList x (y:ys) = cond (x == y) (removeList x ys) (y : removeList x ys)

-- split
split :: Eq a => a -> [a] -> [[a]]
split _ [] = []
split x [y] = cond (x == y) [] [[y]]
split x ys = ps : split x qs where
    (ps, qs) = f ys
    f = span (/=x) . dropWhile (==x)

-- lines
lines :: [Char] -> [[Char]]
lines [] = []
lines xs = split '\n' xs

-- words
words :: [Char] -> [[Char]]
words [] = []
words xs = split ' ' xs

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
	makeOutput = concat . intercalate "\n" . map f . sortByFunc . BST.inOrder
	f (word , count) = word ++ ": " ++ show count

-- sortBy
sortByFunc :: Ord b => [(a, b)] -> [(a, b)]
sortByFunc = sortBy (flip compare `on` snd)

-- main
main :: IO ()
main = readFile "heyjude.txt" >>= pure . process >>= putStrLn
