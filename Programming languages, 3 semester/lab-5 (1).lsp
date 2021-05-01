;;; ������ ��� ���������� ������� ������������ ������ �5 
;;; ��� ����������� ����������� � ������ ����� ������ �������� �� ����� ������
;;; ������ ������������ ������� �����-���� ����� ������� �����
;;; ������� ������� ������ ���� ������� � ���������� ��� ����� ������� 

;;; ��������������� ����������� 
;;; ������ ������� ��������� � ��������� ����
;; ���������� �������������� (�.�. �������������� �������������
;; �������� �������� � ����� �������������� �� ������������� 
;; ����������� �������)
(declaim (sb-ext:muffle-conditions style-warning))

;; ������������ ���������� on-unknown-expression
;; ������� �������������� ��������� ��� ��������� 
;; ������������ ���������
(define-condition on-unknown-expression (error)
   ((message :initarg :message :reader message))
)

;;; ������� ������� 

;; ������� 1. ��������� ��� ���������
;; 0?
(defun 0? (x) (and (numberp x) (= x 0)))

;; 1?
(defun 1? (x) (and (numberp x) (= x 1)))

;; +?
(defun +? (l) (and (listp l) (eq (car l) '+)))

;; -?
(defun -? (l) (and (listp l) (eq (car l) '-) (not (null (cdr l)))))

;; *?
(defun *? (l) (and (listp l) (eq (car l) '*)))

;; /?
(defun /? (l) (and (listp l) (eq (car l) '/) (not (null (cdr l)))))

;; expt?
(defun expt? (l) (and (listp l) (eq (car l) 'expt) (= (length l) 3)))

;; sqrt?
(defun sqrt? (l) (and (listp l) (eq (car l) 'sqrt) (= (length l) 2)))

;; sin?
(defun sin? (l) (and (listp l) (eq (car l) 'sin) (= (length l) 2)))

;; cos?
(defun cos? (l) (and (listp l) (eq (car l) 'cos) (= (length l) 2)))

;; tan?
(defun tan? (l) (and (listp l) (eq (car l) 'tan) (= (length l) 2)))

;; asin?
(defun asin? (l) (and (listp l) (eq (car l) 'asin) (= (length l) 2)))

;; acos?
(defun acos? (l) (and (listp l) (eq (car l) 'acos) (= (length l) 2)))

;; atan?
(defun atan? (l) (and (listp l) (eq (car l) 'atan) (= (length l) 2)))

;; exp?
(defun exp? (l) (and (listp l) (eq (car l) 'exp) (= (length l) 2)))

;; log?
(defun log? (l) (and (listp l)
                     (eq (car l) 'log)
                     (or (= (length l) 2)
                         (= (length l) 3))))

;; ������� 2. ������������ ��� ���������
;; make+
(defun make+ (&rest l) (cons '+ l))

;; make-
(defun make- (x &rest l) (cons '- (cons x l)))

;; make*
(defun make* (&rest l) (cons '* l))

;; make/
(defun make/ (x &rest l) (cons '/ (cons x l)))

;; makeexpt
(defun makeexpt (l1 l2) (list 'expt l1 l2))

;; makesqrt
(defun makesqrt (l) (list 'sqrt l))

;; makesin
(defun makesin (l) (list 'sin l))

;; makecos
(defun makecos (l) (list 'cos l))

;; maketan
(defun maketan (l) (list 'tan l))

;; makeasin
(defun makeasin (l) (list 'asin l))

;; makeacos
(defun makeacos (l) (list 'acos l))

;; makeatan
(defun makeatan (l) (list 'atan l))

;; makeexp
(defun makeexp (l) (list 'exp l))

;; makelog
(defun makelog (a &optional b)
  (if (null b) (list 'log a) (list 'log a b)))

;; ������� 3. ������������ ���������
;; ��������� ������� ������ �������� ��� ���������
(defun normalize (expr)
  (cond
    ((atom expr) expr)
    ((+? expr) (+-normalize expr))
    ((-? expr) (--normalize expr))
    ((*? expr) (*-normalize expr))
    ((/? expr) (/-normalize expr))
    ((expt? expr) (expt-normalize expr))
    ((sqrt? expr) (sqrt-normalize expr))
    ((sin? expr) (sin-normalize expr))
    ((cos? expr) (cos-normalize expr))
    ((tan? expr) (tan-normalize expr))
    ((asin? expr) (asin-normalize expr))
    ((acos? expr) (acos-normalize expr))
    ((atan? expr) (atan-normalize expr))
    ((exp? expr) (exp-normalize expr))
    ((log? expr) (log-normalize expr))
    (T (error 'on-unknown-expression))))

;; +-normalize
(defun +-normalize (e)
  (cond ((null (cdr e)) 0)
        ((null (cddr e)) (normalize (cadr e)))
        (T (make+ (normalize (cadr e))
                  (normalize (cons '+ (cddr e)))))))

;; --normalize
(defun --normalize (e)
  (cond ((null (cddr e)) (make* -1 (cadr e)))
        (T (make+ (normalize (cadr e))
                  (make* -1 (normalize (cons '+ (cddr e))))))))

;; *-normalize
(defun *-normalize (e)
  (cond ((null (cdr e)) 1)
        ((null (cddr e)) (normalize (cadr e)))
        (T (make* (normalize (cadr e))
                  (normalize (cons '* (cddr e)))))))

;; /-normalize
(defun /-normalize (e)
  (cond ((null (cddr e)) (make/ (cadr e)))
        (T (make* (normalize (cadr e))
                  (make/ (normalize (cons '* (cddr e))))))))

;; expt-normalize
(defun expt-normalize (e)
  (makeexpt (normalize (cadr e))
            (normalize (caddr e))))

;; sqrt-normalize
(defun sqrt-normalize (e)
  (makeexpt (normalize (cadr e)) 1/2))

;; sin-normalize
(defun sin-normalize (e)
  (makesin (normalize (cadr e))))

;; cos-normalize
(defun cos-normalize (e)
  (makecos (normalize (cadr e))))

;; tan-normalize
(defun tan-normalize (e)
  (make* (makesin (normalize (cadr e)))
         (make/ (makecos (normalize (cadr e))))))

;; asin-normalize
 (defun asin-normalize (e)
  (makeasin (normalize (cadr e))))

;; acos-normalize
(defun acos-normalize (e)
  (makeacos (normalize (cadr e))))

;; atan-normalize
(defun atan-normalize (e)
  (makeatan (normalize (cadr e))))

;; exp-normalize
(defun exp-normalize (e)
  (makeexp (normalize (cadr e))))

;; log-normalize
(defun log-normalize (e)
  (if (null (cddr e)) (makelog (normalize (cadr e)))
      (make* (makelog (normalize (cadr e)))
             (make/ (makelog (normalize (caddr e)))))))

;; ��������� ���������
;; ��������� ������� ������ �������� ��� ���������
(defun simplify (expr)
  (let ((expr (normalize expr)))
    (cond 
      ((atom expr) expr)
      ((+? expr) (simplify+ expr))
      ((*? expr) (simplify* expr))
      ((/? expr) (simplify/ expr))
      ((expt? expr) (simplifyexpt expr))
      ((sin? expr) (simplify-fun-1 expr))
      ((cos? expr) (simplify-fun-1 expr))
      ((asin? expr) (simplify-fun-1 expr))
      ((acos? expr) (simplify-fun-1 expr))
      ((atan? expr) (simplify-fun-1 expr))
      ((exp? expr) (simplifyexp expr))
      ((log? expr) (simplifylog expr))
      (T (error 'on-unknown-expression)))))

;; ������� 4. ��������� ��������
;; simplify+

;; simplify+-aux1

;; simplify+-aux2

;; ������� 5. ��������� ���������
;; simplify*

;; simplify*-through+

;; simplify*-aux1

;; simplify*-aux2

;; ������� 6. ��������� ��������� �������� (�������� �������)
;; simplify/

;; simplify/-through*

;; ������� 7. ��������� ���������� � �������
;; simplifyexpt

;; ������� 8. ��������� ��������� �������
;; simplify-fun-1

;; simplifyexp

;; simplifylog

;; ����������� ���������
;; ��������� ������� ������ �������� ��� ���������
(defun deriv (expr var) 
  (cond 
    ((atom expr) (if (eq expr var) 1 0))  
    ((+? expr) (+-deriv expr var))
    ((*? expr) (*-deriv expr var))
    ((/? expr) (/-deriv expr var))
    ((expt? expr) (expt-deriv expr var))
    ((sin? expr) (sin-deriv expr var))
    ((cos? expr) (cos-deriv expr var))
    ((asin? expr) (asin-deriv expr var))
    ((acos? expr) (acos-deriv expr var))
    ((atan? expr) (atan-deriv expr var))
    ((exp? expr) (exp-deriv expr var))
    ((log? expr) (log-deriv expr var))
    (T (error 'on-unknown-expression))))

;; ������� 9. ����������� ����� 
;; +-deriv

;; ������� 10. ����������� ������������
;; *-deriv

;; ������� 11. ����������� ��������� ��������
;; /-deriv

;; ������� 12. ����������� ��������� �������
;; expt-deriv

;; ������� 13. ����������� ������������������ �������
;; sin-deriv

;; cos-deriv

;; ������� 14. ����������� �������� ������������������ �������
;; asin-deriv

;; acos-deriv

;; atan-deriv

;; ������� 15. ����������� ���������� � ������������ ���������
;; exp-deriv

;; log-deriv
