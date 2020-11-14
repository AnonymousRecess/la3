#!/bin/gprolog --consult-file

:- include('data.pl').


free(Person,slot(time(hour1,min1,id1),time(hour2,min1,id2))). % Check for Person with Hour, Minute and Miday

lte(time(_,_,am), time(_,_,pm)).

lte(time(Hour1,_,ID),time(Hour2, _,ID)) :-
		Hour1<Hour2.	% Ensure that Hour1 is less than Hour2

lte(time(Hour,Min1,ID), time(Hour, Min2, ID)) :-
		Min1=<Min2.    % Ensure that Min1 is less than or equal to Min2


meetone(Person,slot(Start, Finish)) :- 
		free(Person,slot(TimeSeg1,TimeSeg2)), % Check for free time
		lte(TimeSeg1,Start), lte(Finish, TimeSeg2).  % Check for overlap



main :- findall(Person,
		meetone(Person,slot(time(8,30,am),time(8,45,am))),
		People), % compile People with overlapping free time
		write(People), nl, halt. % print names of people who can meet

:- initialization(main).


% Would print Ann, Carla and Dave for 8:30-8:45