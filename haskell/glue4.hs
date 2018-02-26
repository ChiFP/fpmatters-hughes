module Glue4 where

{--
Apply the modularity methods to a custom data type

Sec. 3 to p. 8
--}

data ATree a = ANode a [ATree a] deriving Show

foldATree ::
  (a -> b -> b) -> 
  (b -> b -> b) -> 
  b -> 
  ATree a -> 
  b
-- Not needed because the List version takes care of []:
-- foldATree _ _ b (ANode _ []) = b
foldATree f g b (ANode a ts) = f a (foldATreeList f g b ts)

foldATreeList f g b (t0 : ts) = g (foldATree f g b t0) (foldATreeList f g b ts)
foldATreeList _ _ b [] = b

{--
Errate: The Miranda code in the Hughes paper on page 7 does not type-check in Haskell:

foldtree f g a (Node label subtrees) =
  f label (foldtree f g a subtrees)

This second "foldtree" form takes a list of trees 
without a "Node" label

(In Haskell "Cons" is ":" and Nil is "[]")

foldtree f g a (Cons subtree rest) =
  g (foldtree f g a subtree) (foldtree f g a rest)

--}

tt0 = ANode 1 [ANode 4 [], ANode 3 [ANode 17 []]]
tt1 = ANode 'x' [ANode 'y' [], ANode 'z' [ANode 'b' []]]
tt3 = ANode 1 []

addtt0 = foldATree (+) (+) 0 tt0
multt0 = foldATree (*) (*) 1 tt0

concattt1 = foldATree (:) (++) [] tt1
