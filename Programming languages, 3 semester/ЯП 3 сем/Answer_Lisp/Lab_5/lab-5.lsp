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
(defun 0? (x) 
  (cond ((numberp x) (= x 0))))

(defun 1? (x) 
  (cond ((numberp x) (= x 1))))

(defun +? (expr) 
  (cond ((listp expr) (eq (car expr) '+))))

(defun -? (expr) 
  (cond ((listp expr) 
         (cond ((eq (car expr) '-) 
                (> (length (cdr expr)) 0))))))

(defun *? (expr) 
  (cond ((listp expr) (eq (car expr) '*))))

(defun /? (expr) 
  (cond ((listp expr) 
         (cond ((eq (car expr) '/) 
                (> (length (cdr expr)) 0))))))

(defun expt? (expr) 
  (cond ((listp expr) 
        (cond ((eq (car expr) 'expt)
               (= (length (cdr expr)) 2))))))

(defun sqrt? (expr) 
  (cond ((listp expr) 
         (cond ((eq (car expr) 'sqrt)
                (= (length (cdr expr)) 1))))))

(defun sin? (expr) 
  (cond ((listp expr) 
         (cond ((eq (car expr) 'sin)
                (= (length (cdr expr)) 1))))))

(defun cos? (expr) 
  (cond ((listp expr) 
         (cond ((eq (car expr) 'cos)
                (= (length (cdr expr)) 1))))))

(defun tan? (expr) 
  (cond ((listp expr) 
         (cond ((eq (car expr) 'tan)
                (= (length (cdr expr)) 1))))))

(defun asin? (expr) 
  (cond ((listp expr) 
         (cond ((eq (car expr) 'asin)
                (= (length (cdr expr)) 1))))))

(defun acos? (expr) 
  (cond ((listp expr) 
         (cond ((eq (car expr) 'acos)
                (= (length (cdr expr)) 1))))))

(defun atan? (expr) 
  (cond ((listp expr) 
         (cond ((eq (car expr) 'atan)
                (= (length (cdr expr)) 1))))))

(defun exp? (expr) 
  (cond ((listp expr) 
         (cond ((eq (car expr) 'exp)
                (= (length (cdr expr)) 1))))))

(defun log? (expr) 
  (cond ((listp expr) 
         (cond ((eq (car expr) 'log)
                (cond ((> (length (cdr expr)) 0)
                       (< (length (cdr expr)) 3))))))))

;; Задание 2. Конструкторы для выражений
(defun make+ (&rest x) (append '(+) x))

(defun make- (y &rest x) (append (list '- y) x))

(defun make* (&rest x) (append '(*) x))

(defun make/ (y &rest x) (append (list '/ y) x))

(defun makeexpt (x y) (list 'expt x y))

(defun makesqrt (x) (list 'sqrt x))

(defun makesin (x) (list 'sin x))

(defun makecos (x) (list 'cos x))

(defun maketan (x) (list 'tan x))

(defun makeasin (x) (list 'asin x))

(defun makeacos (x) (list 'acos x))

(defun makeatan (x) (list 'atan x))

(defun makeexp (x) (list 'exp x))

(defun makelog (x &optional y) (if (null y) 
                                   (list 'log x) 
                                   (list 'log x y)))

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
  (let ((len (length (cdr expr))))
    (if (= len 0) 0 
        (if (= len 1) 
            (normalize (cadr expr)) 
            (make+ (normalize (cadr expr)) 
              (normalize (append '(+) (cddr expr))))))))

;; --normalize
(defun --normalize (expr)
  (if (= (length (cdr expr)) 1) 
      (make* -1 (normalize (cadr expr)))
      (make+ (normalize (cadr expr))
             (make* -1 (normalize (append '(+) (cddr expr)))))))

;; *-normalize
(defun *-normalize (expr) 
  (let ((len (length (cdr expr))))
    (if (= len 0) 1 
        (if (= len 1) (normalize (cadr expr)) 
            (make* (normalize (cadr expr)) 
              (normalize (append '(*) (cddr expr))))))))

;; /-normalize
(defun /-normalize (expr)
  (let ((len (length (cdr expr))))
    (if (= len 1) (make/ (normalize (cadr expr)))
        (make* (normalize (cadr expr))
        (if (= len 2) 
            (make/ (make* (normalize (caddr expr))))
            (make/ (normalize (append '(*) (cddr expr)))))))))

;; expt-normalize
(defun expt-normalize (expr)
  (makeexpt (normalize (cadr expr)) (normalize (caddr expr))))

;; sqrt-normalize
(defun sqrt-normalize (expr)
  (makeexpt (normalize (cadr expr)) (/ 1 2)))

;; sin-normalize
(defun sin-normalize (expr)
  (makesin (normalize (cadr expr))))

;; cos-normalize
(defun cos-normalize (expr)
  (makecos (normalize (cadr expr))))

;; tan-normalize
(defun tan-normalize (expr)
  (let ((e (normalize (cadr expr))))
    (make* (makesin e) (make/ (makecos e)))))

;; asin-normalize
(defun asin-normalize (expr)
  (makeasin (normalize (cadr expr))))

;; acos-normalize
(defun acos-normalize (expr)
  (makeacos (normalize (cadr expr))))

;; atan-normalize
(defun atan-normalize (expr)
  (makeatan (normalize (cadr expr))))

;; exp-normalize
(defun exp-normalize (expr)
  (makeexp (normalize (cadr expr))))

;; log-normalize
(defun log-normalize (expr)
  (cond
    ((null (caddr expr)) expr)
    (T (make* (makelog (normalize (cadr expr))) 
         (make/ (makelog (normalize (caddr expr))))))))

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
  (let ((sum1 (simplify (cadr expr)))
        (sum2 (simplify (caddr expr))))
    (cond
      ((0? sum1) sum2)
      ((0? sum2) sum1)
      ((numberp sum1) (simplify+-aux1 sum2 sum1))
      ((numberp sum2) (simplify+-aux1 sum1 sum2))
      ((+? sum1) (simplify+-aux2 sum2 sum1))
      ((+? sum2) (simplify+-aux2 sum1 sum2))
      (T (make+ sum1 sum2)))))

;; simplify+-aux1
(defun simplify+-aux1 (expr n)
  (cond
    ((numberp expr) (+ expr n))
    ((+? expr) (if (numberp (cadr expr)) 
                   (append '(+) (list (+ (cadr expr) n)) (cddr expr)) 
                   (append '(+) (list n) (cdr expr))))
    (T (make+ n expr))))

;; simplify+-aux2
(defun simplify+-aux2 (expr +expr)
  (cond
    ((numberp expr) (simplify+-aux1 +expr expr))
    ((+? expr) (cond
                 ((numberp (cadr expr)) 
                    (simplify+-aux1 (append +expr (cddr expr)) (cadr expr)))
                 ((numberp (cadr +expr)) 
                    (simplify+-aux1 (append expr (cddr +expr)) (cadr +expr)))
                 (T (append '(+) (cdr expr) (cdr +expr)))))
    (T (append +expr (list expr)))))

;; Задание 5. Упрощение умножения
;; simplify*
(defun simplify* (expr)
  (let ((factor1 (simplify (cadr expr)))
        (factor2 (simplify (caddr expr))))
    (cond
      ((0? factor1) 0)
      ((0? factor2) 0)
      ((1? factor1) factor2)
      ((1? factor2) factor1)
      ((numberp factor1) (simplify*-aux1 factor2 factor1))
      ((numberp factor2) (simplify*-aux1 factor1 factor2))
      ((*? factor1) (simplify*-aux2 factor2 factor1))
      ((*? factor2) (simplify*-aux2 factor1 factor2))
      ((and (/? factor1) (equal (cadr factor1) factor2)) 1)
      ((and (/? factor2) (equal (cadr factor2) factor1)) 1)
      ((+? factor1) (simplify (append '(+) (simplify*-through+ 
                                       (cdr factor1) 
                                       factor2))))
      ((+? factor2) (simplify (append '(+) (simplify*-through+ 
                                       (cdr factor2) 
                                       factor1))))
      (T (make* factor1 factor2)))))

;; simplify*-through+
(defun simplify*-through+ (exprs n)
  (let ((x (car exprs)))
    (cond
      ((eq x NIL) NIL)
      (T (append (list (make* n x)) 
                 (simplify*-through+ (cdr exprs) n))))))

;; simplify*-aux1
(defun simplify*-aux1 (expr n)
  (cond
    ((numberp expr) (* expr n))
    ((*? expr) (if (numberp (cadr expr)) 
                   (append '(*) (list (* (cadr expr) n)) (cddr expr)) 
                   (append '(*) (list n) (cdr expr))))
    ((+? expr) (simplify (append '(+) (simplify*-through+ (cdr expr) n))))
    (T (make* n expr))))

;; simplify*-aux2
(defun simplify*-aux2 (expr *expr)
  (cond
    ((numberp expr) (simplify*-aux1 *expr expr))
    ((*? expr) (cond
                 ((numberp (cadr expr)) 
                    (simplify*-aux1 (append *expr (cddr expr)) (cadr expr)))
                 ((numberp (cadr *expr)) 
                    (simplify*-aux1 (append expr (cddr *expr)) (cadr *expr)))
                 (T (append '(*) (cdr expr) (cdr *expr)))))
    ((+? expr) (simplify (append '(+) (simplify*-through+ (cdr expr) *expr))))
    (T (append *expr (list expr)))))


;; Задание 6. Упрощение обратного элемента (унарного деления)
;; simplify/
(defun simplify/ (expr)
  (let ((expr (simplify (cadr expr))))
    (cond
      ((numberp expr) (/ expr))
      ((/? expr) (cadr expr))
      ((*? expr) (simplify (append '(*) (simplify/-through* (cdr expr)))))
      (T (make/ expr)))))

;; simplify/-through*
(defun simplify/-through* (exprs)
  (let ((x (car exprs)))
    (cond
      ((eq x NIL) NIL)
      (T (append (list (make/ x)) (simplify/-through* (cdr exprs)))))))


;; Задание 7. Упрощение возведения в степень
;; simplifyexpt
(defun simplifyexpt (expr)
  (let ((par1 (simplify (cadr expr)))
        (par2 (simplify (caddr expr))))
    (cond
      ((0? par2) 1)
      ((0? par1) 0)
      ((1? par1) 1)
      ((1? par2) par1)
      ((and (numberp par1) (numberp par2)) (expt par1 par2))
      ((expt? par1) (simplify (makeexpt (cadr par1) 
                                        (make* (caddr par1) par2))))
      ((exp? par1) (simplify (makeexp (make* (cadr par1) par2))))
      (T (makeexpt par1 par2)))))

;; Задание 8. Упрощение остальных функций
;; simplify-fun-1
(defun simplify-fun-1 (expr)
  (let* ((par (simplify (cadr expr)))
         (expr (append (list (car expr)) (list par))))
    (cond
      ((numberp par) (eval expr))
      (T expr))))

;; simplifyexp
(defun simplifyexp (expr)
  (let* ((par (simplify (cadr expr)))
         (expr (append (list (car expr)) 
                       (list par))))
    (cond
      ((numberp par) (eval expr))
      ((log? par) (cadr par))
      (T expr))))

;; simplifylog
(defun simplifylog (expr)
  (let ((par (simplify (cadr expr))))
    (cond
      ((numberp par) (log par))
      ((exp? par) (cadr par))
      ((expt? par) 
        (simplify (make* (caddr par) 
                         (makelog (cadr par)))))
      (T (makelog par)))))

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
  (let ((u (cadr expr)) (v (caddr expr)))
    (make+ (make* (deriv u x) v)
           (make* (deriv v x) u))))

;; Задание 11. Производная обратного элемента
;; /-deriv
(defun /-deriv (expr x)
  (let ((u (cadr expr)))
    (make* (make- (make/ (makeexpt u 2))) 
                  (deriv u x))))

;; Задание 12. Производная степенной функции
;; expt-deriv
(defun expt-deriv (expr x)
  (let ((u (cadr expr)) (v (caddr expr)))
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
(defun exp-deriv (expr var)
  (let ((u (cadr expr)))
    (make* (makeexp u) 
           (deriv u var))))

;; log-deriv
(defun log-deriv (expr var)
  (let ((u (cadr expr)))
    (make* (make/ u) 
           (deriv u var))))