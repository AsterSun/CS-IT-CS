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
(defun 0? (n) (if (numberp n)
                  (zerop n)))

;; 1?
(defun 1? (n) (if (numberp n)
                  (= n 1)))

;; +?
(defun +? (lst) (if (consp lst) 
                    (equal (car lst) '+)))

;; -?
(defun -? (lst) (and (consp lst)
                     (equal (car lst) '-)
                     (> (length lst) 1)))

;; *?
(defun *? (lst) (and (consp lst)
                     (equal (car lst) '*)))

;; /?
(defun /? (lst) (and (consp lst)
                     (equal (car lst) '/)
                     (> (length lst) 1)))

;; expt?
(defun expt? (lst) (and (consp lst)
                        (equal (car lst) 'expt)
                        (= (length lst) 3)))

;; sqrt?
(defun sqrt? (lst) (and (consp lst)
                        (equal (car lst) 'sqrt)
                        (= (length lst) 2)))

;; sin?
(defun sin? (lst) (and (consp lst)
                       (equal (car lst) 'sin)
                       (= (length lst) 2)))

;; cos?
(defun cos? (lst) (and (consp lst)
                       (equal (car lst) 'cos)
                       (= (length lst) 2)))

;; tan?
(defun tan? (lst) (and (consp lst)
                       (equal (car lst) 'tan)
                       (= (length lst) 2)))

;; asin?
(defun asin? (lst) (and (consp lst)
                        (equal (car lst) 'asin)
                        (= (length lst) 2)))

;; acos?
(defun acos? (lst) (and (consp lst)
                        (equal (car lst) 'acos)
                        (= (length lst) 2)))

;; atan?
(defun atan? (lst) (and (consp lst)
                        (equal (car lst) 'atan)
                        (= (length lst) 2)))

;; exp?
(defun exp? (lst) (and (consp lst)
                       (equal (car lst) 'exp)
                       (= (length lst) 2)))

;; log?
(defun log? (lst)
  (and (consp lst)
       (eq (car lst) 'log)
    (let ((lngth (length lst)))
      (or (= lngth 2)
          (= lngth 3)))))

;; Задание 2. Конструкторы для выражений
(defun make+ (&rest lst) (cons '+ lst))

;; make-
(defun make- (x &rest lst) (cons '- (cons x lst)))

;; make*
(defun make* (&rest lst) (cons '* lst))

;; make/
(defun make/ (x &rest lst) (cons '/ (cons x lst)))

;; makeexpt
(defun makeexpt (x y) `(expt, x, y))

;; makesqrt
(defun makesqrt (lst) `(sqrt, lst))

;; makesin
(defun makesin (lst) `(sin, lst))

;; makecos
(defun makecos (lst) `(cos, lst))

;; maketan
(defun maketan (lst) `(tan, lst))

;; makeasin
(defun makeasin (lst) `(asin, lst))

;; makeacos
(defun makeacos (lst) `(acos, lst))

;; makeatan
(defun makeatan (lst) `(atan, lst))

;; makeexp
(defun makeexp (lst) `(exp, lst))

;; makelog
(defun makelog (x &optional y) (if y `(log, x, y) `(log, x)))

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
(defun +-normalize (e)
  (let ((lngth (length (cdr e))))
    (if (= lngth 0) 0
        (if (= lngth 1)
            (normalize (cadr e))
            (make+ (normalize (cadr e))
            (normalize (cons '+ (cddr e))))))))

;; --normalize
(defun --normalize (e)
  (if (= (length (cdr e)) 1)
      (make* -1 (normalize (cadr e)))
      (make+ (normalize (cadr e))
      (make* -1 (normalize (cons '+ (cddr e)))))))

;; *-normalize
(defun *-normalize (e)
  (let ((lngth (length (cdr e))))
    (if (= lngth 0) 1
        (if (= lngth 1)
            (normalize (cadr e))
            (make* (normalize (cadr e))
            (normalize (cons '* (cddr e))))))))

;; /-normalize
(defun /-normalize (e)
  (let ((lngth (length (cdr e))))
    (if (= lngth 1)
        (make/ (normalize (cadr e)))
        (if (= lngth 2)
            (make/ (make* (normalize (caddr e))))
            (make/ (normalize (cons '* (cddr e))))))))

;; expt-normalize
(defun expt-normalize (e)
  (makeexpt (normalize (cadr e))
            (normalize (caddr e))))

;; sqrt-normalize
(defun sqrt-normalize (e)
  (makeexpt (normalize (cadr e)) (/ 1 2)))

;; sin-normalize
(defun sin-normalize (e)
  (makesin (normalize (cadr e))))

;; cos-normalize
(defun cos-normalize (e)
  (makecos (normalize (cadr e))))

;; tan-normalize
(defun tan-normalize (e)
  (let ((x (normalize (cadr e))))
    (make* (makesin x) (make/ (makecos x)))))

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
  (let ((ln (makelog (normalize (cadr e)))))
    (if (null (cddr e)) ln
        (make* ln (make/ (makelog (normalize (caddr e))))))))

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
  (let ((e1 (simplify (cadr expr)))
        (e2 (simplify (caddr expr))))
  (cond
    ((0? e1) e2)
    ((0? e2) e1)
    ((numberp e1) (simplify+-aux1 e2 e1))
    ((numberp e2) (simplify+-aux1 e1 e2))
    ((+? e1) (simplify+-aux2 e2 e1))
    ((+? e2) (simplify+-aux2 e1 e2))
    (T (make+ e1 e2)))))

;; simplify+-aux1
(defun simplify+-aux1 (expr n)
  (cond
    ((numberp expr) (+ expr n))
    ((+? expr)
     (let ((e1 (cadr expr)))
       (if (numberp e1)
           (let ((summ (+ n e1)))
             (if (= 0 summ)
                 (cons '+ (cddr expr))
                 (cons '+ (cons summ (cddr expr)))))
           (cons '+ (cons n (cdr expr))))))
        (T (make+ n expr))))

;; simplify+-aux2
(defun simplify+-aux2 (expr +expr)
  (cond
    ((numberp expr) (simplify+-aux1 +expr expr))
    ((+? expr)
     (let ((e11 (cadr expr))
           (e22 (cadr +expr)))
      (cond
        ((numberp e11)
         (simplify+-aux1 (cons +expr (cddr expr)) e11))
        ((numberp e22)
         (simplify+-aux1 (cons expr (cddr +expr)) e22))
         (T (cons expr (cdr +expr))))))
    (T (cons +expr `(expr)))))

;; Задание 5. Упрощение умножения
;; simplify*

;; simplify*-through+

;; simplify*-aux1

;; simplify*-aux2

;; Задание 6. Упрощение обратного элемента (унарного деления)
;; simplify/

;; simplify/-through*

;; Задание 7. Упрощение возведения в степень
;; simplifyexpt

;; Задание 8. Упрощение остальных функций
;; simplify-fun-1

;; simplifyexp

;; simplifylog

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
(defun *-deriv (expr x)
  (let ((u (cadr expr))
        (v (caddr expr)))
    (make+ (make* (deriv u x) v)
           (make* (deriv v x) u))))

;; Задание 11. Производная обратного элемента
;; /-deriv
(defun /-deriv (expr x)
  (let ((u (cadr expr)))
    (make/ (make- (deriv u x))
           (make* u u))))

;; Задание 12. Производная степенной функции
;; expt-deriv
(defun expt-deriv (expr x)
  (let ((u (cadr expr))
        (v (caddr expr)))
    (make+ (make* v
                  (makeexpt u (make- v 1))
                  (deriv u x))
           (make* (makeexpt u v)
                  (deriv v x)
                  (makelog u)))))

;; Задание 13. Производные тригонометрических функций
;; sin-deriv
(defun sin-deriv (expr x)
  (let ((u (cadr expr)))
    (make* (deriv u x)
           (makecos u))))

;; cos-deriv
(defun cos-deriv (expr x)
  (let ((u (cadr expr)))
    (make* (make- (deriv u x))
           (makesin u))))

;; Задание 14. Производные обратных тригонометрических функций
;; asin-deriv
(defun asin-deriv (expr x)
  (let ((u (cadr expr)))
    (make/ (deriv u x) 
           (makesqrt (make- 1 (makeexpt u 2))))))

;; acos-deriv
(defun acos-deriv (expr x)
  (let ((u (cadr expr)))
    (make- (make/ (deriv u x) 
                  (makesqrt (make- 1 (makeexpt u 2)))))))

;; atan-deriv
(defun atan-deriv (expr x)
  (let ((u (cadr expr)))
    (make/ (deriv u x) 
           (makesqrt (make+ 1 (makeexpt u 2))))))

;; Задание 15. Производные экспоненты и натурального логарифма
;; exp-deriv
(defun exp-deriv (expr x)
  (let ((u (cadr expr)))
    (make* (makeexp u)
           (deriv u x))))

;; log-deriv
(defun log-deriv (expr x)
  (let ((u (cadr expr)))
    (make* (deriv u x)
           (make/ u))))