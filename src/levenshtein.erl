-module (levenshtein).
-export ([distance/2]).

distance(Str1, Str2) ->
  {Length, _} = dist(Str1, Str2, dict:new()),
  Length.

dist([]=S1, S2, Cache) ->
  L2 = length(S2),
  {L2, dict:store({S1, S2}, L2, Cache)};

dist(S1, []=S2, Cache) ->
  L1 = length(S1),
  {L1, dict:store({S1, S2}, L1, Cache)};

dist([_SS1|S1]=Str1, [_SS2|S2]=Str2, Cache) ->
  case dict:is_key({Str1, Str2}, Cache) of
    true -> { dict:fetch({Str1, Str2}, Cache), Cache};
    false ->
      {L1, C1} = dist(Str1, S2, Cache),
      {L2, C2} = dist(S1, Str2, C1),
      {L3, C3} = dist(S1, S2, C2),
      Len = 1 + lists:min([L1, L2, L3]),
      {Len, dict:store({Str1, Str2}, Len, C3)}
  end.
