#!/bin/gprolog --consult-file

:- include('data.pl').
:- include('uniq.pl').

free(Person,slot(time(hour1,min1,id1),time(hour2,min1,id2))). % Check for Person with Hour, Minute and Miday

lte(time(_,_,am), time(_,_,pm)).

lte(time(Hour1,_,ID),time(Hour2, _,ID)) :-
		Hour1<Hour2.	% Ensure that Hour1 is less than Hour2

lte(time(Hour,Min1,ID), time(Hour, Min2, ID)) :-
		Min1=<Min2.    % Ensure that Min1 is less than or equal to Min2

match(slot(ABegin,AEnd),slot(BBegin,BEnd),slot(BBegin,BEnd)) :-
    lte(ABegin,BBegin),
    lte(BBegin,AEnd),
    BBegin\==AEnd.

match(slot(ABegin,AEnd),slot(BBegin,BEnd),slot(BBegin,BEnd)) :-
    lte(ABegin,BBegin),
    lte(BBegin,AEnd),
    BBegin\==AEnd.

meetCheck(ASlot,BSlot,SharedSlot) :-
    match(ASlot,BSlot,SharedSlot).

meetCheck(ASlot,BSlot,SharedSlot) :-
    match(BSlot,ASlot,SharedSlot).

meetCollect([],Slot,Slot).
meetCollect([B|Tail],ASlot,Slot) :-
    free(B,BSlot),
    meetCheck(ASlot,BSlot,Slot0),
    meetCollect(Tail,Slot0,Slot).

meetTimes([A|Tail], Slot) :-
    free(A,ASlot),
    meetCollect(Tail,ASlot,Slot).

meet(Slot) :-
    people(People),
    meetTimes(People,Slot).

people([ann,bob,dave]).
main :- findall(Slot, meet(Slot), Slots),
        uniq(Slots, Uniq),
        write(People), nl, halt.

:- initialization(main).
