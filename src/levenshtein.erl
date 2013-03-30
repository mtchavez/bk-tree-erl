-module (levenshtein).
-export ([distance/2]).

distance(String1, String2) ->
    {Length, _} = dist(String1, String2, dict:new()),
    Length.

dist([]=String1, String2, Cache) ->
    {length(String2), dict:store({String1, String2}, length(String2), Cache)};
dist(String1, []=String2, Cache) ->
    {length(String1), dict:store({String1, String2}, length(String1), Cache)};
dist([X|String1], [X|String2], Cache) ->
    dist(String1, String2, Cache);
dist([_|STail1]=String1, [_|Stail2]=String2, Cache) ->
    case dict:is_key({String1, String2}, Cache) of
        true -> {dict:fetch({String1, String2}, Cache), Cache};
        false ->
            {Len1, Cache1} = dist(String1, Stail2, Cache),
            {Len2, Cache2} = dist(STail1, String2, Cache1),
            {Len3, Cache3} = dist(STail1, Stail2, Cache2),
            Len = 1+lists:min([Len1, Len2, Len3]),
            {Len, dict:store({String1, String2}, Len, Cache3)}
    end.
