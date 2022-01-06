
-- QUESTÃO 18:
module Queue (Queue , empty , enqueue , dequeue ) where

import Prelude (Show, Bool(True, False), error)

import Maybe
import List

data Queue a = Q ([a],[a]) deriving Show

empty :: Queue a
empty = Q ([],[])

normalizador :: ([a],[a]) -> ([a],[a])
normalizador ([],ys) = (reverse ys, [])
normalizador (xs,ys) = (xs,ys)

enqueue :: Queue a -> a -> Queue a
enqueue (Q (xs,ys)) x = Q (normalizador (xs, x:ys))

dequeue :: Queue a -> Maybe (a, Queue a)
dequeue (Q (x:xs,ys))= Just (x, Q (normalizador (xs,ys)))
dequeue _ = Nothing
