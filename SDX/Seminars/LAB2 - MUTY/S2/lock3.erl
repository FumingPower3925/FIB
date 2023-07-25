-module(lock3).
-export([start/1]).

start(MyId) ->
    spawn(fun() -> init(MyId) end).

init(MyId) ->
    receive
        {peers, Nodes} ->
        	% Incializem el rellotge de Lamport del procés
        	MyClock = 0, % S'incrementa cada cop que fa request %%%%%%%
            open(Nodes, MyId, MyClock);
        stop ->
            ok
    end.
    
% OPEN: Estat on no es vol accedir en memòria
open(Nodes, MyId, MyClock) -> %%%%%%%
    receive
    	% El worker vol accedir en memòria
    	% {take, PID_Worker, Referència}
        {take, Master, Ref} ->
        	Refs = requests(Nodes, MyId, MyClock+1), % Es fa request a tots els nodes del sistema
            wait(Nodes, Master, Refs, [], Ref, MyId, MyClock+1, MyClock+1); % Esperem a rebre la confirmació
        
        % Un altre worker vol accedir
        {request, From,  Ref, _, OtherClock} ->
            From ! {ok, Ref}, % Acceptem, ja que nosaltres no volem accedir
            open(Nodes, MyId, max(OtherClock,MyClock)); % Esperem més missatges i
            											% agafem el màxim dels rellotges
        % Parem l'execució
        stop ->
            ok
    end.

% Avisem a tots els nodes que volem accedir en memòria
requests(Nodes, MyId, MyClock) ->
    lists:map(
      fun(P) -> 
        R = make_ref(), % Afegim tots els nodes a la llista de confirmacions
        				% (estaran tots els nodes que no tinguem la seva confirmació)
        P ! {request, self(), R, MyId, MyClock}, % Ens enviem OK a nosaltres mateixos
        R 
      end, 
      Nodes).

% WAIT: Estat on es vol accedir en memòria

% S'executarà si l'array de requests és buit (3r paràmetre)
wait(Nodes, Master, [], Waiting, TakeRef, MyId, _, NextClock) ->
    % Avisem al worker que ja té permís per accedir a memòria
    Master ! {taken, TakeRef},
    % Anem a HELD
    held(Nodes, Waiting, MyId, NextClock);

% S'executarà si encara hi ha nodes pendents de confirmar (Refs)
% Waiting -> Processos que estàn al meu radere (cua, volen accedir però jo tinc més preferència)
wait(Nodes, Master, Refs, Waiting, TakeRef, MyId, MyClock, NextClock) ->
    receive
    	% Un worker vol accedir en memòria
        {request, From, Ref, OtherId, OtherClock} ->
        	   % Si jo tinc preferència (jo tinc més ticks)
        	if MyClock > OtherClock; MyClock =:= OtherClock, MyId > OtherId ->
        	   		From ! {ok,Ref},
               		wait(Nodes, Master, Refs, Waiting, TakeRef, MyId, MyClock, max(NextClock, OtherClock));
            true ->
                    wait(Nodes, Master, Refs, [{From, Ref}|Waiting], TakeRef, MyId, MyClock, max(NextClock, OtherClock))
        	end;
        % Rebem una confirmació
        {ok, Ref} ->
            NewRefs = lists:delete(Ref, Refs), % Treiem el worker de la llista d'espera
            wait(Nodes, Master, NewRefs, Waiting, TakeRef, MyId, MyClock, NextClock);
            % Torem a esperar amb la nova llista
        
        % Deixem d'esperar i anem a l'estat OPEN
        release ->
        	% Enviem un OK a tots els workers que teniem a la cua
            ok(Waiting),            
            % Anem a OPEN
            open(Nodes, MyId, NextClock)
    end.

% Enviem un OK a tots els workers que estaven esperant
ok(Waiting) ->
    lists:foreach(
      fun({F,R}) -> 
        F ! {ok, R} 
      end, 
      Waiting).

% HELD: Estat on s'accedeix en memòria
held(Nodes, Waiting, MyId, MyClock) ->
    receive
    	% Un worker vol accedir en memòria
        {request, From, Ref, _, OtherClock} ->
        	% El posem a la cua, ja que hi estem nosaltres
            held(Nodes, [{From, Ref}|Waiting], MyId, max(MyClock, OtherClock));
        % El worker vol sortir de memòria
        release ->
        	% Enviem un OK a tots els que estaven esperant
            ok(Waiting),
            % Anem a l'estat OPEN
            open(Nodes, MyId, MyClock)
    end.
