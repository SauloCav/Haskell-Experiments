# Haskell-Experiments

<strong>Lab 01:</strong></br>
1. Rewrite the length, (++), concat and reverse functions as calls to foldl or foldr (whichever seems more appropriate).
2. Write the squares function which, given a list of integers, returns a list containing the square of those integers.
3. Write the function count :: Eq a => a -> [a] -> Int, which returns the number of occurrences of an element in a list.

<strong>Lab 02:</strong></br>
1. Write the function repeat :: a -> [a] which, given an element x of type a, returns an infinite list whose elements are all equal to x.
2. Write the function cycle :: [a] -> [a] which, given a list xs as input, returns an infinite list formed by continuously repeating the elements of xs, in order. We want cycle []==[].
3. Write the intercalate function :: a -> [a] -> [a] which, given an element x and a list ys, returns a list consisting of the elements of ys interleaved by x. We want you to merge [] == [] and merge [y] == [y], because in these cases ys has no elements to be merged by x.
4. Write the function safeDiv :: (Eq a, Fractional a) => a -> a -> Maybe the one that does divisions safely, ie represents division by zero as a failure.
5. Write an implementation for find :: (a -> Bool) -> [a] -> Maybe a. Note that it is possible to implement find using compositions from dropWhile, safeHead and not. This is just a suggestion. Implement as you see fit.

<strong>Lab 03:</strong></br>


<strong>Lab 04:</strong></br>

<strong>Lab 05:</strong></br>

<strong>Lab 06:</strong></br>

<strong>Lab 07:</strong></br>

<strong>Lab 08:</strong></br>

<strong>Lab 09:</strong></br>

<strong>Lab 10:</strong></br>

<strong>Lab 11:</strong></br>

*Some labs are incomplete*
