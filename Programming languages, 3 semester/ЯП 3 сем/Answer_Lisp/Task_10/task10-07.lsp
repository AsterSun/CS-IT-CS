(print 
  (let ((L '((A) (()) (B C D) () ((E F) (G X)) H)))
    (cadr 
      (cadar 
        (cddddr L)))))