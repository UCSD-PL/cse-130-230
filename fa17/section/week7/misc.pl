% OK, now for Prolog. Prolog is a really neat language for *declarative programming*,
% sometimes called database programming. The idea with prolog is to state
% facts over atoms, and then write declarative rules over the atoms.

% for example, a geneology tree, pulled from http://www.cs.toronto.edu/~sheila/384/w11/simple-prolog-examples.html:

% First, some predicates for male/female atoms:
male(james1).
% here, "male" is the predicate and "james1" is the atom.
male(charles1).
male(charles2).
male(james2).
male(george1).

female(catherine).
% similarly, "female" is the predicate and "catherine" is the atom.
female(elizabeth).
female(sophia).

% a binary relation! "Charles 1 is the parent of James 1"
parent(charles1, james1).
% here, parent is the relation and charles1/james1 are the atoms.
parent(elizabeth, james1).
parent(charles2, charles1).
parent(catherine, charles1).
parent(james2, charles1).
parent(sophia, elizabeth).
parent(george1, sophia).

% To ask queries, you ask Prolog about whether a relation is true or not:
% parent(charles1, george1).

% Under the hood, Prolog uses *unification* to resolve queries.
% What this means in practice is you can give Prolog "free variables" in
% a query, and it will fill in the blank (i.e. unify) the free variables
% with every atom that makes the query true:

% parent(charles1, Child).
% parent(Parent, sophia).


grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

% grandparent(, Q)


% Here is how you would formulate the following queries:
%
%    Was George I the parent of Charles I?

% George 1 == george1
% Charles 1 == charles1

% parent(george1, charles1)


%    Who was Charles I's parent?
%             Query: parent(charles1,X).
%    Who were the children of Charles I?
%             Query: parent(X,charles1).

% Now let's try expressing the following rules:
%
%    M is the mother of X if she is a parent of X and is female
mother(M, X) :- parent(X, M), female(M).
% mother(M, X) :- parent(X, M), male(M)




%    F is the father of X if he is a parent of X and is male


%    X is a sibling of Y if they both have the same parent.

sibling(X, Y) :- parent(X, P), parent(Y, P), X \= Y.

% notice: X \= Y so that we don't get duplicate results for the same child,
% e.g. charles1 is the sibling of charles1

% AND parent(X, P), parent(Y, P) share the same variable for the second argument



% Next, let's talk about bagof/3. Bagof is a neat predicate that
% accumulates query results into a list:
% bagOf(QueryResult_i, Query, ResultList).

% bagOf(X, parent(Y, X), RA)

% Here's how to use this for the parents rule:

% gather the parents of a person and put them into a list
% OR
% all of the elements of RA are a parent of X
% parents(X, RA)

% parents(X, [Y|RE]) :- parent(X, Y), parents(X, RE).
% parents(X, []).

parents(X, RA) :- bagof(P, parent(X, P), RA).

% pathfinding between cities: https://ucsd-pl.github.io/cse-130-230/fa17/final-fa13.pdf

% Sat solving: https://ucsd-pl.github.io/cse-130-230/fa17/final-wi11.pdf
