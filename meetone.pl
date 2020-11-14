#!/bin/gprolog --consult-file

:- include('data.pl').

% Your code goes here.

free(Person,slot(time(_,_,_), time(_,_,_)))

lte(time(_,_, am), time(_,_, pm)).

lte(time(Hour1,_,_), time(Hour2, _,_)) :-
Hour1 < Hour2.

lte(time(_,Min1,_), time(_, Min2, _)) :-
Min1 =< Min2.


meetone(Person,slot(TimeSeg1, TimeSeg2)) :- 
		free(Person,slot(TimeSeg1,TimeSeg2)),
		lte(TimeSeg1,TimeSeg2), lte(TimeSeg1, TimeSeg2).



main :- findall(Person,
		meetone(Person,slot(time(8,30,am),time(8,45,am))), People),
		write(People), nl, halt.

:- initialization(main).

% Need to print names of people who can meet

% Would print Ann, Carla and Dave for 8:30-8:45