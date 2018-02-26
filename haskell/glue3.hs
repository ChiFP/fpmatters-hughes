module Glue3 where

-- Sec. 3 to p. 7

-- What about applying a simple function to each element of a list
-- creating a new list of the transformed values?

-- Let's double each element of a numerical list:
doubleandcons :: 
  Num n => 
  n -> 
  [n] -> 
  [n]
doubleandcons n ns = (2*n) : ns

-- A function to double each element in a numerical list making a new list
doubleall ns = foldr doubleandcons [] ns

-- As usual, let's pull out the specific doubling function 
-- as a parameter and provide a general function to be provided:
fandcons :: 
  Num n => 
  (n -> n) -> 
  n -> 
  [n] -> 
  [n]
fandcons f n ns = f n : ns

-- Apply f to each element
fall1 f ns = foldr (fandcons f) [] ns 

sqfour1 = fall1 (\m->m*m) [1..4]

{-
Using functional composition
:t (.)
(.) :: (b -> c) -> (a -> b) -> a -> c
-}
fall2 f ns = foldr ((:).f) [] ns

sqfour2 = fall2 (\m->m*m) [1..4]

-- But fall2 is just "map": apply a function within a list to each element
-- You just have to align the type of f to the type of the list elements
mymap f ns = foldr ((:).f) [] ns

-- One last refactoring of sum - add up all elements of a matrix
-- represented as a list of lists:

sumlist ls = foldr (+) 0 ls
matrixsum xs = sumlist (mymap sumlist xs)

fortyfive = matrixsum [[1..3],[4..6],[7..9]]


