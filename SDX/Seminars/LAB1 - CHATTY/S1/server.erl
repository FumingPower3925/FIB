-module(server).
%% Exported Functions
-export([start/0]).

start() ->
    ServerPid = spawn(fun() -> process_requests([]) end),
    register(myserver, ServerPid).

process_requests(Clients) ->
    receive
        {client_join_req, Name, From} ->
            NewClients = [From|Clients],
            broadcast(NewClients, {join, Name}),
            process_requests(NewClients);
        {client_leave_req, Name, From} ->
            NewClients = lists:delete(From, Clients),
            broadcast(Clients, {leave, Name}),
            From ! exit,
            process_requests(NewClients);
        {send, Name, Text} ->
            broadcast(Clients, {message, Name, Text}),
            process_requests(Clients);
        disconnect ->
            unregister(myserver)
    end.

broadcast(PeerList, Message) ->
    Fun = fun(Peer) -> Peer ! Message end,
    lists:foreach(Fun, PeerList).
