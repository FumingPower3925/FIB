-module(cache).
-export([lookup/2, add/4, remove/2]).

lookup(Name, Entries) ->
    case lists:keyfind(Name, 1, Entries) of
        {_, _, Reply} ->
            Reply;
        false -> unknown
    end.

add(Name, Expire, Reply, NewCache) ->
    lists:keystore(Name, 1, NewCache, {Name, Expire, Reply}).

remove(Name, Cache) ->
    lists:keydelete(Name, 1, Cache).
