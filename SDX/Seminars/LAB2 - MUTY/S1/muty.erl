-module(muty).
-export([start/5, stop/0]).

% We use the name of the module (i.e. lock3) as a parameter to the start procedure. We also provide the average time (in milliseconds) the worker is going to sleep before trying to get the lock (Sleep) and work with the lock taken (Work).

start(Lock, Sleep, Work, Ip1, Ip2) ->
    Main = self(),
    register(ip1, Ip1),
    register(ip2, Ip2),
    spawn(Ip1, fun () -> register(w1, worker:start("John", Main, Lock, 1, Sleep, Work)) end),
    spawn(Ip2, fun () -> register(w2, worker:start("Ringo", Main, Lock, 2, Sleep, Work)) end),
    register(w3, worker:start("Paul", Main, Lock, 3, Sleep, Work)),
    register(w4, worker:start("George", Main, Lock, 4, Sleep, Work)),
    collect(4, []).




collect(N, Locks) ->
    if
        N == 0 ->
            lists:foreach(fun(L) -> 
                L ! {peers, lists:delete(L, Locks)} 
            end, Locks);
        true ->
            receive
                {ready, L} ->
                    collect(N-1, [L|Locks])
            end
    end.

stop() ->
    spawn(ip1, fun() -> w1 ! stop end),
    spawn(ip2, fun() -> w2 ! stop end),
    w3 ! stop,
    w4 ! stop.

