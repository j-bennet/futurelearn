-module(shapes).
-export([circles/1,perimeter/1,area/1,enclose/1]).

circles([]) -> [];

circles([X | Xs]) ->
    case X of
	    {circle, {_, _} ,_} = C -> [C | circles(Xs)];
	    _ -> circles(Xs)
end.

area({rectangle, {_X, _Y}, W, H}) ->
  W * H;

area({circle, {_X, _Y}, R}) ->
  math:pi() * R * R;

%% A, B, C are the lengths of the triangle's sides.
%% {Ax, Ay} and {Cx, Cy} are coordinates of two corners adjacent to base C.
%% Using Heron's formula:
%%   s = (a + b + c) / 2
%%   area = sqrt(s * (s - a) * (s - b) * (s - c))
area({triangle, A, B, C, {_Ax, _Ay}, {_Cx, _Cy}}) ->
  S = (A + B + C) / 2,
  math:sqrt(S * (S - A) * (S - B) * (S - C)).

perimeter({rectangle, {_X, _Y}, W, H}) ->
  2 * (W + H);

perimeter({circle, {_X, _Y}, R}) ->
  2 * R * math:pi();

perimeter({triangle, A, B, C, {_Ax, _Ay}, {_Cx, _Cy}}) ->
  A + B + C.

enclose({rectangle, {X, Y}, W, H}) ->
  {rectangle, {X, Y}, W, H};

enclose({circle, {X, Y}, R}) ->
  TopLeftX = X - R/2,
  TopLeftY = Y + R/2,
  {rectangle, {TopLeftX, TopLeftY}, R * 2, R * 2};

enclose({circle, {X, Y}, R}) ->
  TopLeftX = X - R/2,
  TopLeftY = Y + R/2,
  {rectangle, {TopLeftX, TopLeftY}, R * 2, R * 2};

%% Area = Base * Height / 2
%% Height = Area * 2 / Base
enclose({triangle, A, B, C, {Ax, Ay}, {Cx, Cy}}) ->
  Area = area({triangle, A, B, C, {Ax, Ay}, {Cx, Cy}}),
  Height = Area * 2 / C,
  {rectangle, {Ax, Ay + Height}, Height, C}.