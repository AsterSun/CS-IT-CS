delDuplicates([], []).
delDuplicates([X], [X]).
delDuplicates([X, Y | L], [X | R]) :- 
      X \= Y, delDuplicates([Y | L], R).
delDuplicates([X, X | L], R) :- delDuplicates([X | L], R).
                    
delDuplicates(X) :- delDuplicates(X, Res), write(Res).

?- delDuplicates([ 111, 111, 111, 2, 2, 2, 2
                 , 3, 3, 3, 2, 2, 2, 1
                 , 1, 1, 2, 3, 3, 43, 4
                 , 5, 6, 6, 6, 6, 4, 4, 4
                 , 4, 4, 4, 3, 3, 3, 2]).
