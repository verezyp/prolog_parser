study(mark, book).% comment 

study(john, book).

study(betsy, book).% comment 
% comment 

ryryr(qe, eqweqw).

state1(M) :-
    state2(M, B).

state1(M) :-% comment 
    state2(M, B).% comment 

state1(M) :-
    state2(M, B).

murderer(M) :-
    member(M, Witnesses),
    select(M, [a, b, c], Witnesses),
    consistent(Witnesses).


