:- use_module(library(lists),[contains1/2,delete/3]).

% Christmas Gift Exchange

couple(janine,john).
couple(michelle,kevin).
couple(kristen,liam).
couple(nicole,ryan).
couple(liane,oliver).

individual(A) :- couple(A,_);couple(_,A).

% Couples can't gift to each other
gift(A,B) :- individual(A),individual(B),\+couple(A,B),\+couple(B,A),A\=B.

draw_([],[],[]).
draw_(FROM,TO,[[A,B]|PAIRINGS]) :-
  gift(A,B),contains1(FROM,A),contains1(TO,B),
  delete(FROM,A,FROM_WITHOUT_A),delete(TO,B,TO_WITHOUT_B),
  draw_(FROM_WITHOUT_A,TO_WITHOUT_B,PAIRINGS).

% Avoid repeating previous draws:
% 2022
draw(_,[[janine,nicole],[john,kevin],[kevin,janine],[kristen,john],
  [liam,ryan],[liane,kristen],[michelle,liane],[nicole,oliver],
  [oliver,michelle],[ryan,liam]]) :- false.
% 2021
draw(_,[[janine,kristen],[john,ryan],[kevin,john],[kristen,oliver],
  [liam,kevin],[liane,janine],[michelle,liam],[nicole,michelle],
  [oliver,nicole],[ryan,liane]]) :- false.

% Run program using:
%  draw([janine,john,michelle,kevin,kristen,liam,nicole,ryan,liane,oliver],S).
draw(L,S) :- draw_(L,L,P),sort(P,S).
