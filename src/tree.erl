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
                Dist = levenshtein:distance(Word, Term),
                NewFound = lists:append(Found, [{Dist, Term}]),
                search(Word, NewTree, Depth, NewFound)
            end,

            Dist = levenshtein:distance(Word, NodeWord),
            Keys = dict:fetch_keys(NodeChildren),
            {Good, _} = lists:partition(fun(Key) -> Dist =< Key andalso Depth >= Key end, Keys),
            lists:flatten(lists:map(Pred, Good));
        false ->
            erlang:display(NodeWord),
            Found
    end.
