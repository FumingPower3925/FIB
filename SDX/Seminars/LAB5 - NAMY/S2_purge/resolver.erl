-module(resolver).
-export([start/1, stop/0]).
-define(timeout, 1000).

start(Root) ->
    register(resolver, spawn(fun()-> init(Root) end)).

stop() ->
    resolver ! stop,
    unregister(resolver).

init(Root) ->
    Cache = [],
    NewCache = cache:add([], inf, {domain, Root}, Cache),
    resolver(NewCache).

resolver(Cache) ->
    receive
        {request, From, Req}->
            io:format("Resolver: request from ~w to solve ~w~n", [From, Req]),
            {Reply, NewCache} = resolve(Req, Cache),
            From ! {reply, Reply},
            resolver(NewCache);
        status ->
            io:format("Resolver: cache content: ~w~n", [Cache]),
            resolver(Cache);
        stop ->
            io:format("Resolver: closing down~n", []),
            ok;
        purge ->
            io:format("purge ~n", []),
            NewCache = cache:purge(Cache),
            resolver(NewCache);
        Error ->
            io:format("Resolver: reception of strange message ~w~n", [Error]),
            resolver(Cache)
    end.

resolve(Name, Cache)->
    io:format("Resolve ~w: ", [Name]),
    case cache:lookup(Name, Cache) of
        unknown ->
            io:format("unknown ~n", []),
            recursive(Name, Cache);
        invalid ->
            io:format("invalid ~n", []),
            recursive(Name, Cache);
        Reply ->
            io:format("found ~w~n", [Reply]),
            {Reply, Cache}
    end.

recursive([Name|Domain], Cache) ->
    io:format("Recursive ~w: ", [Domain]),
    case resolve(Domain, Cache) of
        {unknown, NewCache} ->
            {unknown, NewCache};
        {{domain, Srv}, NewCache} ->
            Srv ! {request, self(), Name},
            io:format("Resolver: sent request to solve [~w] to ~w: ", [Name, Srv]),
            receive
                {reply, unknown, _} ->
                    io:format("unknown ~n", []),
                    {unknown, NewCache};
                {reply, Reply, TTL} ->
                    io:format("reply ~w~n", [Reply]),
                    Now = erlang:monotonic_time(),
                    Expire = erlang:convert_time_unit(Now, native, second) + TTL,
                    NewerCache = cache:add([Name|Domain], Expire, Reply, NewCache),
                    {Reply, NewerCache}
            after ?timeout ->
                io:format("timeout~n", []),
                {unknown, NewCache}
            end
    end.
