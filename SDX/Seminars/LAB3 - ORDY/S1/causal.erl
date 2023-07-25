-module(basic).
-export([start/3]).

start(Id, Master, Jitter) ->
    spawn(fun() -> init(Id, Master, Jitter) end).

init(Id, Master, Jitter) ->
    receive
        {peers, Nodes} ->
            server(Id, Master, lists:delete(self(), Nodes), Jitter)
    end.

server(Id, Master, Nodes, Jitter, VC, Queue) ->
    receive
        {send, Msg} ->
            multicast(Msg, Nodes, Jitter, Id, VC),
            Master ! {deliver, Msg},
            server(Id, Master, Nodes, Jitter, VC, Queue);
        {multicast, Msg, FromId, MsgVC} ->
            case checkMsg(FromId, MsgVC, VC, size(VC)) of
                ready ->
                    NewVC = incrementVC (Id, maxClocks(VC, MsgVC, size(VC))),
                    {NewerVC, NewQueue} = deliverReadyMsgs(Master, NewVC, Queue, Queue).
                    server(Id, Master, Nodes, Jitter, NewerVC, NewQueue);
                wait ->
                    server(Id, Master, Nodes, Jitter, VC, [{FromId, MsgVC, Msg}|Queue])
                end;
        stop ->
            ok
    end.

multicast(Msg, Nodes, 0, Id, VC) ->
    lists:foreach(fun(Node) -> 
                      Node ! {multicast, Msg, Id, VC}
                  end, 
                  Nodes);
multicast(Msg, Nodes, Jitter, Id, VC) ->
    lists:foreach(fun(Node) -> 
                      T = rand:uniform(Jitter),
                      timer:send_after(T, Node, {multicast, Msg, Id, VC})
                  end, 
                  Nodes).

newVC(0, List) ->
    list_to_tuple(List);
newVC(N, List) ->
    newVC(N-1, [0|List]).

maxClocks(NewVC, _, 0) -> NewVC;
maxClocks(VC, MsgVC, N) ->
    NewVC = setelement(N, VC, max(element(N, VC), element(N, MsgVC))),
    maxClocks(NewVC, MsgVC, N-1).

%% Increment position N of vector clock VC
incrementVC(N, VC) ->
    setelement(N, VC, element(N, VC)+1).

%% Check if a message can be delivered to the master
checkMsg(_, _, _, 0) -> ready;
checkMsg(FromId, MsgVC, VC, FromId) ->
    if (element(FromId, MsgVC) == element(FromId, VC)) ->
            checkMsg(FromId, MsgVC, VC, FromId-1);
        true -> wait
    end;
checkMsg(FromId, MsgVC, VC, N) ->
    if (element(FromId, MsgVC) =< element(N, VC)) ->
            checkMsg(FromId, MsgVC, VC, N-1);
        true -> wait
    end.

%% Deliver to the master all the ready messages in the hold-back queue
deliverreadyMsgs(_, VC, [], Queue) ->
    {VC, Queue};
deliverreadyMsgs(Master, VC, [{FromId, MsgVC, Msg}|Rest], Queue) ->
    case checkMsg(FromId, MsgVC, VC, size(VC)) of
        ready ->
            %%TODO
            NewVC = incrementVC (FromId, VC), %%TODO
            NewQueue = lists:delete({FromId, MsgVC, Msg}, Queue),
            deliverReadyMsgs(Master, NewVC, NewQueue, NewQueue);
        wait ->
            deliverReadyMsgs(Master, VC, Rest, Queue)
        end.
