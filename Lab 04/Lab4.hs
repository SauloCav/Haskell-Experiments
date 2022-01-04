module Main where

import Prelude (Eq , (==) , (/=) , 
	Int , (+) , Char ,
	IO , readFile , putStrLn , show ,
	(>>=), pure )

import Data.Char (toLower)

import Bool
import Functions
import List
import Maybe

import qualified BSTree as BST

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
	makeOutput = concat . intercalate "\n" . map f . BST.inOrder
	f (word , count) = word ++ ": " ++ show count

-- main
main :: IO ()
main = readFile "heyjude.txt" >>= pure . process >>= putStrLn

-- Extra Questions:

{-
-- breadth
breadth :: BSTree k v -> [(k, v)]
breadth tr = bst [tr] where
    bst [] = []
    bst xs = map keyval xs ++ bst (concat (map lr xs))
    keyval (Branch a _ _) = a
    lr (Branch _ Empty Empty) = []
    lr (Branch _ Empty b)     = [b]
    lr (Branch _ a Empty)     = [a]
    lr (Branch _ a b)         = [a,b]

-- leaves
leaves :: BSTree k v -> Int
leaves Empty = 0
leaves (Branch _ Empty Empty) = 1
leaves (Branch _ lt rt) = leaves lt + leaves rt

-- inOrder
inOrder :: BSTree k v -> [(k, v)]
inOrder Empty = []
inOrder (Branch keyval lt rt) = inOrder lt ++ [keyval] ++ inOrder rt

-- preOrder
preOrder :: BSTree k v -> [(k, v)]
preOrder Empty = []
preOrder (Branch keyval lt rt) = [keyval] ++ preOrder lt ++ preOrder rt

-- postOrder
postOrder :: BSTree k v -> [(k, v)]
postOrder Empty = []
postOrder (Branch keyval lt rt) = postOrder lt ++ postOrder rt ++ [keyval]
-}
