module Lab2 where

import Prelude (Eq , Fractional , (/))

import Bool
import Functions
import List
import Maybe

-- repeat
repeat :: a -> [a]
repeat x = xs where 
	xs = x : xs

-- insert
insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys)  = cond (x > y) (y:(insert x ys)) (x:y:ys) 

-- insertionSort
insertionSort :: Ord a => [a] -> [a]
insertionSort [] = []
insertionSort (x:xs) = insert x (insertionSort xs)

-- replicate
replicate :: Int -> a -> [a]
replicate n x = take n (repeat x)

-- inits
inits :: [a] -> [[a]]
inits [] = []
inits xs = init xs : inits (init xs)

-- tails
tails :: [a] -> [[a]]
tails [] = []
tails xs = tail xs : tails (tail xs)

-- cycle
cycle :: [a] -> [a]
cycle [] = []
cycle xs = ys where
	ys = xs ++ ys

-- intercalate
intercalate :: a -> [a] -> [a]
intercalate _ [] = []
intercalate _ [y] = [y]
intercalate x (y:ys) = y : x : intercalate x ys

-- safeDiv
safeDiv :: (Eq a, Fractional a) => a -> a -> Maybe a
safeDiv _ 0 = Nothing
safeDiv x y = (Just (x/y))

-- find
find :: (a -> Bool) -> [a] -> Maybe a
find _ [] = Nothing
find p (x:xs) = cond (p x) (Just x) (find p xs)
