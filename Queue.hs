
-- QUESTÃO 17:
-- Utilizar mergeAll ao invés de foldl possibilita uma maior eficiência 
-- principalmente pela sua forma de fazer merge de forma binária
-- (fazendo merge entre as atuais duas primeiras heaps). O emparelhamento
-- das heaps permite que a função pop seja implementada com um argumento de 
-- complexidade amortizada (seu custo médio é O(log n)). Como ao utilizar foldl  
-- a função merge é usada de forma a combinar os elementos de modo não emparelhado, 
-- o custo médio da função pop seria bem maior. 

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
