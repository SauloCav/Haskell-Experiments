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
1. Implement the group function:: Eq a => [a] -> [[a]], which takes a list xs and returns a list of lists, where each sublist is a maximal continuous subsequence of equal elements of xs For example, group [1, 1, 2, 2, 2, 3, 3, 1, 1, 1] == [[1, 1], [2, 2, 2], [3, 3], [1] , 1, 1]]. The span function can be of great help here.
2. Now, we generalize the group function to groupBy, making group equivalent to groupBy (==). Implement groupBy :: (a -> a -> Bool) -> [a] -> [[a]].
3. Implement the all and any functions, both with signature (a -> Bool) -> [a] -> Bool, which decide, respectively, whether all or some element of a list satisfies the predicate given as input. Note that they can be given as compositions of and, or and map.
4. Write the function merge :: Ord a => [a] -> [a] -> [a] which, given two sorted lists as input, returns an sorted list with all elements of the received lists.
5. Write the function split :: [a] -> ([a], [a]) which, given a list xs as input, returns two lists: the first contains the elements of the odd positions of xs, and the second the elements of the even positions of xs. Here, we are assuming that the head of a list is at position 1.
6. Now, using merge and split, implemented earlier, develop the function mergesort :: Ord a => [a] -> [a].

<strong>Lab 04:</strong></br>

<strong>Lab 05:</strong></br>

<strong>Lab 06:</strong></br>

<strong>Lab 07:</strong></br>

<strong>Lab 08:</strong></br>

<strong>Lab 09:</strong></br>

<strong>Lab 10:</strong></br>

<strong>Lab 11:</strong></br></br>

<strong>Trab 01:</strong></br>
Problem I:</br>
A credit agency issues credit cards, each identified by a sequence of ten digits: the first eight are significant and the last two are verifiers. The two check digits represent the sum of the first eight digits.</br>
Write an addSum function that, given an eight-digit string, adds the two check digits to its end. You will need to transform each digit of the input string into an integer (it might be interesting to set getDigit :: Char -> Int, with the help of read), and then add them up and transform the result into a string ( using show is very useful).</br>
Write a valid function that, given a ten-digit string, checks whether it is a valid card identifier. This is quite simple when using the take function.</br>

Problem II:</br>
The first part of this problem, which will be useful for the second, is to implement the function until :: (a -> Bool) -> (a -> a) -> a -> a. The until function takes two functions: the first is a p predicate, and the second is a f function that transforms elements of type a. In addition, it receives an element x of type a. If x satisfies the predicate p, then until returns x. Otherwise, until recursively tests the predicate p for f x. It is quite simple to implement until with the help of iterate, proposed in Exercise 10.</br>
To implement goodEnough, determine whether the absolute value of y*y is close enough to x. We suggest a precision of six decimal places. To implement improve, it may be useful to search for some formula based on Newton's method (or on the secant method).</br>

Problem III:</br>
The inductive definition of natural numbers says that there is a first natural number, say zero, and that each of the others is obtained by applying a certain injection function to some natural. This function is called a successor, and zero is a successor of no natural. This is enough to determine that the natural numbers form an infinite set.</br>
Make Nat an instance of the Eq class (just implement (==)). Make Nat an instance of the Ord class (just implement (<=)). Write the functions natToInt :: Nat -> Int and intToNat :: Int -> Nat and check if the comparators are working correctly.</br>

*(Some labs are incomplete)*
