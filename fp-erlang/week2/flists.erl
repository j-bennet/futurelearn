-module(flists).
-export ([double/1,evens/1,take/2,nub/1]).

% Double all elements in a list
% Xs: list
double([]) -> [];

double([X | Xs]) -> [X+X | double(Xs)].


% Return only even elements from a list
% Xs: list
evens([]) -> [];

evens([X | Xs]) ->
  case X rem 2 of
    0 -> [X | evens(Xs)];
    _ -> evens(Xs)
  end.

% Take N elements from a list
% N: int
% Xs: list
take(0, _) -> [];

take(_, []) -> [];

take(N, [X | Xs]) when N > 0 -> [X | take(N-1, Xs)].

% Remove all instances of X from a list
% X: what to remove
% Xs: list
removeAll(_, []) -> [];

removeAll(X, [X | Xs]) ->
  removeAll(X, Xs);

removeAll(X, [Y | Ys]) ->
  [Y | removeAll(X, Ys)].

% Remove all duplicates from a list
% Xs: list
nub([]) -> [];

nub([X|Xs]) -> [X | nub(removeAll(X, Xs))].
