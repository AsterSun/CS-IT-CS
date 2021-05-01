;((A B C) (D E (F X) G) H)

(print
  (cons 
    (cons 'A
          (cons 'B
                (cons 'C ())))
    (cons
      (cons 'D
            (cons 'E
                  (cons
                    (cons 'F
                          (cons 'X ()))
                    (cons 'G ()))))
      (cons 'H ()))))