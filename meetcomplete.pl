:- include('data.pl').
:- include('uniq.pl').




lte(time(_,_,am), time(_,_,pm)). % Does not test rest if a.m and p.m do are not true

lte(time(Hour1,_,ID),time(Hour2, _,ID)) :-
		Hour1<Hour2.	% Hours matching have greater precedence than minutes

lte(time(Hour,Min1,ID), time(Hour, Min2, ID)) :-
		Min1=<Min2.    % Minutes are the last check


overlap(slot(FirstStart,FirstEnd),slot(SecondStart,SecondEnd),slot(SecondStart,SecondEnd)) :- % Overlap inside
        lte(FirstStart,SecondStart), % Do the beginnings overlap?
        lte(SecondStart,FirstEnd), % Overlap between start of second and end of first?
        lte(SecondEnd,FirstEnd), % overlap for first time slot extends past end of second slot
        SecondStart\==SecondEnd. % Ensure no meeting time of length 0

overlap(slot(FirstStart,FirstEnd),slot(SecondStart,SecondEnd),slot(SecondStart,FirstEnd)) :-  % Overlap with 2nd end time outside
        lte(FirstStart,SecondStart), % Does the beginning overlap?
        lte(SecondStart,FirstEnd), % Is there overlap between the start of second and the end of first?
        lte(FirstEnd,SecondEnd), % Is there overlap for the end?
        SecondStart\==FirstEnd. % Ensure no meeting time of length 0

meetCheck(FirstFreeTime,SecondFreeTime,SharedSlot) :- % Check for Free times that make overlap true and store in sharedslot
        overlap(FirstFreeTime,SecondFreeTime,SharedSlot).

meetCheck(FirstFreeTime,SecondFreeTime,SharedSlot) :-
        overlap(SecondFreeTime,FirstFreeTime,SharedSlot). % Check for Free times that make overlap true and store in sharedslot

compareNext([], FreeTime, FreeTime). % Use recursion to compare head with each head in tail
compareNext([H2|Tail], FirstFreeTime, FreeTime) :- % compare current with next
        free(H2, SecondFreeTime), % Get free times for next
        meetCheck(FirstFreeTime,SecondFreeTime, CurrentSlot), % populate currentSlot with list of valid meeting times
        compareNext(Tail, CurrentSlot, FreeTime). % Compare with head with next person's time slot

getFreeTimes([H1|Tail], FreeTime) :- 
        free(H1, FirstFreeTime), % Get Free times for Head of List
        compareNext(Tail, FirstFreeTime, FreeTime). % Compare Head with rest of list

collection(FreeTime) :-  
        people(People), % People are the list fact of people defined prior
        getFreeTimes(People, FreeTime). % Get and Compare Freetimes

people([ann, bob, carla]). % List containing people who's time slots should be checked

main :- findall(FreeTime, collection(FreeTime), FreeTimes), % Propogate a list called `Freetimes` containing solutions to FreeTime
        uniq(FreeTimes, Uniq),
        write(Uniq), nl, halt.        

:- initialization(main).
