-module(tree_test).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").
-include("include/tree.hrl").

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
