-module(index).
-export([get_file_contents/1,show_file_contents/1,tokenize/1,main/1]).

% Used to read a file into a list of lines.
% Example files available in:
%   gettysburg-address.txt (short)
%   dickens-christmas.txt  (long)
  

% Get the contents of a text file into a list of lines.
% Each line has its trailing newline removed.

get_file_contents(Name) ->
    {ok, File} = file:open(Name, [read]),
    Rev = get_all_lines(File, []),
    lists:reverse(Rev).

% Auxiliary function for get_file_contents.
% Not exported.

get_all_lines(File, Partial) ->
    case io:get_line(File, "") of
        eof -> file:close(File),
               Partial;
        Line -> {Strip, _} = lists:split(length(Line)-1, Line),
                get_all_lines(File, [Strip | Partial])
    end.

% Show the contents of a list of strings.
% Can be used to check the results of calling get_file_contents.

show_file_contents([L|Ls]) ->
    io:format("~s~n", [L]),
    show_file_contents(Ls);

show_file_contents([]) ->
    ok.

% Convert a list of text lines into a flat list of words.
% Example: ["foo boo", "baa bee"] -> ["foo", "boo", "baa", "bee"]

tokenize([Line]) -> string:tokens(Line, " ");

tokenize([Line|Lines]) -> string:tokens(Line, " ") ++ tokenize(Lines).

% Remove all instances of word from a list

remove_all(_, []) -> [];

remove_all(X, [X | Xs]) -> remove_all(X, Xs);

remove_all(X, [Y | Xs]) -> [Y | remove_all(X, Xs)].

% Only return unique elements of a  list
% Let's do this by removing all subsequent duplicates and only leaving the
% first one.

unique([]) -> [];

unique([Word | Words]) -> [Word | unique(remove_all(Word, Words))].


% Lowercase all elements of a list.

lowercase([]) -> [];

lowercase([Word | Words]) -> [string:to_lower(Word) | lowercase(Words)].

main(Name) ->
    Lines = get_file_contents(Name),
    Words = tokenize(Lines),
    Lower = lowercase(Words),
    Unique = unique(Lower),
    Sorted = lists:sort(Unique),
    Sorted.
