module Lab10 where

import Prelude (
    Eq, Ord, Num, Int, read, show, Char, otherwise, String, Bool(True, False),
    (+), (-), (>>=), (*), (<=), (==), (/=), (>), (<), (>=), error, pure, (<$>),
    Fractional, Functor(fmap), Applicative(pure, (<*>)),
    seq)

import Bool
import Functions
import List
import Maybe

-- Quest 32
-- repeatFix :: a -> [a]
-- repeatFix a = fix (a:)

-- cycleFix :: [a] -> [a]
-- cycleFix [] = []
-- cycleFix (xs) = fix (xs++)

-- Quest 33
-- iterateFix :: (a -> a) -> a -> [a]
-- iterateFix f a = fix ((a:) . map f)

-- Quest 34
-- foreverFix :: Applicative f => f a -> f b
-- foreverFix x = fix (x*>)

-- Quest 35
-- rangeFix :: Int -> [Int]
-- rangeFix 0 = [0]
-- rangeFix x = fix ((x:) map f) where
	-- f = (1-)

-- Quest 36
-- f :: (Int -> Int ) -> Int -> Int
-- f _ 0 = 1
-- f rec n = n * rec (n - 1)

-- fact :: Int -> Int
-- fact x = fix $ f

maximum :: Ord a => [a] -> Maybe a
maximum [] = Nothing
maximum [x] = Just (x)
maximum (x:y:xs) = cond (x >= y) (maximum (x:xs)) (maximum (y:xs))

maximalBy :: (a -> a -> Bool) -> [a] -> Maybe a
maximalBy _ [] = Nothing
maximalBy _ [x] = Just (x)
maximalBy f (x:y:xs) = cond (f x y) (maximalBy f (x:xs)) (maximalBy f (y:xs))

lis :: Ord a => [a] -> [a]
lis [] = []
lis [x] = [x]
lis xs = fromMaybe [] (maximalBy cmp (s <$> [0..n - 1] <*> pure xs)) where
	n = length xs
	cmp ps qs = length ps >= length qs
	s x [] = []
	s x [y] = [y]
	s x (y:ys) = y : ms where
		candidates = fix $ filter ((y <=) . head) . memo $ s <$> [0..k - 1] <*> pure ys
		k = length ys
		ms = fromMaybe [] $ maximalBy cmp candidates
	s i ys = s 0 $ drop i ys
