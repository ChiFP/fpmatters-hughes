module ProgGlue2 where

import ProgGlue1 (repeatit, withintol)

{--

Compute derivatives of a function numerically
taking advantage of lazy evaluation

--}

-- definition of derivative of f without the limit h -> 0
easydiff :: 
  Floating a =>
  (a->a) ->
  a ->
  a ->
  a
easydiff f x h = ((f (x+h)) - (f x))/h

differentiate h0 f x = map (easydiff f x) (repeatit halve h0) 
  where halve x = x/2


-- Add the controlling consumer
withintol eps (differentiate h0 f x)