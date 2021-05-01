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
(defun 0? (q) (and (numberp q) (zerop q)))

;; 1?
(defun 1? (q) (and (numberp q) (= q 1)))

;; +?
(defun +? (f) (and (listp f) (eq (car f) '+)))

;; -?
(defun -? (f) (and (listp f) (eq (car f) '-) (>= (length f) 2)))

;; *?
(defun *? (f) (and (listp f) (eq (car f) '*)))

;; /?
(defun /? (f) (and (listp f) (eq (car f) '/) (>= (length f) 2)))

;; expt?
(defun expt? (f) (and (listp f) (eq (car f) 'expt) (= (length f) 3)))

;; sqrt?
(defun sqrt? (f) (and (listp f) (eq (car f) 'sqrt) (= (length f) 2)))

;; sin?
(defun sin? (f) (and (listp f) (eq (car f) 'sin) (= (length f) 2)))

;; cos?
(defun cos? (f) (and (listp f) (eq (car f) 'cos) (= (length f) 2)))

;; tan?
(defun tan? (f) (and (listp f) (eq (car f) 'tan) (= (length f) 2)))

;; asin?
(defun asin? (f) (and (listp f) (eq (car f) 'asin) (= (length f) 2)))

;; acos?
(defun acos? (f) (and (listp f) (eq (car f) 'acos) (= (length f) 2)))

;; atan?
(defun atan? (f) (and (listp f) (eq (car f) 'atan) (= (length f) 2)))

;; exp?
(defun exp? (f) (and (listp f) (eq (car f) 'exp) (= (length f) 2)))

;; log?
(defun log? (f) (and (listp f)
                     (eq (car f) 'log)
                     (or (= (length f) 2) (= (length f) 3))))

;; ������� 2. ������������ ��� ���������
;; make+
(defun make+ (&rest c) (cons '+ c))

;; make-
(defun make- (x &rest c) (cons '- (cons x c)))

;; make*
(defun make* (&rest c) (cons '* c))

;; make/
(defun make/ (x &rest c) (cons '/ (cons x c)))

;; makeexpt
(defun makeexpt (x y) (list 'expt x y))

;; makesqrt
(defun makesqrt (x) (list 'sqrt x))

;; makesin
(defun makesin (x) (list 'sin x))

;; makecos
(defun makecos (x) (list 'cos x))

;; maketan
(defun maketan (x) (list 'tan x))

;; makeasin
(defun makeasin (x) (list 'asin x))

;; makeacos
(defun makeacos (x) (list 'acos x))

;; makeatan
(defun makeatan (x) (list 'atan x))

;; makeexp
(defun makeexp (x) (list 'exp x))



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
(defun +-normalize (expr)
  (let ((len (length expr)))
       (cond ((1? len) 0)
             ((= len 2) (normalize (cadr expr)))
             (T (make+ (normalize (cadr expr)) (+-normalize (cdr expr)))))))

;; --normalize
(defun --normalize (expr)
  (let ((len (length expr)))
    (cond ((= len 2) (make* -1 (normalize (cadr expr))))
          (T (make+ (normalize (cadr expr))
          (make* -1 (+-normalize (cdr expr))))))))

;; *-normalize
(defun *-normalize (expr)
  (let ((len (length expr)))
    (cond ((1? len) 1)
          ((= len 2) (normalize (cadr expr)))
          (T (make* (normalize (cadr expr)) (*-normalize (cdr expr)))))))

;; /-normalize
(defun /-normalize (expr)
  (let ((len (length expr)))
    (cond ((= len 2) (make/ (normalize (cadr expr))))
          (T (make* (normalize (cadr expr))
          (make/ (*-normalize (cdr expr))))))))

;; expt-normalize
(defun expt-normalize (expr) (makeexpt (normalize (cadr expr))
                                       (normalize (caddr expr))))

;; sqrt-normalize
(defun sqrt-normalize (expr) (makeexpt (normalize (cadr expr)) (/ 1 2)))

;; sin-normalize
(defun sin-normalize (expr) (makesin (normalize (cadr expr))))

;; cos-normalize
(defun cos-normalize (expr) (makecos (normalize (cadr expr))))

;; tan-normalize
(defun tan-normalize (expr)
  (let ((norm (normalize (cadr expr))))
       (make* (makesin norm) (make/ (makecos norm)))))

;; asin-normalize
(defun asin-normalize (expr) (makeasin (normalize (cadr expr))))

;; acos-normalize
(defun acos-normalize (expr) (makeacos (normalize (cadr expr))))

;; atan-normalize
(defun atan-normalize (expr) (makeatan (normalize (cadr expr))))

;; exp-normalize
(defun exp-normalize (expr) (makeexp (normalize (cadr expr))))

;; log-normalize
(defun log-normalize (expr)
  (cond
    ((= (length expr) 3) (make* (makelog (normalize (cadr expr)))
                         (make/ (makelog (normalize (caddr expr))))))
                         (T (makelog (normalize (cadr expr))))))

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
(defun +-deriv (expr x) (make+ (deriv (cadr expr) x) (deriv (caddr expr) x)))

;; ������� 10. ����������� ������������
;; *-deriv

;; ������� 11. ����������� ��������� ��������
;; /-deriv

(defun /-deriv (expr x)
  (let ((u (cadr expr)))
    (make- (make* (make/ (makeexpt u 2)) (deriv u x)))))

;; ������� 12. ����������� ��������� �������
;; expt-deriv

;; ������� 13. ����������� ������������������ �������
;; sin-deriv
(defun sin-deriv (expr x)
  (let ((u (cadr expr)))
    (make* (deriv u x) (makecos u))))

;; cos-deriv
(defun cos-deriv (expr x)
  (let ((u (cadr expr)))
    (make- (make* (deriv u x) (makesin u)))))

;; ������� 14. ����������� �������� ������������������ �������
;; asin-deriv

;; acos-deriv
(defun acos-deriv (expr x)
  (let ((u (cadr expr)))
    (make- (make* (deriv u x) (make/ (makesqrt (make- 1 (makeexpt u 2))))))))

;; atan-deriv
(defun atan-deriv (expr x)
  (let ((u (cadr expr)))
    (make* (deriv u x) (make/ (makesqrt (make+ 1 (makeexpt u 2)))))))

;; ������� 15. ����������� ���������� � ������������ ���������
;; exp-deriv
(defun exp-deriv (expr x)
  (let ((u (cadr expr)))
    (make* (makeexp u) (deriv u x))))

;; log-deriv
