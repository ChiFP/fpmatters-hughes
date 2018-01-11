|| Miranda language (David Turner, U Kent, ca 1986)
|| It is a predecessor to Haskell, smaller but similar.
|| Some syntax and ideas were adapted by Haskell
|| from Miranda, so this will look familiar to many.

sq :: num -> num
sq n = n * n

sqrs = [ n * n | n <- [1..100] ]
sqrssq = [ sq n | n <- [1..100] ]

|| Hughes first example

mysum :: [num] -> num
mysum [] = 0
mysum (n : rest) = n + mysum rest

|| The recursive pattern
|| is called "foldr" 
|| It is parameterized by the operator (+) and
|| the starting value (0)

foldsum :: [num] -> num
foldsum [] = 0
foldsum a = foldr (+) 0 a

foldsumc = foldr (+) 0

|| Other familiar operations can be built
|| from foldr such as:

|| Product of a numeric list

prodc = foldr (*) 1

sevenfac = prodc [1..7]