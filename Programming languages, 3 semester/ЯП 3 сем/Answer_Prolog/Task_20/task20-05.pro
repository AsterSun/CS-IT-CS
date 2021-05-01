jIter(N, _, N - 1, R, R) :- !.

jIter(N, Ni, Nj, R, R1) :- Njplus is Nj + 1
                         , R2 is R1 + cos(Ni) + sin(Njplus)
                         , jIter(N, Ni, Njplus, R, R2).

iter(N, N + 1, N - 1, R, R) :- !.

iter(N, Ni, Nj, R, R1) :- Niplus is Ni + 1 
                        , jIter(N, Niplus, Nj, R, R2)
                        , R2 is R1 + R2 
                        , iter(N, Niplus, Nj, R, R2).




y(N) :- iter(N, -2, 0, R, 0), writeln(R), !.

/*?- y(2).*/



