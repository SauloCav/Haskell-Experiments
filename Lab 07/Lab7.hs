module Lab7 where

import Prelude (Char , Bool , Ord , Int , Fractional , otherwise , pure , (>>=),
	            (==), (+), (-), (/), (*), (<=), (/=), (>), (<), (>=),
				IO , readFile , putStrLn , read , show )

import Data.List

import Bool
import Functions
import Maybe

import qualified Heap as MIH
import qualified MaxHeap as MAH

data Heap k v = Empty
              | Heap (k, v) [Heap k v]

empty :: Heap k v
empty = Empty

median :: Ord k => [(k, v)] -> Maybe (k, v)
median [] = Nothing
median [x] = Just x
median [x,y] = Just (y)
median (x:xs) = median (init xs)

insert :: Ord k => Heap k v -> (k, v) -> Heap k v
insert h keyval = cond (keyval <= median h) (MAH.merge (Heap keyval []) h) (MIH.merge (Heap keyval []) h)

lookup :: Heap k v -> Maybe (k, v)
lookup Empty = Nothing
lookup (Heap keyval _) = Just keyval

mergeAll :: Ord k => [Heap k v] -> Heap k v
mergeAll [] = Empty
mergeAll [h] = h
mergeAll (h1:h2:hs) = merge (merge h1 h2) (mergeAll hs)

pop :: Ord k => Heap k v -> Heap k v
pop Empty = Empty
pop (Heap _ hs) = mergeAll hs

-- quickselect
-- quickselect :: Ord a => Int -> [a] -> a
-- quickselect k (x:xs) | k < l     = quickselect k ys
                     -- | k > l     = quickselect (k-l-1) zs
                     -- | k == l    = x where
                     	-- (ys, zs) = span (< x) xs
                     	-- l = length ys
