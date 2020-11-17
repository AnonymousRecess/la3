:- include('data.pl').
:- include('uniq.pl').




lte(time(_,_,am), time(_,_,pm)).

lte(time(Hour1,_,ID),time(Hour2, _,ID)) :-
		Hour1<Hour2.	

lte(time(Hour,Min1,ID), time(Hour, Min2, ID)) :-
		Min1=<Min2.    


overlap(slot(FirstStart,FirstEnd),slot(SecondStart,SecondEnd),slot(SecondStart,SecondEnd)) :- 
        lte(FirstStart,SecondStart),
        lte(SecondStart,FirstEnd),
        lte(SecondEnd,FirstEnd),
        SecondStart\==SecondEnd.

overlap(slot(FirstStart,FirstEnd),slot(SecondStart,SecondEnd),slot(SecondStart,FirstEnd)) :- 
        lte(FirstStart,SecondStart),
        lte(SecondStart,FirstEnd),
        lte(FirstEnd,SecondEnd),
        SecondStart\==FirstEnd.

meetCheck(FirstFreeTime,SecondFreeTime,SharedSlot) :-
        overlap(FirstFreeTime,SecondFreeTime,SharedSlot).

meetCheck(FirstFreeTime,SecondFreeTime,SharedSlot) :-
        overlap(SecondFreeTime,FirstFreeTime,SharedSlot).

compareNext([], FreeTime, FreeTime). 
compareNext([H2|Tail], FirstFreeTime, FreeTime) :- 
        free(H2, SecondFreeTime), 
        meetCheck(FirstFreeTime,SecondFreeTime, CurrentSlot), 
        compareNext(Tail, CurrentSlot, FreeTime). 

getFreeTimes([H1|Tail], FreeTime) :- 
        free(H1, FirstFreeTime),
        compareNext(Tail, FirstFreeTime, FreeTime).

collection(FreeTime) :-  
        people(People),
        getFreeTimes(People, FreeTime).

people([ann, bob, dave]).

main :- findall(FreeTime, collection(FreeTime), FreeTimes),
        uniq(FreeTimes, Uniq),
        write(Uniq), nl, halt.        

:- initialization(main).
