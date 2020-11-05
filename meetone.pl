#!/bin/gprolog --consult-file

:- include('data.pl').

% Your code goes here.
slot(time, time) :- free
meetone

main :- findall(Person,
		meetone(Person,slot(time(8,30,am),time(8,45,am))), People),
		write(People), nl, halt.

:- initialization(main).

% Need to print names of people who can meet

% Would print Ann, Carla and Dave for 8:30-8:45