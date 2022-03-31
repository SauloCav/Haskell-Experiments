module Trab1 where

import Prelude (
    Eq, Ord, Num, Int, read, show, Char, String, Bool(True, False), otherwise,
    (+), (-), (>>=), (*), (<=), (==), (/=), (>), (<), (>=), error,
    Fractional, Functor(fmap), Applicative(pure, (<*>)),
    seq)

import Data.Char(intToDigit)
import Bool
import Functions
import List
import Maybe

-- Problem I

sumFinalDigits :: [Char] -> Int
sumFinalDigits [] = 0
sumFinalDigits (x:xs) = (getDigit [x]) + sumFinalDigits xs

getDigit :: [Char] -> Int
getDigit = read

getChar :: Int -> [Char]
getChar = show

addSum :: [Char] -> [Char]
addSum [] = []
addSum (xs) = xs ++ getChar (sumFinalDigits xs)

valid :: [Char] -> Bool
valid [] = False
valid (xs) = cond (opAnd (isLongEnough xs) (sumIsCorrect xs)) (True) (False) 

isLongEnough :: [Char] -> Bool
isLongEnough (xs) = cond (length xs == 10) (True) (False)

sumIsCorrect :: [Char] -> Bool
sumIsCorrect (xs) = cond (sumFinalDigits (take 8 xs) == getDigit (drop 8 xs)) (True) (False)


-- Problem II

until :: (a -> Bool) -> (a -> a) -> a -> a
until pre f x | pre x = x
              | otherwise = until pre f (f x)

sqrt :: Floating a => a -> a
sqrt x = until goodEnough improve x where
	goodEnough y = cond ((y*y) == x) (True) (False)
	improve y = imp 1 y where
		imp z y = if abs (z * z - y) < epsilon
			      then z
			      else imp ((z + (y/z))/ 2) y
	    epsilon = 0.00001

-- Problem III

data Nat = Zero | Suc Nat

instance Eq Nat where
	Zero == Zero = True
	(Suc m) == (Suc n) = m == n
	_ == _ = False

instance Ord Nat where
	(<=) Zero _ = True
	(<=) (Suc _) Zero = False
	(<=) (Suc n) (Suc m) = n <= m

natToInt :: Nat -> Int
natToInt Zero = 0
natToInt (Suc n) = 1 + (natToInt n)

intToNat :: Int -> Nat
intToNat 0 = Zero
intToNat n | (n < 0) = error "Invalid Number"
           | otherwise = Suc $ intToNat (n - 1)
