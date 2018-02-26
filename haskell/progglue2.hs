module ProgGlue2 where

import ProgGlue1 (repeatit, withintol)

{--

Compute derivatives of a function numerically,
taking advantage of lazy evaluation

Sect. 4.2
--}

-- definition of derivative of f without the limit h -> 0
easydiff :: 
  Floating a =>
  (a -> a) ->
  a ->
  a ->
  a
easydiff f x h = ((f (x + h)) - (f x))/h

differentiate h0 f x = map (easydiff f x) (repeatit halve h0) 
  where halve x = x/2


-- Add the controlling consumer re-using the 
-- controlling comparator "withintol"
slowdiff eps h0 f x = withintol eps (differentiate h0 f x)

-- slowdiff computes the derivative, but is relatively inefficient

{-- 
  See the paper (p. 12, 13): an improvement accelerates convergence
  by computing a higher-order estimate of the error term in a power of h
--}

elimerror ::
  Floating a =>
  Int ->
  [a] ->
  [a]
elimerror n (a0 : a1 : as) = ( trm : (elimerror n (a1 : as)) )
  where trm = ((a1 * (2^n)) - a0) / ((2^n) - 1)

-- To compute "n" from the data
-- estimate the order of the approximation 
-- from the sequence of values (first three in the series)
order ::
  (Floating a, RealFrac a, Integral b) =>
  [a] ->
  b
order (a : b : c : _) = round (logBase 2.0 ((a - c)/(b - c) - 1))

-- Put this together as a function to improve the approximation
improve s = elimerror (order s) s

{--
The function "improve" works only on sequences of approximations 
that are computed using a parameter h, which is halved 
for each successive approximation. However, if it is 
applied to such a sequence its result is also such a sequence!
--}

derivimp1 eps h0 f x = withintol eps (improve (differentiate h0 f x))
derivimp2 eps h0 f x = withintol eps (improve (improve (differentiate h0 f x)))
derivimp3 eps h0 f x = withintol eps (improve (improve (improve (differentiate h0 f x))))

{--
take 5 (differentiate 0.25 (\x -> 2 * x - x^3) 4.0)
[-49.0625,-47.515625,-46.75390625,-46.3759765625,-46.187744140625]

take 5 (improve (differentiate 0.25 (\x -> 2 * x - x^3) 4.0))
[-45.96875,-45.9921875,-45.998046875,-45.99951171875,-45.9998779296875]

take 5 (improve (improve (differentiate 0.25 (\x -> 2 * x - x^3) 4.0)))
[-46.0,-46.0,-46.0,-46.0,-46.0]

take 5 (improve (improve (improve (differentiate 0.25 (\x -> 2 * x - x^3) 4.0))))
[NaN,NaN,NaN,NaN,NaN]
because "order" blows up, no guard against b == c
--}
