-module (tree).
-export ([init/1, insert/2]).
-include("../include/tree.hrl").

init(Word) ->
    {Word, dict:new()}.

%
% { "apple", dict{
%   2: { "ape", dict{} },
%   3: { "apes", dict{} }
%     }}
% }
insert(Word, {NodeWord, NodeChildren}) ->
    Dist = levenshtein:distance(Word, NodeWord),
    case dict:is_key(Dist, NodeChildren) of
        true ->
            NewTree = dict:fetch(Dist, NodeChildren),
            {NodeWord, dict:store(Dist, insert(Word, NewTree), NodeChildren)};
        false ->
            {NodeWord, dict:store(Dist, {Word, dict:new()}, NodeChildren)}
    end.


