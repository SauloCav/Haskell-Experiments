module List where

import Prelude (
    Eq, Num, Int, Char, Bool(True, False), Ord,
    (+), (-), (*), (<=), (==), (/=), error,
    Functor(fmap), Applicative(pure, (<*>)),
    seq)

import Control.Applicative (Alternative(empty, (<|>)))
--import Control.Parallel

import Bool
import Functions
import Maybe

-- Aula 1

-- And (&&)
opAnd :: Bool -> Bool -> Bool
opAnd False _ = False
opAnd _ False = False
opAnd True True = True

length :: [a] -> Int
length = foldl f 0 where
    f acc _ = acc + 1

null :: [a] -> Bool
null [] = True
null (_:_) = False

head :: [a] -> a
head [] = error "head: empty list"
head (x:_) = x

tail :: [a] -> [a]
tail [] = error "tail: empty list"
tail (_:xs) = xs

safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x

safeTail :: [a] -> Maybe [a]
safeTail [] = Nothing
safeTail (_:xs) = Just xs

last :: [a] -> a
last (x:[]) = x
last (_:xs) = last xs

init :: [a] -> [a]
init [] = error "init: empty list"
init (_:[]) = []
init (x:xs) = x : init xs

(++) :: [a] -> [a] -> [a]
[] ++ ys = ys
(x:xs) ++ ys = x : xs ++ ys

concat :: [[a]] -> [a]
concat [] = []
concat (xs:xss) = xs ++ concat xss

reverse :: [a] -> [a]
reverse xs = f xs [] where
    f [] acc = acc
    f (x:xs) acc = f xs (x:acc)

-- Aula 2

take :: Int -> [a] -> [a]
take 0 _ = []
take _ [] = []
take n (x:xs) = x : take (n - 1) xs

drop :: Int -> [a] -> [a]
drop _ [] = []
drop n xs = cond (n <= 0) xs (drop (n - 1) (tail xs))

splitAt :: Int -> [a] -> ([a], [a])
splitAt 0 xs = ([], xs)
splitAt _ [] = ([], [])
splitAt n (x:xs) = (x:ps, qs) where
    (ps, qs) = splitAt (n - 1) xs

isPrefixOf :: Eq a => [a] -> [a] -> Bool
isPrefixOf [] _ = True
isPrefixOf (_:_) [] = False
isPrefixOf (x:xs) (y:ys) = cond (x == y) (isPrefixOf xs ys) False 

zip :: [a] -> [b] -> [(a, b)]
zip = zipWith (,)

-- Aula 3

-- takeWhile esta definido mais a frente

dropWhile :: (a -> Bool) -> [a] -> [a]
dropWhile _ [] = []
dropWhile p xs = cond (p (head xs)) (dropWhile p (tail xs)) xs

span :: (a -> Bool) -> [a] -> ([a], [a])
span _ [] = ([], [])
span p l@(x:xs) = cond (p x) (x:ps, qs) ([], l) where
    (ps, qs) = span p xs

break :: (a -> Bool) -> [a] -> ([a], [a])
break p xs = span (not . p) xs

-- filter esta definido mais a frente

foldl :: (b -> a -> b) -> b -> [a] -> b
foldl _ acc [] = acc
foldl f acc (x:xs) = foldl f (f acc x) xs

foldr :: (a -> b -> b) -> b -> [a] -> b
foldr _ acc [] = acc
foldr f acc (x:xs) = f x (foldr f acc xs)

sum :: Num a => [a] -> a
sum = foldl (+) 0

prod :: Num a => [a] -> a
prod = foldl (*) 1

filter :: (a -> Bool) -> [a] -> [a]
filter p xs = foldr f [] xs where
    f x ys = cond (p x) (x:ys) ys

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

takeWhile :: (a -> Bool) -> [a] -> [a]
takeWhile p xs = foldr f [] xs where
    f x ys = cond (p x) (x:ys) []

(!!) :: [a] -> Int -> a
[] !! _ = error "(!!): empty list"
(x:_) !! 0 = x
(_:xs) !! k = xs !! (k - 1)

find :: (a -> Bool) -> [a] -> Maybe a
find p = safeHead . dropWhile (not . p)

intercalate :: a -> [a] -> [a]
intercalate _ [] = []
intercalate _ [y] = [y]
intercalate x (y:ys) = y : x : intercalate x ys

remove :: Eq a => a -> [a] -> [a]
remove x = filter (/=x)

repeat :: a -> [a]
repeat x = x : repeat x

-- mergesort 
mergesort :: Ord a => [a] -> [a]
mergesort [] = []
mergesort [x] = [x]
mergesort xs = merge (mergesort ys) (mergesort zs)
  where (ys, zs) = splitt xs

-- merge
merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge xs [] = xs
merge [] ys = ys
merge l@(x:xs) m@(y:ys) = cond (x <= y) (x : merge xs m) (y : merge l ys)

-- splitt
splitt :: [a] -> ([a], [a])
splitt [] = ([], [])
splitt [x] = ([x], [])
splitt l@(x:y:zs) = (x:xs, y:ys) where
 (xs, ys) = splitt zs

newtype ZipList a = ZL [a]

zipList :: [a] -> ZipList a
zipList xs = ZL xs

getZipList :: ZipList a -> [a]
getZipList (ZL xs) = xs

instance Functor ZipList where
    fmap f (ZL xs) = ZL (fmap f xs)

instance Applicative ZipList where
    pure = zipList . repeat
    (ZL fs) <*> (ZL xs) = ZL (zipWith ($) fs xs)

instance Alternative ZipList where
    empty = zipList empty
    (ZL xs) <|> (ZL ys) = ZL (xs <|> ys)

sortBy :: (a -> a -> Bool) -> [a] -> [a]
sortBy _ [] = []
sortBy _ [x] = [x]
sortBy cmp xs = merge (sortBy cmp ps) (sortBy cmp qs) where
    merge xs [] = xs
    merge [] ys = ys
    merge l1@(x:xs) l2@(y:ys) = cond (cmp x y) (x : merge xs l2) (y : merge l1 ys)
    (ps, qs) = split xs
    split [] = ([], [])
    split (x:xs) = (x:ns, ms) where
        (ms, ns) = split xs

iterate :: (a -> a) -> a -> [a]
iterate f x = x : iterate f (f x)

inits :: [a] -> [[a]]
inits [] = [[]]
inits (x:xs) = [] : map (x:) (inits xs)

tails :: [a] -> [[a]]
tails [] = [[]]
tails xs = xs : tails (tail xs)

foldl' :: (b -> a -> b) -> b -> [a] -> b
foldl' _ acc [] = acc
foldl' f acc (x:xs) = foldl' f $! (f acc x) $ xs

force :: [a] -> [a]
force [] = []
force l@(x:xs) = seq x (seq (force xs) l)

chunks :: Int -> [a] -> [[a]]
chunks _ [] = []
chunks k xs = ps : chunks k qs where
    (ps, qs) = splitAt k xs

-- cycle
cycle :: [a] -> [a]
cycle [] = []
cycle xs = ys where
    ys = xs ++ ys

{-

parChunks :: Int -> [a] -> [[a]]
parChunks k = parallel . chunks k where
    parallel [] = []
    parallel l@(xs:xss) = par (force xs) (pseq (parallel xss) l)


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