-module(simple_test).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

simple_test() ->
    ok = application:start(bktree),
    ?assertNot(undefined == whereis(bktree_sup)).
