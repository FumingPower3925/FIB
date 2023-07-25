-module(server).
-export([start/0, start/2, stop/0]).

start() ->
    register(server, spawn(fun()-> init() end)).

start(Domain, Parent) ->
    register(server, spawn(fun()-> init(Domain, Parent) end)).

stop() ->
    server ! stop,
    unregister(server).

init() ->
    io:format("Server: create root domain~n"),
    server([], 0, root, null).

init(Domain, Parent) ->
    io:format("Server: create domain ~w at ~w~n", [Domain, Parent]),
    Parent ! {register, Domain, {domain, self()}},
    server([], 10, Domain, Parent).

server(Entries, TTL, Domain, Parent) ->
    receive
        {request, From, Req}->
            io:format("Server: received request to solve [~w]~n", [Req]),
            Reply = entry:lookup(Req, Entries),
            From ! {reply, Reply, TTL},
            server(Entries, TTL, Domain, Parent);
        {register, Name, Entry} ->
            io:format("Server: registered subdomain ~w~n", [Name]),
	    NewEntries = entry:add(Name, Entry, Entries),
            server(NewEntries, TTL, Domain, Parent);
        {deregister, Name} ->
            io:format("Server: deregistered subdomain ~w~n", [Name]),
            NewEntries = entry:remove(Name, Entries),
            server(NewEntries, TTL, Domain, Parent);
        {ttl, Sec} ->
            io:format("Server: updated TTL to ~w~n", [Sec]),
            server(Entries, Sec, Domain, Parent);
        status ->
            io:format("Server: List of DNS entries: ~w~n", [Entries]),
            server(Entries, TTL, Domain, Parent);
        stop ->
            if Parent /= null ->
                Parent ! {deregister, Domain}
            end,
            io:format("Server: closing down~n", []),
            ok;
        Error ->
            io:format("Server: reception of strange message ~w~n", [Error]),
            server(Entries, TTL, Domain, Parent)
    end.
