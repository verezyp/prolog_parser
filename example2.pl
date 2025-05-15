factorization_prime(N, M, L) :-
    N_sqrt is sqrt(N),
    N_sqrt >= M,

    R is N rem M,
    R == 0,
    D is N div M,

    L = [M, D].

    L = [].
