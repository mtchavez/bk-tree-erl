-module(levenshtein_test).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

setup() ->
  ok = application:start(bktree),
  ?assertNot(undefined == whereis(bktree_sup)).

empty_strings_test() ->
  ?assertEqual(0, levenshtein:distance("", "")).

same_word_test() ->
  Word = "apple",
  ?assertEqual(0, levenshtein:distance(Word, Word)).

different_word_test() ->
  Word1 = "apple",
  Word2 = "banana",
  ?assertEqual(5, levenshtein:distance(Word1, Word2)).
