module Main where

import Prelude (Eq , (==) , (/=) , 
	Int , (+) , Char ,
	IO , readFile , putStrLn , show ,
	(>>=), pure )

import Bool
import Functions
import List

import qualified BSTree as BST

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

--lines
lines :: [Char] -> [[Char]]
lines [] = []
lines xs = split '\n' xs

--words
words :: [Char] -> [[Char]]
words [] = []
words xs = split ' ' xs

