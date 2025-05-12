murderer(M) :-
    member(M, Witnesses),
    select(M, [a, b, c], Witnesses),
    consistent(Witnesses).
