-module(recur).
-export([fib/1,pieces/1]).

fib(N) -> fib(N, 0, 1).

fib(0,A,_) -> A;
fib(X,A,B) ->
	fib(X-1,B,A+B).

pieces(0) -> 1;
pieces(1) -> 2;
pieces(2) -> 4;
pieces(X) when X>2 ->
	pieces(X-1) + X.
