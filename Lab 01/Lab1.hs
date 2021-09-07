module Lab1 where

import Prelude (Eq , (+) , (*) , Int )
import List (foldl , foldr )

-- Lab1

-- And (&&)
opAnd :: Bool -> Bool -> Bool
opAnd False _ = False
opAnd _ False = False
opAnd True True = True

-- Or (||)
opOr :: Bool -> Bool -> Bool
opOr True _ = True
opOr _ True = True
opOr False False = False

-- isInfixOf
isInfixOf :: Eq a => [a] -> [a] -> Bool
isInfixOf [] _ = True
isInfixOf (_:_) [] = False
isInfixOf l@(x:xs) m@(y:ys) = cond (isPrefixOf l m) (isInfixOf [] ys) (isInfixOf l ys)

-- isSubsequenceOf
isSubsequenceOf :: Eq a => [a] -> [a] -> Bool
isSubsequenceOf [] _ = True
isSubsequenceOf (_:_) [] = False
isSubsequenceOf l@(x:xs) (y:ys) = cond (x == y) (isSubsequenceOf xs ys) (isSubsequenceOf l ys)

-- length with foldl
length :: [a] -> Int
length = foldl f 0 where
    f acc _ = acc + 1

-- (++) with foldr
(++) :: [a] -> [a] -> [a]
(++) xs ys = foldr (:) ys xs

-- concat with foldr
concat :: [[a]] -> [a]
concat xs = foldr (++) [] xs

-- reverse with foldl
reverse :: [a] -> [a]
reverse xs = foldl (\acc x->x : acc) [] xs

-- squares
squares :: [Int] -> [Int]
squares [] = []
squares (x:xs) = x*x : squares xs

-- count
count :: Eq a => a -> [a] -> Int
count _ [] = 0
count y (x:xs) = cond (x == y) (1 + count y xs) (count y xs)