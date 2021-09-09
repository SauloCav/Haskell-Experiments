module Lab3 where

import Prelude (Ord , ( <=) , Eq , (==) , Bool (True , False ))

import Bool
import Functions
import List

-- and with foldr
andFoldr :: [ Bool ] -> Bool
andFoldr xs = foldr (opAnd) True xs

-- or with foldr
orFoldr :: [ Bool ] -> Bool
orFoldr xs = foldr (opOr) False xs

-- map with foldr
mapFoldr :: (a -> b) -> [a] -> [b]
mapFoldr f = foldr (\x ys -> f x : ys) []

-- iterate
iterate :: (a -> a) -> a -> [a]
iterate f x = x : iterate f (f x)

-- uncons
uncons :: [a] -> Maybe (a, [a])
uncons [] = Nothing
uncons (x:xs) = Just (x, xs)

--partitionEithers
partitionEithers = foldr (either left right) ([],[]) where
	left  x ~(l, r) = (x:l, r)
	right x ~(l, r) = (l, x:r)

-- group
group :: Eq a => [a] -> [[a]]
group [] = []
group (x:xs) = (x : takeWhile (== x) xs) : group (dropWhile (== x) xs)

-- groupby
groupBy :: (a -> a -> Bool) -> [a] -> [[a]]
groupBy f [] = []
groupBy f (x:xs) = (x : takeWhile (f x) xs) : groupBy f (dropWhile (f x) xs)

-- all
all :: (a -> Bool) -> [a] -> Bool
all _ [] = True
all f (x:xs) = cond (f x) (all f xs) False

-- any
any :: (a -> Bool) -> [a] -> Bool
any _ [] = False
any f (x:xs) = cond (f x) True (any f xs)

-- merge
merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge xs [] = xs
merge [] ys = ys
merge l@(x:xs) m@(y:ys) = cond (x <= y) (x : merge xs m) (y : merge l ys)

-- split
split :: [a] -> ([a], [a])
split [] = ([], [])
split [x] = ([x], [])
split l@(x:y:zs) = (x:xs, y:ys) where
	(xs, ys) = split zs

-- mergesort 
mergesort :: Ord a => [a] -> [a]
mergesort [] = []
mergesort [x] = [x]
mergesort xs = merge (mergesort ys) (mergesort zs)
   where (ys, zs) = split xs
