-module(tree_test).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").
-include("include/tree.hrl").

setup() ->
    ok = application:start(bktree),
    ?assertNot(undefined == whereis(bktree_sup)).

init_test() ->
    Word = "Apple",
    Tree = tree:init(Word),
    ?assertEqual(#root_node{root = #node{item = "Apple",child = nil,
                        sibling = nil,dist = 0},
           size = 0}, tree:init(Word)).
