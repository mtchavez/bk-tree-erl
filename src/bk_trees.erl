-module (bk_trees).
-export ([init/1, insert/2, search/2, search/3]).

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

search(Word, Tree) ->
    search(Word, Tree, 1, []).

search(Word, Tree, Depth) ->
    search(Word, Tree, Depth, []).

search(Word, {NodeWord, NodeChildren}, Depth, Found) ->
    Dist = levenshtein:distance(Word, NodeWord),
    MaxDepth = Dist+Depth,
    MinDepth = Dist-Depth,
    SubtreeSearch =
        fun(ChildDist, Child, Acc) when ChildDist >= MinDepth, ChildDist =< MaxDepth ->
                search(Word, Child, Depth, Acc);
           (_,_,Acc) ->
                Acc
        end,
    SubtreeRes = dict:fold(SubtreeSearch, Found, NodeChildren),
    case Depth >= Dist of
        true ->
            [{Dist, NodeWord} | SubtreeRes];
        false ->
            SubtreeRes
    end.
