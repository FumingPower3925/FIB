-module(server2).
%% Exported Functions
-export([start/0, start/1]).

start() ->
    ServerPid = spawn(fun() -> init_server() end),
    register(myserver, ServerPid).

start(BootServer) ->
    ServerPid = spawn(fun() -> init_server(BootServer) end),
    register(myserver, ServerPid).

init_server() ->
    process_requests([], [self()]).

init_server(BootServer) ->
    BootServer ! {server_join_req, self()},
    process_requests([], []).

process_requests(Clients, Servers) ->
    receive
        %% Messages between client and server
        {client_join_req, Name, From} ->
            NewClients = [From|Clients],
            broadcast(Servers, {join, Name}),  %% TODO: COMPLETE
            process_requests(NewClients, Servers);
        {client_leave_req, Name, From} ->
            NewClients = lists:delete(From, Clients),
            broadcast(Servers, {leave, Name}),  %% TODO: COMPLETE
            From ! exit,
            process_requests(NewClients, Servers);
        {send, Name, Text} ->
            broadcast(Servers, {message, Name, Text}),  %% TODO: COMPLETE
            process_requests(Clients, Servers);
        
        %% Messages between servers
        disconnect ->
            NewServers = lists:delete(self(), Servers),
            broadcast(NewServers, {update_servers, NewServers}),
            unregister(myserver);
        {server_join_req, From} ->
            NewServers = [From|Servers],
            broadcast(NewServers, {update_servers, NewServers}),  %% TODO: COMPLETE
            process_requests(Clients, NewServers);
        {update_servers, NewServers} ->
            io:format("[SERVER UPDATE] ~w~n", [NewServers]),
            process_requests(Clients, NewServers);
            
        RelayMessage -> %% Whatever other message is relayed to its clients
            broadcast(Clients, RelayMessage),
            process_requests(Clients, Servers)
    end.

broadcast(PeerList, Message) ->
    Fun = fun(Peer) -> Peer ! Message end,
    lists:foreach(Fun, PeerList).
