-module(cache).
-export([lookup/2, add/4, remove/2]).

lookup(Name, Entries) ->
    Now = erlang:monotonic_time(),
    Time = erlang:convert_time_unit(Now, native, second),
    case lists:keyfind(Name, 1, Entries) of
        {_, Expire, Reply} ->
            if Expire > Time -> Reply; %No ha caducat el TTL
            true -> invalid
            end;
        false -> unknown
    end.

add(Name, Expire, Reply, NewCache) ->
    lists:keystore(Name, 1, NewCache, {Name, Expire, Reply}).

remove(Name, Cache) ->
    lists:keydelete(Name, 1, Cache).