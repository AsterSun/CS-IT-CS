(print
  (let ((2nd (cons 'B ()))
        (5th (cons 'C
                   (cons 'D
                         (cons (cons 'E ()) 
                               ()))))
        (6th (cons 'F
                   (cons ()
                         (cons 
                           (cons 'X 
                                 (cons () ())) 
                           ())))))
    (cons 'A
          (cons 2nd
                (cons ()
                      (cons ()
                            (cons 5th
                                  (cons 6th
                                        (cons 'G 
                                              (cons 'H ()))))))))))