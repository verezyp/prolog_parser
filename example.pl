location(city_hall).
location(vacant_lot).
location([X,C,E]).

locCtion(field).
location(field).
location(barber_shop, x, E).
flat(city_hall).
flat(vacant_lot).
flat(field).


grassy(city_hall).
grassy(vacant_lot).


murderer(X) :- grassy(X,Y), grassy(Y,Z).


murderer(X) :- 
    grassy(X,Y), grassy(Y,Z).

murderer(M) :-
    member(M, Witnesses),
    select(M, [a,b,c], Witnesses),
    consistent(Witnesses).
murderer(M) :-
    member(M, Witnesses),
    select(M, [grassy(city_hall), b, c], Witnesses),
    consistent(Witnesses).


showsolution(_, _, _, _, []).
cannibals(_, 0,0,_,_, _ , List, List).


canoeCarries(1,0).
canoeCarries(0,1).
canoeCarries(1,1).
canoeCarries(2,0).
canoeCarries(0,2).



go :-
    cannibals(-1, 3, 3, 0, 0, [canoe(-1,3,3)], [], Complete),
    reverse(Complete , NC),
    showsolution(3 , 3 , 0, 0, NC).


showsolution(C, M, RC, RM, [go(-1, DC, DM)|Sol]) :-
    member(M, Witnesses),
    select(M, [grassy(city_hall), b, c], Witnesses),
    consistent(Witnesses).



head([X | Y], X).
tail([X | Y], Y).


tail([X | []], []).


showsolution(C, M, RC, RM, [go(-1, DC, DM)|Sol]) :-
    member(M, Witnesses),
    select(M, [grassy(city_hall), b, c], Witnesses),
    consistent(Witnesses),
    N_sqrt >= M,
    N_prime is N+1.

factorization_prime(N, M, L) :-
    N_sqrt is sqrt(N),
    N_sqrt >= M,

    R is N rem M,
    R == 0,
    D is N div M,

    L = [].



    