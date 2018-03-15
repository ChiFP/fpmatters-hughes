module ProgGlue1 where

-- Explore uses of lazy evaluation to enable the
-- separation of loop termination from loop iteration

-- Sec. 4.1

{--

Use Newton's method for finding roots to compute 
the square root r of a number N (r^2 = N) to any
prescribed accuracy starting from some initial guess of r_(0).

Define f(r) to be the difference:

  f(r) = r^2 - N

which is non-zero when r's value is not the square root of N.

Expand f(r) in a Taylor series and set its value 
to the desired result 0. To first order:

  f(r) + h f'(r) = 0

Define a new approximation to r, r_(k+1), in terms of
the previous iteration of r, r_(k):

  r_(k+1) = r_(k) + h

Solve for h from the first-order series above by substituting 
the values of f and f' (f(r) = r^2 - N, f'(r) = 2 r):

  r^2 - N + 2 r h = 0

Solving for h:

  h = 1/2 (N/r - r)

Adding r_(k) to h to give the next aproximation r_(k+1): 

  r_(k+1) = r_(k) + h = 1/2 (N / r_(k) + r_(k))

This converges to the square root of N to a prescribed accuracy, with
a non-0 starting value.

--}

-- generate a better approximation for the square root of n from the
-- current estimate r - this is the recursion for r_(k+1) above

nextr :: 
  (Floating a) => 
  a -> 
  a -> 
  a
nextr n r = ((n / r) + r) / 2

-- construct a list of successive approximations: infinite!

repeatit :: 
  (a->a) -> 
  a -> 
  [a]
repeatit f r = r : (repeatit f (f r))

-- first m approximations to square root of 2 starting with estimate 1
firstrn m = take m (repeatit (nextr 2) 1)

-- accept the result when the absolute difference between
-- successive terms is less than eps
withintol ::
  (Floating a, Ord a) => 
  a -> 
  [a] -> 
  a
withintol eps (a0 : a1 : as)
  | abs(a0 - a1) < eps    = a1
  | otherwise             = withintol eps (a1:as)

myabssqrt eps a0 n = withintol eps (repeatit (nextr n) a0)

sq2abs = myabssqrt (1.0e-6) 1 2

-- for small values of roots, relative errors suffer less rounding
withinreltol ::
  (Floating a, Ord a) => 
  a -> 
  [a] -> 
  a
withinreltol eps (a0 : a1 : as)
  | abs((a0 / a1) - 1.0) < eps    = a1
  | otherwise                     = withinreltol eps (a1:as)

myrelsqrt eps a0 n = withinreltol eps (repeatit (nextr n) a0)

sq2rel = myrelsqrt (1.0e-6) 1 2

