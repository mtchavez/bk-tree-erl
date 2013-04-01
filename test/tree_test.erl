-module(tree_test).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

setup() ->
    ok = application:start(bktree),
    ?assertNot(undefined == whereis(bktree_sup)).

init_test() ->
    Word = "Apple",
    ?assertEqual({Word, dict:new()}, tree:init(Word)).

insert_test() ->
    Root = tree:init("apple"),
    Tree = tree:insert("ape", Root),
    Children = dict:from_list([{2, {"ape", dict:new()}}]),
    ?assertEqual({"apple", Children}, Tree).

search_test() ->
    T = tree:init("brewery"),
    T2 = tree:insert("stone", T),
    T3 = tree:insert("anchorsteam", T2),
    T4 = tree:insert("delirium", T3),
    ?assertEqual(tree:search("deli", T4, 4), [{4, "delirium"}]),
    ?assertEqual(tree:search("deli", T4, 5), [{5, "stone"},{4, "delirium"}]).
