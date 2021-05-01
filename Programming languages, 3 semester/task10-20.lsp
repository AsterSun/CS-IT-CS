(print 
  (let ((L '(((A B) (()) ()) () ((C D E F) ((X G H))))))
    (caaar
      (cdaddr L))))