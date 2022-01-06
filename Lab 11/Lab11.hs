module Lab11 where

import Prelude (
    Eq, Ord, Num, Int, read, show, Char, String, Bool(True, False), otherwise, IO, (<$>),
    (+), (-), (>>=), (*), (<=), (==), (/=), (>), (<), (>=), error, pure, putStrLn,
    Fractional, Functor(fmap), Applicative(pure, (<*>)),
    seq)

import Control.Monad
import Control.Monad(foldM)
import Bool
import Functions
import List

type State = Int
type Transition = (State, Char, State)
data NFA = NFA [State] State [Transition] [State]

-- Quest 42
-- instance Monad Maybe where
-- return = Just
-- Nothing >>= f = Nothing
-- (Just x) >>= f = f x
-- fail _ = Nothing

-- Quest 43
-- join :: Monad m => m (m a) -> m a
-- join m = (m >>= id)

-- Quest 44
-- (>>=) :: (Monad m) => m a -> (a -> m b) -> m b
-- xs >>= f = join (fmap f xs) 

-- Quest 45
-- foldM :: Monad m => (b -> a -> m b) -> b -> [a] -> m b
-- foldM _ b [] = return b
-- foldM f b (x:xs) = f b x >>= \fbx -> foldM f fbx xs

-- Quest 46
-- subsetsFoldM :: [a] -> [[a]]
-- subsetsFoldM [] = [[]]
-- subsetsFoldM (x:xs) = foldM (x:) ++ (subsets xs)

-- Quest 47
-- mapM :: Monad m => (a -> m b) -> [a] -> m [b]
-- mapM f xs = sequenceA (map f xs)

-- Quest 48
-- sequenceA_ :: Applicative f => [f a] -> f ()
-- sequenceA_ (x:xs) = (:) <$> x <*> sequenceA_ xs

-- Quest 49
-- mapM_ :: Monad m => (a -> m b) -> [a] -> m ()
-- mapM_ f xs = sequenceA_ (map f xs)

nfa :: [State] -> State -> [Transition] -> [State] -> NFA
nfa states s trs finals = NFA states s trs finals

states :: NFA -> [State]
states (NFA states _ _ _) = states

currentState :: NFA -> State
currentState (NFA _ s _ _) = s

transitions :: NFA -> [Transition]
transitions (NFA _ _ trs _) = trs

finalStates :: NFA -> [State]
finalStates (NFA _ _ _ finals ) = finals

transition :: NFA -> Char -> [NFA]
transition aut c = f <$> nextStates where
	validTransitions = filter valid (transitions aut)
	valid (st , c', _) = and [st == (currentState aut), c' == c]
	nextStates = thd <$> validTransitions
	thd (_, _, z) = z
	f st = nfa (states aut) st (transitions aut) (finalStates aut)

isAccepting :: NFA -> Bool
isAccepting nfa = cond (isInList (currentState nfa) (finalStates nfa)) (True) (False) 

isInList :: (Eq a) => a -> [a] -> Bool
isInList x [] = False
isInList x (y:ys) | x == y = True
                  | otherwise = isInList x ys

run :: NFA -> [Char] -> Bool
run nfa xs = cond (or (map isAccepting fnfa)) (True) (False) where
	fnfa = foldM transition nfa xs

-- C:\Users\saulo\OneDrive\Área de Trabalho\faculnás 4\prog func\laboratorios\haskell-experiments
