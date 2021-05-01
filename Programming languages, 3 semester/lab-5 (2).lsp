;;; Шаблон для выполнения заданий Лабораторной работы №5 
;;; ВСЕ КОММЕНТАРИИ ПРИВЕДЕННЫЕ В ДАННОМ ФАЙЛЕ ДОЛЖНЫ ОСТАТЬСЯ НА СВОИХ МЕСТАХ
;;; НЕЛЬЗЯ ПЕРЕСТАВЛЯТЬ МЕСТАМИ КАКИЕ-ЛИБО БЛОКИ ДАННОГО ФАЙЛА
;;; решения заданий должны быть вписаны в отведенные для этого позиции 

;;; ВСПОМОГАТЕЛЬНЫЕ ОПРЕДЕЛЕНИЯ 
;;; Нельзя вносить изменения в следующий блок
;; отключение предупреждений (т.к. предполагается использование
;; взаимной рекурсии и будут предупреждения об использовании 
;; неописанных функций)
(declaim (sb-ext:muffle-conditions style-warning))

;; определяется исключение on-unknown-expression
;; которое предполагается поднимать при получении 
;; неизвестного выражения
(define-condition on-unknown-expression (error)
   ((message :initarg :message :reader message))
)

;;; РЕШЕНИЕ ЗАДАНИЙ 

