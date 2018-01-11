module Glue1 where

-- Translated into Haskell from Hughes examples which were written in
-- Miranda language (David Turner, U Kent, ca 1986)

-- Similar functions for sum and product of numbers
-- Both use a recursive definition that iterates over the
-- collection (list in this case) term by term

mysum :: 
  Num a =>
  [a] -> 
  a
mysum [] = 0
mysum (n : rest) = n + mysum rest

myprod :: 
  Num a => 
  [a] -> 
  a
myprod [] = 1
myprod (n : rest) = n * myprod rest

{-- 
Abstract an iterative function g to implement functions like
mysum and myprod.

Want to be able to supply "+" or "*" generically as well
as "0" or "1" respectively without copying code. Modularity!

So let's provide these functions and valuse as parameters.
--}

gsum :: 
  Num a => 
  [a] -> 
  a
gsum [] = 0
gsum as = g (+) 0 as

{-- 
gsum requires a general recursive function g
that substitutes a function for (:) and a
value for []
--}
g :: 
  (a -> b -> b) -> 
  b -> 
  [a] -> 
  b
g _ b [] = b
g f b (x : xs) = f x ((g f b) xs)

-- g is conventionally called "foldr" 
myfoldr = g

-- These are substituted for "[]" and "(:)" respectively
-- in the two patterns that implement g

-- Other useful operations can be built
-- from foldr such as:

-- Product of a numeric list
fprod as = myfoldr (*) 1 as

-- Concatenate lists
fconcat as bs = myfoldr (:) as bs

-- Is there at least one True in a list of Booleans?
anytrue :: 
  [Bool] -> 
  Bool
anytrue as = myfoldr (||) False as

-- Are all Booleans True in the list?
alltrue :: 
  [Bool] -> 
  Bool
alltrue as = myfoldr (&&) True as