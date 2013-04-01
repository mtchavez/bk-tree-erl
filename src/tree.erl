-module (tree).
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
    case dict:size(NodeChildren) > 0 of
        true ->
            Pred = fun(Key) ->
                NewTree = dict:fetch(Key, NodeChildren),
                {Term, _} = NewTree,
                search(Word, NewTree, Depth, Found)
            end,
            Keys = dict:fetch_keys(NodeChildren),
            lists:flatten(lists:map(Pred, Keys));
        false ->
            Dist = levenshtein:distance(Word, NodeWord),
            case Depth >= Dist of
                true ->
                    lists:append(Found, [{Dist, NodeWord}]);
                false ->
                    []
            end
    end.
