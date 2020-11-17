:- include('data.pl').
:- include('uniq.pl').



free(Person,slot(time(hour1,min1,id1),time(hour2,min1,id2))). % Check for Person with Hour, Minute and Miday

lte(time(_,_,am), time(_,_,pm)).

lte(time(Hour1,_,ID),time(Hour2, _,ID)) :-
		Hour1<Hour2.	% Ensure that Hour1 is less than Hour2

lte(time(Hour,Min1,ID), time(Hour, Min2, ID)) :-
		Min1=<Min2.    % Ensure that Min1 is less than or equal to Min2


overlap(slot(FirstStart,FirstEnd),slot(SecondStart,SecondEnd),slot(SecondStart,SecondEnd)) :- %match
        lte(FirstStart,SecondStart),
        lte(SecondStart,FirstEnd),
        lte(FirstEnd,SecondEnd),
        lte(SecondEnd,FirstEnd),
        SecondEnd\=FirstEnd,
        FirstStart\==SecondEnd.

meetCheck(FirstFreeTime,SecondFreeTime,SharedSlot) :-
        overlap(FirstFreeTime,SecondFreeTime,SharedSlot).

meetCheck(FirstFreeTime,SecondFreeTime,SharedSlot) :-
        overlap(SecondFreeTime,FirstFreeTime,SharedSlot).

compareNext([], FreeTime, FreeTime). % meetcollect
compareNext([H2|Tail], FirstFreeTime, FreeTime) :- % args are FreeTimes
        free(H2, SecondFreeTime), % Next person's free time
        meetCheck(FirstFreeTime,SecondFreeTime, CurrentSlot), % check if free times have overlap
        compareNext(Tail, CurrentSlot, FreeTime). % Pass rest of the list with recursion

getFreeTimes([H1|Tail], FreeTime) :- %meetTimes
        free(H1, FirstFreeTime),
        compareNext(Tail, FirstFreeTime, FreeTime).

collection(FreeTime) :-   % meet
        people(People),
        getFreeTimes(People, FreeTime).

people([ann, bob, dave]).

main :- findall(FreeTime, collection(FreeTime), FreeTimes),
        uniq(FreeTimes, Uniq),
        write(Uniq), nl, halt.        

:- initialization(main).
