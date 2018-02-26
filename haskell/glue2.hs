module Glue2 where

-- Sec. 3 to p. 6

-- One can look at (foldr f b) when applied to lists as:

-- substitute b for every []
-- substitute f for ever (:)

-- so for 
ls = 2 : (3 : (4 : []))

-- add up contents of ls
sumls = foldr (+) 0 ls

-- is the same as
sumlssubs = 2 + (3 + (4 + 0))

-- the function (foldr (:) []) just copies a list item by item
-- so one can prepend one list on the front of another with that function
lfront = "abcdef-"
ltail = "-xyz"

myappend l = foldr (:) ltail l

lft = myappend lfront

-- use foldr to count the number of elements

mycount a n = n + 1
mylength l = foldr mycount 0 l

-- Equivalently, define mycount as a lambda:
mylengthlam l = foldr (\a x->x+1) 0 l