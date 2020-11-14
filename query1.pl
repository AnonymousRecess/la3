#!/bin/gprolog --consult-file

:- include('data.pl').
lte(time(_,_am))

match(slot(ABegin,AEnd),slot(BBegin,BEnd).slot(BBegin,BEnd)) :-
    lte(ABegin,BBegin),
    lte(BBegin,AEnd),
    lte(BEnd,AEnd),
    BBegin\==AEnd.

match(slot(ABegin,AEnd),slot(BBegin,BEnd).slot(BBegin,BEnd)) :-
    lte(ABegin,BBegin),
    lte(BBegin,AEnd),
    lte(AEnd,BEnd),
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

meetTImes([A|Tail], Slot) :-
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
