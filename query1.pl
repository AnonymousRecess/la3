#!/bin/gprolog --consult-file

:- include('data.pl').
:- include('uniq.pl').

free(Person,slot(time(hour1,min1,id1),time(hour2,min1,id2))). % Check for Person with Hour, Minute and Miday




match(slot(ABegin,AEnd),slot(BBegin,BEnd),slot(BBegin,BEnd)) :-
    BBegin\==AEnd.

match(slot(ABegin,AEnd),slot(BBegin,BEnd),slot(BBegin,BEnd)) :-
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
        write(Uniq), nl, halt.

:- initialization(main).
