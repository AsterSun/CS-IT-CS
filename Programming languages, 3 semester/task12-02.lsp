(defun del-sublist (l n &optional new-l (cur-depth-num n) (res NIL))
  (if (null l)
      (if (= cur-depth-num 0) res
          (del-sublist new-l n () (- cur-depth-num 1)))
      (let ((el (car l)))
        (cond 
          ((atom el)
             (del-sublist (cdr l)
                          n
                          new-l
                          cur-depth-num
                          (append res new-l)))
          ((listp el)
             (del-sublist (cdr l)
                          n
                          (append el new-l) 
                          cur-depth-num
                          res))))))

(print (del-sublist '(1 (1 (1 1))) 1))
