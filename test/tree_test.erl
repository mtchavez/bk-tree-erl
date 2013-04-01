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
    T = tree:init("apple"),
    T2 = tree:insert("ape", T),
    T3 = tree:insert("apes", T2),
    T4 = tree:insert("ale", T3),
    ?assertEqual(tree:search("ape", T4), []),
    ?assertEqual(tree:search("ape", T4, 2), [{0,"ape"},{1,"ale"}]).
