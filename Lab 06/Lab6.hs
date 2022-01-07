module Main where

import Prelude (Char , Bool ( False ), pure , (>>=), (==),
				IO , readFile , putStrLn , read , show , undefined )

import Bool
import Functions
import List
import Maybe

import qualified Graph as G


-- EU TENTEI!


main :: IO ()
main = readFile "g1.txt" >>= pure . process >>= putStrLn

process :: [Char] -> [Char]
process = show . hasCelebrity . buildGraph . lines where

buildGraph :: [[Char]] -> G.Graph
buildGraph [] = G.empty
buildGraph (n:es) = foldr f gn es' where
	es' = map words es
	gn = G.edgeless (read n)
	f e g = G.addEdge g u v where
		(u:v:_) = map read e

hasCelebrity :: G.Graph -> Bool
hasCelebrity g = verify candidate where
	verify = maybe False f where
		f c = and [cond1 , not cond2 ] where
			cond1 = foldl f m where
				m = G.vertices g
				f m@(x:xs) = cond (G.neighbors x == candidate) (f xs) (False)
			cond2 = cond (G.neighbors candidate == [])
	candidate = foldl f h where
		h = G.vertices g
		f h@(x:xs) = cond (G.neighbors x == []) (x) (f xs)

-- C:\Users\saulo\OneDrive\Área de Trabalho\faculnás 4\prog func\laboratorios\haskell-experiments
