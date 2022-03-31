module BSTree (BSTree, empty,
               insert, update, remove, map,
               lookup, contains,
               maxKey, minKey,
               inOrder, preOrder) where

import Prelude  (Ord, Ordering(LT, EQ, GT), compare,
                 Eq, (==), Int, (+), (-), (/), (*), (==), (/=),
                 Bool(True, False),
                 Functor(fmap)
                )

import Bool
import Functions ((.))
import List ((++))
import Maybe

data BSTree k v = Empty
                | Branch (k, v) (BSTree k v) (BSTree k v)

------------------------------------------------------
foldl :: (b -> a -> b) -> b -> [a] -> b
foldl _ acc [] = acc
foldl f acc (x:xs) = foldl f (f acc x) xs
------------------------------------------------------
------------------------------------------------------
zip :: [a] -> [b] -> [(a, b)]
zip = zipWith (,)
------------------------------------------------------
------------------------------------------------------
zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith f [] _ = []
zipWith f _ [] = []
zipWith f (x:xs) (y:ys) = f x y : zipWith f xs ys
------------------------------------------------------
------------------------------------------------------
concat :: [[a]] -> [a]
concat [] = []
concat (xs:xss) = xs ++ concat xss
------------------------------------------------------
------------------------------------------------------
mapp :: (a -> b) -> [a] -> [b]
mapp f [] = []
mapp f (x:xs) = f x : mapp f xs
------------------------------------------------------

empty :: BSTree k v
empty = Empty

insert :: Ord k => BSTree k v -> (k, v) -> BSTree k v
insert Empty (key', val') = Branch (key', val') empty empty
insert bst@(Branch (key, val) ltree rtree) (key', val') =
    decide (compare key' key) where
        decide LT = Branch (key, val) ltree' rtree
        decide EQ = bst
        decide GT = Branch (key, val) ltree rtree'
        ltree' = insert ltree (key', val')
        rtree' = insert rtree (key', val')

lookup :: Ord k => BSTree k v -> k -> Maybe v
lookup Empty _ = Nothing
lookup (Branch (key, val) ltree rtree) key' =
    decide (compare key' key) where
        decide LT = lookup ltree key'
        decide EQ = Just val
        decide GT = lookup rtree key'

contains :: Ord k => BSTree k v -> k -> Bool
contains bst = isJust . lookup bst

update :: Ord k => BSTree k v -> k -> (v -> v) -> BSTree k v
update Empty _ _ = empty
update (Branch (key, val) ltree rtree) key' f =
    decide (compare key' key) where
        decide LT = Branch (key, val) ltree' rtree
        decide EQ = Branch (key, f val) ltree rtree
        decide GT = Branch (key, val) ltree rtree'
        ltree' = update ltree key' f
        rtree' = update rtree key' f

maxKey :: BSTree k v -> Maybe (k, v)
maxKey Empty = Nothing
maxKey (Branch keyval _ Empty) = Just keyval
maxKey (Branch _ _ rtree) = maxKey rtree

minKey :: BSTree k v -> Maybe (k, v)
minKey Empty = Nothing
minKey (Branch keyval Empty _) = Just keyval
minKey (Branch _ ltree _) = minKey ltree

remove :: Ord k => BSTree k v -> k -> BSTree k v
remove Empty _ = empty
remove bst@(Branch (key, val) ltree rtree) key' =
    decide (compare key' key) where
        decide LT = Branch (key, val) ltree' rtree
        decide GT = Branch (key, val) ltree rtree'
        decide EQ = removeRoot bst
        ltree' = remove ltree key'
        rtree' = remove rtree key'
        removeRoot Empty = Empty
        removeRoot (Branch _ lt Empty) = lt
        removeRoot (Branch _ Empty rt) = rt
        removeRoot (Branch _ lt rt) =
            Branch (keyMinR, valMinR) lt rt' where
                Just (keyMinR, valMinR) = minKey rt
                rt' = remove rt keyMinR

map :: (v1 -> v2) -> BSTree k v1 -> BSTree k v2
map _ Empty = empty
map f (Branch (key, val) ltree rtree) =
    Branch (key, f val) ltree' rtree' where
        ltree' = map f ltree
        rtree' = map f rtree

--inOrderr :: BSTree k v -> [(k, v)]
--inOrderr Empty = []
--inOrderr (Branch keyval lt rt) = inOrderr lt ++ (keyval : inOrderr rt)

instance (Eq k, Eq v) => Eq (BSTree k v) where
    Empty == Empty = True
    Empty == _ = False
    _ == Empty = False
    (Branch (key, val) ltree rtree) == (Branch (key', val') ltree' rtree') =
        and [key == key', val == val', ltree == ltree', rtree == rtree']

instance Functor (BSTree k) where
    fmap = map

-- breadth
breadth :: BSTree k v -> [(k, v)]
breadth tr = bst [tr] where
    bst [] = []
    bst xs = mapp keyval xs ++ bst (concat (mapp lr xs))
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
