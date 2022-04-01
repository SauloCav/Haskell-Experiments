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
In this lab, we will exercise a basic interaction with the operating system, which consists of handling command line arguments. Let's develop a series of elementary programs, starting with program1.</br>
Basically, program1 takes the argument list and prints it to the terminal. To compile, we add.</br>
We didn't write the explicit signature of main, as it clearly has the same signature as program1. Try passing arguments to the Lab8 executable. Now, let's develop an analog of the cat command, which prints the contents of a text file to the terminal.</br>
With the use of head, it is quite simple to handle a single argument passed from the command line. Make the appropriate change in main and test the new program. Note that it ignores all but the first argument passed to it. Also note that it throws exceptions if it takes no arguments (because of head), or if its first argument is not a valid file (because of readFile). This indicates that there must be a better way to handle arguments.</br>
As your first task, write program3, which prints the contents of a text file passed as an argument, but first sorts its lines. The lines, sortBy, intercalate and concat functions are useful for this. Organizing them by composition can be a good idea.</br>
Check the writeFile signature on ghci, after all, it's the first time we've seen it. The treatArgs function handles arguments using two cases: in the first, it is clear that we expect two arguments, to read the contents of the from file and write it to the to file; the second case handles any other number of arguments, informing the user about the correct use of the program. Try copying the contents of heyjude.txt to teste.txt. After that, try passing several numbers of arguments. Since writeFile erases the contents of the file before writing its second argument, it is not interesting that to be the name of an existing file.</br>
Let's go back to program2. We said that program2 is analogous to the cat command. However, cat and program2 behave differently when not taking arguments.</br>
After checking this, your second task is to write program5, which should behave exactly like cat, with either zero or one arguments. We may have already noticed that cat reads its keyboard input when it has no arguments. In Haskell, getContents does just that, that is, it returns an “infinite” string of things that are typed on the keyboard. For this program, treatArgs must handle cases of zero and one arguments, and invalidate all other cases.</br>
In our third task, we are going to modify the content of Lab4.hs, which was developed in Subsection 4.4. Instead of treating only the contents of the heyjude.txt file, our modified program must receive exactly one argument, which is the name of the file to be treated.</br>
Finally, the fourth task is to develop program6, which takes exactly two arguments: a string str and the name of a file file. This program should print only the lines of the file that contain str as a substring. The isInfixOf function, proposed in Exercise 2, can be used for this filtering. That done, add a case where program6 takes exactly one argument, and prints only the lines typed on the keyboard that have str as a substring. We have implemented a (very) simplified version of the grep command. We can even use program6 in combination with the operating system's pipe.</br>

<strong>Lab 09:</strong></br>
Let's develop a program that “registers” a password. For verification reasons, the program asks for it to be typed twice and, as long as there is a discrepancy, it asks again.</br>
The first thing we need is a function ask :: [Char] -> IO [Char], which prints its argument to the screen and returns a line read from the keyboard, inside IO. To construct ask, the putStrLn, getLine and (*>) functions are useful.</br>
With ask in hand, let's build getPasswd :: IO([Char], [Char]), an action that returns a pair of strings in IO. The idea here is not that complicated: we need to build a pair, but within IO. The operator (,) constructs simple pairs, and we can use it to construct a pair in IO, since IO is an instance of Functor and Applicative. We know that (,) x y constructs a pair of type (a, b), since x :: a and y :: b. Case x :: IO a and y :: IO b, how could we use (,), (<$>) and (<*>) to construct IO (a, b)? To answer the question, just make x and y two ask calls, with strings that tell the user if it is the first (x) or second (y) time they are typing the password.</br>
We have implemented getPasswd, but we still need to validate that the two strings entered are the same. We do this in validPasswd, a recursive action that only terminates upon receiving two identical strings. Its implementation is given below.</br>
Now that we know how to get a valid password, implement main::IO() and test your program. But the lab isn't over yet.</br>
In Data.Char, there are some very useful predicates, which test whether a Char is a certain type of character, such as lowercase, uppercase, or digit. We say that a password is strong if it has at least eight characters and there is, among them, a lowercase letter, an uppercase letter and a digit. Write a function isStrong ::[Char] -> Bool, which determines whether a password is strong.</br>
Once isStrong is implemented, write the action strongPasswd :: IO [Char], which uses validPasswd to obtain valid passwords and returns, within IO, the first one that is strong. The definition of validPasswd is a good model for strongPasswd.</br>
Adapt your main and test your program. Now the lab is over.</br>

<strong>Lab 10:</strong></br>
In this lab, we are going to solve the longest increasing subsequence problem. Given a sequence of naturals, we would like to find the largest increasing subsequence of that sequence. For example, given the sequence 10, 22, 9, 33, 21, 50, 41, 60, 80, its longest increasing subsequence is 10, 22, 33, 41, 60, 80.</br>
First, develop maximum ::Ord a => [a] -> Maybe a, which returns the largest element of a list if it is not empty. Just use foldl and (<=). However, we will need to make use of a generic version of maximum. To do so, implement the maximalBy :: (a -> a -> Bool) -> [a] -> Maybe a function, such that maximalBy (>=) is equivalent to maximum.</br>
Now, let's create a naive solution to the problem at hand. Given a sequence of natural n x0, x1, . . . , xn−1, we create the following note ̧c ̃ao: si represents the largest increasing subsequence starting with xi , for 0 ≤ i ≤ n − 1.</br>
We can define s in terms of itself: clearly, sn−1 is a unitary sequence containing xn−1; for 0 ≤ i ≤ n − 2, si starts with xi , and can follow with the elements of sj , i < j ≤ n − 1, provided that xi ≤ xj . Certainly, we define si using, among all possible sj, the one that represents the largest subsequence. Finally, it is easy to choose the largest increasing subsequence among si , 0 ≤ i ≤ k − 1. This solution can be implemented as follows.</br>
At first, the function s seems to receive more arguments than necessary, after all, it is indexed only by 0 ≤ i ≤ n − 1. However, receiving the list as the second argument allows us to treat the case referring to itself , for some 0 < i ≤ n − 1, with drop.</br>
Another interesting thing to note is candidates. Note that candidates seem to be dealing with subsequences from lists other than xs. Not really, but the way candidates behave, the indices passed to s can refer to positions in suffixes of xs, and thus cannot be interpreted absolutely, like the indices of s.</br>
Well, the lis implementation presented is correct, but extremely inefficient. And I need to use memo and fix to create a cache for s. However, there is an obstacle: memo expects to receive a function Int -> b, and this is not the signature of s.</br>
The ultimate goal of this lab is to rewrite lis so that s has signature Int -> [a], and then create a cache for s.</br>

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
