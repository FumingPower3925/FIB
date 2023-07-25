-module(groupy).
-export([start/5, stop/3, stop/2]).

% We use the name of the module (i.e. gms3) as the parameter Module to the start procedure. Sleep stands for up to how many milliseconds the workers should wait until the next message is sent.

start(Module, Sleep, Ip0 , Ip1, Ip2) ->
    spawn(Ip0, fun () -> register(a, worker:start("P1", Module, Sleep)) end),
    spawn(Ip1, fun () -> register(b, worker:start("P2", Module, {a, Ip0}, Sleep)) end),
    spawn(Ip1, fun () -> register(c, worker:start("P3", Module, {a, Ip0}, Sleep)) end),
    spawn(Ip2, fun () -> register(d, worker:start("P4", Module, {a, Ip0}, Sleep)) end),
    spawn(Ip2, fun () -> register(e, worker:start("P5", Module, {a, Ip0}, Sleep)) end).

stop(Ip0, Ip1, Ip2) ->
    {a, Ip0} ! stop,
    {b, Ip1} ! stop,
    {c, Ip1} ! stop,
    {d, Ip2} ! stop,
    {e, Ip2} ! stop.

stop(Name, Ip) ->
   {Name, Ip} ! stop.




