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
For this lab, we are going to use the auxiliary file heyjude.txt, which contains the lyrics of that song. As you may have noticed, the Lab4.hs file contains a module called Main. This indicates that we are going to create a Lab4 executable.</br>
The following activities should be a guide for developing a program that prints the word occurrence count in the heyjude.txt file.
1. Write the function remove :: Eq a => a -> [a] -> [a], which removes all occurrences of a certain element in a list. Note that remove can be implemented as a filter call.
2. Write the function split :: Eq a => a -> [a] -> [[a]] which, given an element x and a list ys, returns the sublists of ys between the occurrences of x. For example, split 0 [0, 1, 2, 0, 2, 5, 7, 0, 0, 0, 3, 0] == [[1, 2], [2, 5, 7], [3] ]. The span and dropWhile functions are very useful here.
3. Use the split function to write the lines and words functions, both with signature [Char] -> [[Char]]. The lines (words) function must partition a string into substrings that represent its lines (words). Remember that lines are separated by '\n' and words by ' '.
4. Write the function count :: [[Char]] -> BST.BSTree [Char] Int which, given a list of strings, returns a binary search tree where the keys are these strings and each one is valued by the number of times that occurs in the list. The foldr, BST.empty, BST.contains, BST.insert and BST.update functions are very useful for this.
5. Let's develop the process :: [Char] -> [Char] function, which joins all the parts of our program. Essentially, process will clean the input string, removing unwanted characters, count the occurrence of words and then prepare the output of the program, which is its return.
Write implementations for clean and countWords. The clean function must remove the characters ',', '(', ')', '?' and '!', and this can be done with a composition of removes. The countWords function must build the tree with the word occurrence count, and this can be expressed as a composition of the lines, words, map, concat and count functions.</br>
6. With all the functions developed, we are ready to finalize our program. Now, just compile Lab4.hs and check the executable output.

<strong>Lab 05:</strong></br>
Let's create a program that instead of printing the words in alphabetical order, we will print them in descending order of frequency, ie, the words with the highest number of occurrences will be printed first.</br>
For that, it is necessary to create an auxiliary function sortBy, which sorts a list according to a comparator, also given as input.

<strong>Lab 06:</strong></br>
Let's work with graphs. In particular, we are going to develop a program that solves the Celebrity Problem, a classic of program marathons.
Given a graph G = (V, E), we say that a vertex v ∈ V is a celebrity if every other vertex “knows” v and v “knows” nobody. Note that a graph has at most one celebrity. Here, we are using “u knows v” to indicate the existence of the edge (u, v) ∈ E.</br>
However, the g1.txt file contains the encoding of a graph, rather than arbitrary content. Its first line contains an integer, indicating the number of vertices. The other lines contain exactly two integers, indicating the ends of the edges.</br>
Let's use a very simple solution to the problem. As a graph has at most one celebrity, at first we want to find a celebrity candidate vertex. This can be done with a stack, and lists fulfill that role. We put all the vertices in a stack. If there are at least two vertices in the stack, say u and v, we check whether the edge (u, v) exists: if it does, u “knows” someone and cannot be a celebrity; otherwise, v is not “known” by another vertex and cannot be a celebrity. In both cases, we eliminate one vertex and the other goes back onto the stack. When we have a single vertex in the stack, that will be our candidate. We need to return the candidate inside a Maybe, so we can handle the case of the empty stack (list).</br>
In this definition, maybe saves us from explicitly handling the Maybe cases. The value cond1 indicates whether all other vertices “know” the candidate, while cond2 indicates whether the candidate “knows” some other vertex. The and, or, zipWith, G.hasEdge, repeat and remove functions are useful to define them.</br>
Here, the executable should already be ready. Test it out by modifying the g1.txt content to do so. Once you are sure of the behavior of the program, change it so that the celebrity (if there is one) is displayed as output.</br>

<strong>Lab 07:</strong></br>
Based on the structure defined in Heap.hs, create a structure to represent a maximum priority queue. Copy the contents of Heap.hs to MaxHeap.hs. In addition to renaming the file module accordingly, note that only one function of MaxHeap.hs needs to be changed.</br>
Now that we have implementations for minimum and maximum priority queues, let's leverage them and create a medium priority queue. The purpose of such a data structure is to allow constant-time access to the median of a set of elements, even if this set undergoes changes. For simplicity, we consider that, given a list xs of n elements, its median is the d n 2 and - th element of an ordered version of xs.</br>
Given an initial list xs of n elements of type (k, v), with k sortable, let's create a median algorithm :: Ord k => [(k, v)] -> Maybe (k, v), which finds the median of xs (according to k) in linear time, in the average case. The algorithm that median implements is quickselect, inspired by the same ideas as quicksort. To implement it, filter is quite useful.</br>
Once the median of xs, say m, is determined, we divide xs into two lists: that of elements less than or equal to m (ps) and that of elements greater than m (qs). Finally, we create a maximum (minimum) priority queue with the elements of ps (qs).</br>
After all that, we get two priority queues: the maximum groups the elements with a priority lower than or equal to the median; the minimum groups the elements with a priority higher than the median. Note that the difference between the number of elements in each priority queue is at most one: if n is even, the two heaps have the same number of elements; if n is odd, the maximum heap has exactly one element more than the minimum heap.</br>
The main idea of ​​this data structure lies in the fact that, when inserting or removing exactly one element from the represented set, either the “successor” or the “predecessor” of the median becomes the new median. The “predecessor” (“successor”) is indicated as the highest priority element of the maximum (minimum) heap.</br>
When we want to take the median, we always choose the highest priority element from the heap with the most elements. In case of a tie, we prefer the highest priority element of the maximum heap. Here, it is clear that it is necessary to store, in addition to the heaps, the number of elements in each one.</br>
When we insert an element x, we insert it according to the relationship between x and the current median m: if x has more priority than m, we insert x in the minimum heap; otherwise, we insert x into the maximum heap.</br>
Whenever a change is made to the data structure, it is necessary to rebalance the heaps if one has at least two elements more than the other. This is done by removing the highest priority element from the heap with the most elements, and inserting it into the other heap. The number of times this operation must be performed can be controlled using recursion.</br>
It is expected that the fromList, lookup, insert and pop operations will be implemented for this data structure. Note that fromList fails if it receives an empty list. In addition, the auxiliary function rebalance must be called whenever a change is made.</br>
With the structure implemented, write a program to test it. We can work with elements of type (Int, ()).</br>One idea would be to receive a file with two lines, each containing integers separated by a space. The initial structure is constructed from the braces on the first line. After that, the elements of the second line are inserted one at a time. With each modification of the structure, the current median must be printed on the screen.</br>

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
