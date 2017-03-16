-module(bits).
-export ([bits/1]).

bits(N) when N > 0 ->
  bits(N, 0).

bits(1, Sum) ->
  Sum + 1;

bits(N, Sum) ->
  R = N rem 2,
  D = N div 2,
  bits(D, Sum + R).