;; Задание 1. Предикаты для выражений
;; 0? 
(defun 0? (n) (and (numberp n) (zerop n)))
(defun 1? (n) (and (numberp n) (= n 1)))
;; +?
;; -?
(defun -? (l) (and (listp l) (eq (car l) '-) (> (length l) 1)))
(defun /? (l) (and (listp l) (eq (car l) '/) (> (length l) 1)))
;; *?
(defun +? (l) (and (listp l) (eq (car l) '+)))
(defun *? (l) (and (listp l) (eq (car l) '*)))
;; /?

;; expt?
(defun expt? (l) (and (listp l) (eq (car l) 'expt) (= (length l) 3)))
(defun sqrt? (l) (and (listp l) (eq (car l) 'sqrt) (= (length l) 2)))
(defun sin? (l) (and (listp l) (eq (car l) 'sin) (= (length l) 2)))
(defun cos? (l) (and (listp l) (eq (car l) 'cos) (= (length l) 2)))
(defun tan? (l) (and (listp l) (eq (car l) 'tan) (= (length l) 2)))
(defun asin? (l) (and (listp l) (eq (car l) 'asin) (= (length l) 2)))
(defun acos? (l) (and (listp l) (eq (car l) 'acos) (= (length l) 2)))
(defun atan? (l) (and (listp l) (eq (car l) 'atan) (= (length l) 2)))
(defun exp? (l) (and (listp l) (eq (car l) 'exp) (= (length l) 2)))
;; log?
(defun log? (l) 
  (and (listp l) (eq (car l) 'log) 
    (let ((len (length l)))
      (and (> len 1) (< len 4)))))

;; Задание 2. Конструкторы для выражений
(defun make+ (&rest l) (cons '+ l))
(defun make* (&rest l) (cons '* l))
(defun make- (a &rest l) (cons '- (cons a l)))
(defun make/ (a &rest l) (cons '/ (cons a l)))
(defun makeexpt (a b) (list 'expt a b))
(defun makesqrt (l) (list 'sqrt l))
(defun makesin (l) (list 'sin l))
(defun makecos (l) (list 'cos l))
(defun maketan (l) (list 'tan l))
(defun makeasin (l) (list 'asin l))
(defun makeacos (l) (list 'acos l))
(defun makeatan (l) (list 'atan l))
(defun makeexp (l) (list 'exp l))
;; makelog
(defun makelog (a &optional b) 
  (if b (list 'log a b) (list 'log a)))

;; Задание 3. НОРМАЛИЗАЦИЯ ВЫРАЖЕНИЙ
;; Следующая функция должна остаться без изменений
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
  (cond ((null (cdr expr)) 0)
        ((null (cddr expr)) (normalize (cadr expr)))
        (T (make+ (normalize (cadr expr)) 
                  (normalize (cons '+ (cddr expr)))))))
(defun *-normalize (expr)
  (cond ((null (cdr expr)) 1)
        ((null (cddr expr)) (normalize (cadr expr)))
        (T (make* (normalize (cadr expr)) 
                  (normalize (cons '* (cddr expr)))))))
;; --normalize
(defun --normalize (expr)
  (if (null (cddr expr)) (make* -1 (normalize (cadr expr)))
      (make+ (normalize (cadr expr)) 
             (make* -1 (normalize (cons '+ (cddr expr)))))))

;; /-normalize
(defun /-normalize (expr)
  (if (null (cddr expr)) (make/ (normalize (cadr expr)))
      (make* (normalize (cadr expr))
             (make/ (normalize (cons '* (cddr expr)))))))

;; sqrt-normalize
(defun sqrt-normalize (expr)
  (makeexpt (normalize (cadr expr)) 1/2))
(defun tan-normalize (expr)
  (let ((arg (normalize (cadr expr))))
    (make* (makesin arg) (make/ (makecos arg)))))
(defun expt-normalize (expr)
  (makeexpt (normalize (cadr expr))
            (normalize (caddr expr))))
(defun sin-normalize (expr)
  (makesin (normalize (cadr expr))))
(defun cos-normalize (expr)
  (makecos (normalize (cadr expr))))
(defun asin-normalize (expr)
  (makeasin (normalize (cadr expr))))
(defun acos-normalize (expr)
  (makeacos (normalize (cadr expr))))
(defun atan-normalize (expr)
  (makeatan (normalize (cadr expr))))
(defun exp-normalize (expr)
  (makeexp (normalize (cadr expr))))
(defun log-normalize (expr)
  (let ((ln (makelog (normalize (cadr expr)))))
    (if (null (cddr expr)) ln
        (make* ln (make/ (makelog (normalize (caddr expr))))))))

;; УПРОЩЕНИЕ ВЫРАЖЕНИЙ
;; Следующая функция должна остаться без изменений
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

;; Задание 4. Упрощение сложения
;; simplify+
(defun simplify+ (expr)
  (let ((1st-arg (simplify (cadr expr)))
        (2nd-arg (simplify (caddr expr))))
    (cond 
      ((0? 1st-arg) 2nd-arg)
      ((0? 2nd-arg) 1st-arg)
      ((numberp 1st-arg) (simplify+-aux1 2nd-arg 1st-arg))
      ((numberp 2nd-arg) (simplify+-aux1 1st-arg 2nd-arg))
      ((+? 1st-arg) (simplify+-aux2 2nd-arg 1st-arg))
      ((+? 2nd-arg) (simplify+-aux2 1st-arg 2nd-arg))
      (T (make+ 1st-arg 2nd-arg)))))

;; simplify+-aux1
(defun simplify+-aux1 (expr n &optional (a (cadr expr))
                                        (b (cdr expr)))
  (cond
    ((+? expr)
        (if (numberp a)
            (cons '+ (cons (+ a n) 
                           (cdr b)))
            (cons '+ (cons n b))))
    ((numberp expr) 
      (+ expr n)))
    (T (make+ n expr)))

;; simplify+-aux2
(defun simplify+-aux2 (expr +expr &optional (a (cadr expr)) 
                                            (b (cddr expr))
                                            (a1 (cadr +expr)) 
                                            (b1 (cddr +expr)))
  (cond
    ((numberp expr) 
      (simplify+-aux1 +expr expr))
    ((and (numberp a) (+? expr))
      (simplify+-aux1 (append +expr b) a))
    ((and (numberp a1) (+? expr))
      (simplify+-aux1 (append expr b1) a1))
    ((+? expr) 
      (append expr (cdr +expr)))
    (T (append +expr (list expr)))))
;; Задание 5. Упрощение умножения
;; simplify*
(defun simplify* (expr &optional (a (simplify (cadr expr))) 
                                 (b (simplify (caddr expr))))
  (cond 
    ((or (0? a) 
         (0? b)) 
      0)
    ((1? a) 
      b)
    ((1? b) 
      a)
    ((numberp a) 
      (simplify*-aux1 b a))
    ((numberp b) 
      (simplify*-aux1 a b))
    ((*? a) 
      (simplify*-aux2 b a))
    ((*? b) 
      (simplify*-aux2 a b))
    ((and (eq (cadr a) b) (/? a))
      1)
    ((and (eq (cadr b) a) (/? b))
      1)
    ((+? a) 
      (simplify (make+ (simplify*-through+ (cdr a) b))))
    ((+? b) 
      (simplify (make+ (simplify*-through+ (cdr b) a))))
    (T (make* a b))))

;; simplify*-through+
(defun simplify*-through+ (expr n &optional (l (length expr)) 
                                            (a (car expr))
                                            (b (cdr expr)))
  (if (= 1 l)
      (list (make* n a))
      (cons (make* n a) 
            (simplify*-through+ b n))))

;; simplify*-aux1
(defun simplify*-aux1 (expr n &optional (a (cadr expr)))
  (cond
    ((numberp expr) 
      (* expr n))
    ((*? expr)
      (if (numberp a)
        (simplify (append (make* (* a n)) (cddr expr)))
        (append (make*) (cons n ()) (cdr expr))))
    ((+? expr) (simplify (cons '+ (simplify*-through+ (cdr expr) n))))
    (T (make* n expr))))


;; simplify*-aux2
(defun simplify*-aux2 (expr *expr &optional (a (cadr expr))
                                            (b (cadr *expr)))
  (cond 
    ((numberp expr) 
      (simplify*-aux1 *expr expr))
    ((+? expr)
     (simplify (cons '+ (simplify*-through+ (cdr expr) *expr))))
    ((*? expr) 
      (cond
        ((numberp b)
          (simplify*-aux1 (append expr (cddr *expr))b))
        ((numberp a)
          (simplify*-aux1 (append *expr (cddr expr))a))
        (T (append expr (cdr *expr))))))
  (T (append *expr (list expr))))

;; Задание 6. Упрощение обратного элемента (унарного деления)
;; simplify/
(defun simplify/ (expr &optional (a (simplify (cadr expr))))
  (cond
    ((numberp a) 
      (/ a))
    ((/? a) 
      (cadr a))
    ((*? a) 
      (simplify (cons '* (simplify/-through* (cdr a)))))
    (T (make/ a))))

;; simplify/-through*
(defun simplify/-through* (expr &optional (n (length expr)) 
                                          (a (car expr)) 
                                          (b (cdr expr)))
  (if (= 1 n)
      (list (make/ a))
      (cons (make/ a) 
            (simplify/-through* b))))

;; Задание 7. Упрощение возведения в степень
;; simplifyexpt
(defun simplifyexpt (expr &optional (a (simplify (cadr expr)))
                                    (b (simplify (caddr expr))))
  (cond
    ((0? a) 
      0)
    ((0? b) 
      1)
    ((1? a)
      1)
    ((1? b)
      a)
    ((and (numberp a) (numberp b)) 
      (expt a b))
    ((exp? a) 
      (simplify (makeexp (make* (cadr a) b))))
    ((expt? a) 
      (simplify (makeexpt (cadr a) (make* (caddr a) b))))
    (T (makeexpt a b))))

;; Задание 8. Упрощение остальных функций
(defun simplify-fun-1 (expr &optional (a (simplify (cadr expr)))
                                      (b (list (car expr) a)))
  (cond
    ((numberp a)
      (eval b))
      (T b)))

;; simplifyexp
(defun simplifyexp (expr &optional (a (simplify (cadr expr))) 
                                   (l (list 'exp a)))
  (cond
    ((log? a) 
      (cadr a))
    ((numberp a) 
      (eval l))
    (T l)))

;; simplifylog
(defun simplifylog (expr &optional (a (simplify (cadr expr))))
    (cond
      ((numberp a) 
        (log a))
      ((expt? a) 
        (simplify (make* (caddr a) (makelog (cadr a)))))
      ((exp? a) 
        (cadr a))
      (T (makelog a))))

;; ПРОИЗВОДНАЯ ВЫРАЖЕНИЯ
;; Следующая функция должна остаться без изменений
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

;; Задание 9. Производная суммы 
;; +-deriv
(defun +-deriv (expr x)
  (make+ (deriv (cadr expr) x) 
         (deriv (caddr expr) x)))

;; Задание 10. Производная произведения
;; *-deriv
(defun *-deriv (expr x &optional (l (cdr expr)) 
                                 (a (car l)) 
                                 (b (cadr l)))
  (make+ (make* (deriv a x) 
                b) 
         (make* (deriv b x) 
                a)))

;; Задание 11. Производная обратного элемента
;; /-deriv
(defun /-deriv (expr x &optional (a (cadr expr)))
  (make- (make* (makeexpt a -2) 
                (deriv a x))))

;; Задание 12. Производная степенной функции
;; expt-deriv
(defun expt-deriv (expr x &optional (a (cadr expr)) (b (caddr expr)))
  (make+ (make* b (make* (makeexpt a (make+ b -1)) 
                         (deriv a x)))
  (make* expr (make* (makelog a) 
                     (deriv b x)))))

;; Задание 13. Производные тригонометрических функций
;; sin-deriv
(defun sin-deriv (expr x &optional (a (cadr expr)))
  (make* (deriv a x) 
         (makecos a)))

;; cos-deriv
(defun cos-deriv (expr x &optional (a (cadr expr)))
  (make- (make* (deriv a x) 
                (makesin a))))

;; Задание 14. Производные обратных тригонометрических функций
;; asin-deriv
(defun asin-deriv (expr x &optional (a (cadr expr)))
  (make/ (deriv a x)
         (makesqrt (make- 1 (makeexpt a 2)))))

;; acos-deriv
(defun acos-deriv (expr x)
  (make- (deriv (makeasin 
                (cadr expr)) x)))

;; atan-deriv
(defun atan-deriv (expr x &optional (a (cadr expr)))
  (make/ (deriv a x)
         (makesqrt (make+ 1 (makeexpt a 2)))))

;; Задание 15. Производные экспоненты и натурального логарифма
;; exp-deriv
(defun exp-deriv (expr x &optional (a (cadr expr)))
  (make* (makeexp a)
         (deriv a x)))

;; log-deriv
(defun log-deriv (expr x &optional (a (cadr expr)))
  (make* (make/ a)
         (deriv a x)))