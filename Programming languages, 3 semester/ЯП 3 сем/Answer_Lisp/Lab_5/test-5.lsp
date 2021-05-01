;;; ПЕРВОНАЧАЛЬНЫЙ НАБОР ТЕСТОВ ДЛЯ ЛАБОРАТОРНОЙ РАБОТЫ №5
;;; по мере реализации решений заданий пополняйте их своими тестами

;;; ВСЕ КОММЕНТАРИИ ПРИВЕДЕННЫЕ В ДАННОМ ФАЙЛЕ 
;;; И ВЕСЬ ПЕРВОНАЧАЛЬНЫЙ НАБОР ТЕСТОВ ДОЛЖНЫ ОСТАТЬСЯ НА СВОИХ МЕСТАХ
;;; НЕЛЬЗЯ ПЕРЕСТАВЛЯТЬ МЕСТАМИ КАКИЕ-ЛИБО БЛОКИ ДАННОГО ФАЙЛА
;;; дополнительные тесты должны продолжать отведенные для них блоки
;;; тесов соответствующих функций
;;; вызовы (line) и (starline), выводящие разделительные линии для
;;; блоков тестов, должны остаться на своих местах 

;;; Для проведения тестов запустите этот файл 
;;; Файл может быть запущен даже при отсутствии реализации тестируемых функций

(load "lab-5.lsp")

;;; ВСПОМОГАТЕЛЬНЫЕ ОПРЕДЕЛЕНИЯ

;; макрос для проведения теста, в результате которого не должно быть 
;; сообщений об ошибках
;; fun - имя тестируемой функции
;; num - номер теста
;; test-expr - тестовое выражение (результатом которого должно быть T)
(defmacro result-test (fun num test-expr)
  `(progn
    (format T "function: ~A ~30,2Ttest: ~A ~Tresult: ~A~%" 
            ',fun ,num
            (handler-case 
               ,test-expr
             (T () NIL)))))

;; макрос для проведения теста результатом которого должно быть 
;; сообщение об ошибке error-type
;; fun - имя тестируемой функции
;; num - номер теста
;; error-type - имя исключения (T - если любое)
;; test-expr - тестовое выражение (результатом которого должно быть сообщение 
;;             о соответствующей ошибке)
(defmacro error-test (fun num error-type test-expr)
  `(progn
    (format T "function: ~A ~30,2Ttest: ~A ~Tresult: ~A~%" 
            ',fun ,num
            (handler-case 
               ,test-expr
             (,error-type () T)
             (T () NIL)))))

;; функция вывода разделительной линии
(defun line ()
  (format T "~V@{~a~:*~}~%" 50 "-"))
(defun starline ()
  (format T "~V@{~a~:*~}~%" 50 "*"))


;;; ТЕСТЫ
;; Каждый тест должен описывается как вызов макроса
;;
;; (result-test f N expr)
;;
;; в котором f - имя тестируемой функции
;;           N - номер теста для функции f
;;        expr - тестовое выражение, которое проверяет правильность
;;               функции f на каких-то тестовых данных; выражение должно 
;;               выдавать T в случае успешной проверки 
;;
;; или, если тестируется аварийный останов выполнения функции,
;; вызов макроса
;;
;; (error-test f N err expr)
;;
;; где f, N, expr - то же, что и в предыдущем случае, но 
;; проверяется, что выполнение expr прервется с ошибкой err
;; err может быть равным T, если ошибка любая
(line)
(starline)

;; Задание 1. Предикаты для выражений
;; 0? 
(result-test 0? 1 
  (eq (0? 0) T))

(result-test 0? 2
  (eq (0? 1) NIL))

(result-test 0? 3
  (eq (0? '()) NIL))

(result-test 0? 4
  (eq (0? 4) NIL))

(result-test 0? 5
  (eq (0? 5) NIL))

(line)
;; 1?
(result-test 1? 1 
  (eq (1? 1) T))

(result-test 1? 2 
  (eq (1? 2) NIL))

(result-test 1? 3 
  (eq (1? 3) NIL))

(line)
;; +?
(result-test +? 1 
  (eq (+? '(+ 1 2)) T))

(result-test +? 2 
  (eq (+? '(+ 2 3)) T))

(result-test +? 3 
  (eq (+? '(+ 4 5)) T))

(line)
;; -?
(result-test -? 1 
  (eq (-? '(- 1 2)) T))

(result-test -? 2 
  (eq (-? '(- 2 3)) T))

(result-test -? 3 
  (eq (-? '(+ 4 5)) NIL))

(line)
;; *?
(result-test *? 1 
  (eq (*? '(* 1 2)) T))

(result-test *? 2 
  (eq (*? '(* 2 3)) T))

(result-test *? 3 
  (eq (*? '(+ 1 2)) NIL))

(line)
;; /?
(result-test /? 1 
  (eq (/? '(/ 1 2)) T))

(result-test /? 2 
  (eq (/? '(/ 2 3)) T))

(result-test /? 3 
  (eq (/? '(+ 1 2)) NIL))

(line)
;; expt?
(result-test expt? 1 
  (eq (expt? '(expt 1 2)) T))

;; expt?
(result-test expt? 2 
  (eq (expt? '(expt 2 3)) T))

;; expt?
(result-test expt? 3 
  (eq (expt? '(sin 1 2)) NIL))

(line)
;; sqrt?
(result-test sqrt? 1 
  (eq (sqrt? '(sqrt 1)) T))

(result-test sqrt? 2 
  (eq (sqrt? '(sqrt 2)) T))

(result-test sqrt? 3 
  (eq (sqrt? '(sin 1)) NIL))

(line)
;; sin?
(result-test sin? 1 
  (eq (sin? '(sin 1)) T))

(result-test sin? 2 
  (eq (sin? '(sin 0)) T))

(result-test sin? 3 
  (eq (sin? '(cos 1)) NIL))

(line)
;; cos?
(result-test cos? 1 
  (eq (cos? '(cos 1)) T))

(result-test cos? 2 
  (eq (cos? '(cos 0)) T))

(result-test cos? 3 
  (eq (cos? '(sin 1)) NIL))

(line)
;; tan?
(result-test tan? 1 
  (eq (tan? '(tan 1)) T))

(result-test tan? 2 
  (eq (tan? '(tan 0)) T))

(result-test tan? 3 
  (eq (tan? '(sin 1)) NIL))

(line)
;; asin?
(result-test asin? 1 
  (eq (asin? '(asin 1)) T))

(result-test asin? 2 
  (eq (asin? '(asin 0)) T))

(result-test asin? 3 
  (eq (asin? '(sin 1)) NIL))

(line)
;; acos?
(result-test acos? 1
  (eq (acos? '()) NIL))
(result-test acos? 2
  (eq (acos? '(acos)) NIL))
(result-test acos? 3
  (eq (acos? '(acos 45)) T))
(result-test acos? 4
  (eq (acos? '(acos 45 19)) NIL))

(result-test acos? 5
  (eq (acos? '(acos 1)) T))

(result-test acos? 6
  (eq (acos? '(cos 45)) NIL))

(line)
;; atan?
(result-test atan? 1 
  (eq (atan? '(atan 1)) T))

(result-test atan? 2 
  (eq (atan? '(atan 0)) T))

(result-test atan? 3 
  (eq (atan? '(tan 1)) NIL))

(line)
;; exp?
(result-test exp? 1 
  (eq (exp? '(exp 1)) T))

(result-test exp? 2 
  (eq (exp? '(exp 0)) T))

(result-test exp? 3 
  (eq (exp? '(sin 1)) NIL))

(line)
;; log?
(result-test log? 1 
  (eq (log? '(log 2 3)) T))

(result-test log? 2 
  (eq (log? '(log 3 4)) T))

(result-test log? 3 
  (eq (log? '(sin 2 3)) NIL))

(line)
(starline)
;; Задание 2. Конструкторы для выражений
;; make+
(result-test make+ 1
  (equal (make+ 2 3 4) '(+ 2 3 4)))

(result-test make+ 2
  (equal (make+ 4 5 6) '(+ 4 5 6)))

(result-test make+ 3
  (equal (make+ 1 1 1 1) '(+ 1 1 1 1)))

(line)
;; make-
(result-test make- 1
  (equal (make- 2 3 4) '(- 2 3 4)))

(result-test make- 2
  (equal (make- 4 5 6) '(- 4 5 6)))

(result-test make- 3
  (equal (make- 1 1 1 1) '(- 1 1 1 1)))

(error-test make- 4 T
  (equal (make-) '(- 2 3 4)))

(line)
;; make*
(result-test make* 1
  (equal (make* 2 3 4) '(* 2 3 4)))

(result-test make* 2
  (equal (make* 1 1 1) '(* 1 1 1)))

(result-test make* 3
  (equal (make* 1 1 1 1) '(* 1 1 1 1)))

(line)
;; make/
(result-test make/ 1
  (equal (make/ 2 3 4) '(/ 2 3 4)))

(result-test make/ 2
  (equal (make/ 1 1 1) '(/ 1 1 1)))

(result-test make/ 3
  (equal (make/ 1 1 1 1) '(/ 1 1 1 1)))

(line)
;; makeexpt
(result-test makeexpt 1
  (equal (makeexpt 2 3) '(expt 2 3)))

(result-test makeexpt 2
  (equal (makeexpt 3 4) '(expt 3 4)))

(result-test makeexpt 3
  (equal (makeexpt 1 3) '(expt 1 3)))

(line)
;; makesqrt
(result-test makesqrt 1
  (equal (makesqrt 2) '(sqrt 2)))

(result-test makesqrt 2
  (equal (makesqrt 3) '(sqrt 3)))

(result-test makesqrt 3
  (equal (makesqrt 4) '(sqrt 4)))

(line)
;; makesin
(result-test makesin 1
  (equal (makesin 1) '(sin 1)))

(result-test makesin 2
  (equal (makesin 2) '(sin 2)))


(result-test makesin 3
  (equal (makesin 0) '(sin 0)))


(line)
;; makecos
(result-test makecos 1
  (equal (makecos 1) '(cos 1)))

(result-test makecos 2
  (equal (makecos 0) '(cos 0)))

(result-test makecos 3
  (equal (makecos 2) '(cos 2)))

(line)
;; maketan
(result-test maketan 1
  (equal (maketan 1) '(tan 1)))

(result-test maketan 2
  (equal (maketan 0) '(tan 0)))

(result-test maketan 2
  (equal (maketan 2) '(tan 2)))

(line)
;; makeasin
(result-test makeasin 1
  (equal (makeasin 1) '(asin 1)))

(result-test makeasin 2
  (equal (makeasin 0) '(asin 0)))

(result-test makeasin 1
  (equal (makeasin 2) '(asin 2)))

(line)
;; makeacos
(result-test makeacos 1
  (equal (makeacos 1) '(acos 1)))

(result-test makeacos 2
  (equal (makeacos 0) '(acos 0)))

(result-test makeacos 3
  (equal (makeacos 2) '(acos 2)))

(line)
;; makeatan
(result-test makeatan 1
  (equal (makeatan 1) '(atan 1)))

(result-test makeatan 2
  (equal (makeatan 0) '(atan 0)))

(result-test makeatan 3
  (equal (makeatan 2) '(atan 2)))

(line)
;; makeexp
(result-test makeexp 1
  (equal (makeexp 1) '(exp 1)))

(result-test makeexp 2
  (equal (makeexp 0) '(exp 0)))

(result-test makeexp 3
  (equal (makeexp 2) '(exp 2)))

(line)
;; makelog
(result-test makelog 1
  (equal (makelog 1 2) '(log 1 2)))

(result-test makelog 2
  (equal (makelog 2 3) '(log 2 3)))

(result-test makelog 3
  (equal (makelog 0 1) '(log 0 1)))

(line)
(starline)
;; Задание 3. НОРМАЛИЗАЦИЯ ВЫРАЖЕНИЙ
;; +-normalize
(result-test +-normalize 1
  (equal (normalize '(+)) 0)) 

(result-test +-normalize 2
  (equal (normalize '(+ 1)) 1)) 

(result-test +-normalize 3
  (equal (normalize '(+ 1 2 3 4 5 6))
         '(+ 1 (+ 2 (+ 3 (+ 4 (+ 5 6))))))) 

(line)
;; *-normalize
(result-test *-normalize 1
  (equal (normalize '(*)) 1)) 

(result-test *-normalize 2
  (equal (normalize '(* 1)) (* 1))) 

(line)
;; /-normalize
(error-test /-normalize 1 on-unknown-expression
  (equal (normalize '(/)) 1)) 

(result-test /-normalize 2
  (equal (normalize '(/ 1 2)) '(* 1 (/ (* 2))))) 

(line)
;; expt-normalize
(result-test expt-normalize 1 
  (equal (normalize '(expt 2 1)) '(expt 2 1))) 

(result-test expt-normalize 2 
  (equal (normalize '(expt 4 5)) '(expt 4 5))) 

(line)
;; sqrt-normalize
(result-test sqrt-normalize 1 
  (equal (normalize '(sqrt 4)) '(expt 4 1/2))) 

(result-test sqrt-normalize 2 
  (equal (normalize '(sqrt 2)) '(expt 2 1/2))) 

(line)
;; sin-normalize
(result-test sin-normalize 1 
  (equal (normalize '(sin x)) '(sin x))) 

(result-test sin-normalize 2 
  (equal (normalize '(sin 0)) '(sin 0))) 

(line)
;; cos-normalize
(result-test cos-normalize 1 
  (equal (normalize '(cos x)) '(cos x))) 

(result-test cos-normalize 2 
  (equal (normalize '(cos 0)) '(cos 0))) 

(line)
;; tan-normalize
(result-test tan-normalize 1 
  (equal (normalize '(tan x)) '(* (sin x) (/ (cos x))))) 

(result-test tan-normalize 2 
  (equal (normalize '(tan 0)) '(* (sin 0) (/ (cos 0))))) 

(line)
;; asin-normalize
(result-test asin-normalize 1 
  (equal (normalize '(asin x)) '(asin x))) 

(result-test asin-normalize 2 
  (equal (normalize '(asin 0)) '(asin 0))) 

(line)
;; acos-normalize
(result-test acos-normalize 1 
  (equal (normalize '(acos x)) '(acos x))) 

(result-test acos-normalize 2 
  (equal (normalize '(acos 0)) '(acos 0))) 

(line)
;; atan-normalize
(result-test atan-normalize 1 
  (equal (normalize '(atan x)) '(atan x))) 

(result-test atan-normalize 2 
  (equal (normalize '(atan 0)) '(atan 0))) 

(line)
;; exp-normalize
(result-test exp-normalize 1 
  (equal (normalize '(exp x)) '(exp x))) 

(result-test exp-normalize 2 
  (equal (normalize '(exp 0)) '(exp 0))) 

(line)
;; log-normalize
(result-test log-normalize 1 
  (equal (normalize '(log x y)) '(* (log x) (/ (log y))))) 

(result-test log-normalize 2 
  (equal (normalize '(log x x)) '(* (log x) (/ (log x))))) 

(line)
;; общие тесты normalize
(result-test normalize 1 
  (equal (normalize '(+ x (- y 1 3))) '(+ x (+ y (* -1 (+ 1 3))))))

(result-test normalize 2 
  (equal (normalize '(+ x (- y 2 4))) '(+ X (+ Y (* -1 (+ 2 4))))))

(line)
(starline)
;; УПРОЩЕНИЕ ВЫРАЖЕНИЙ
;; Задание 4. Упрощение сложения
;; simplify+
(result-test simplify+ 1 
  (= (simplify '(+ 3 8)) 11)) 

(result-test simplify+ 2 
  (= (simplify '(+ 4 8)) 12)) 

(line)
;; simplify+-aux1
(result-test simplify+-aux1 1 
  (= (simplify+-aux1 2 3) 5)) 

(result-test simplify+-aux1 2 
  (= (simplify+-aux1 3 3) 6)) 

(line)
;; simplify+-aux2
(result-test simplify+-aux2 1 
  (equal (simplify+-aux2 '3 '(+ 5 y)) '(+ 8 y))) 

(result-test simplify+-aux2 2 
  (equal (simplify+-aux2 '4 '(+ 5 y)) '(+ 9 y))) 

;; Задание 5. Упрощение умножения
(line)
;; simplify*
(result-test simplify* 1 
  (= (simplify '(* 3 8)) 24)) 

(result-test simplify* 2 
  (= (simplify '(* 4 8)) 32)) 

(line)
;; simplify*-through+
(result-test simplify*-through+ 1 
  (equal (simplify*-through+ '(4 (+ 4 x) (* 5 y) (- x)) 3) 
         '((* 3 4) (* 3 (+ 4 x)) (* 3 (* 5 y)) (* 3 (- x))))) 

(result-test simplify*-through+ 2 
  (equal (simplify*-through+ '(6 (+ 2 x) (* 4 y) (- x)) 8) 
         '((* 8 6) (* 8 (+ 2 x)) (* 8 (* 4 y)) (* 8 (- x)))) 

(line)
;; simplify*-aux1
(result-test simplify*-aux1 1 
  (= (simplify*-aux1 2 3) 6)) 

(result-test simplify*-aux1 2 
  (= (simplify*-aux1 3 3) 9)) 

(line)
;; simplify*-aux2
(result-test simplify*-aux2 1 
  (equal (simplify*-aux2 3 '(* 5 y)) '(* 15 y))) 

(result-test simplify*-aux2 2 
  (equal (simplify*-aux2 4 '(* 5 y)) '(* 20 y))) 

;; Задание 6. Упрощение обратного элемента (унарного деления)
(line)
;; simplify/
(result-test simplify/ 1 
  (equal (simplify '(/ (/ (/ (/ x))))) 'x)) 

(result-test simplify/ 2 
  (equal (simplify '(/ (/ (/ y)))) 'y)) 

(line)
;; simplify/-through*
(result-test simplify/-through* 1 
  (equal (simplify/-through* '(4 (+ 4 x) (* 5 y) (/ x))) 
         '((/ 4) (/ (+ 4 x)) (/ (* 5 y)) (/ (/ x))))) 

(result-test simplify/-through* 2 
  (equal (simplify/-through* '(5 (+ 6 x) (* 7 y) (/ y))) 
         '((/ 5) (/ (+ 6 x)) (/ (* 7 y)) (/ (/ y)))))

;; Задание 7. Упрощение возведения в степень
(line)
;; simplifyexpt
(result-test simplifyexpt 1 
  (equal (simplify '(expt x 1)) 'x)) 

(result-test simplifyexpt 2 
  (equal (simplify '(expt y 2)) 'y)) 

;; Задание 8. Упрощение остальных функций
(line)
;; simplify-fun-1
(result-test simplify-fun-1 1 
  (= (simplify '(cos (sin 0))) 1)) 

(result-test simplify-fun-1 2 
  (= (simplify '(sin (sin 0))) 0)) 

(line)
;; simplifyexp
(result-test simplifyexp 1 
  (= (simplify '(exp 0)) 1)) 

(result-test simplifyexp 2 
  (= (simplify '(exp 1)) 2.7182817)) 

(line)
;; simplifylog
(result-test simplifylog 1 
  (eq (simplify '(log (exp x))) 'x)) 

(result-test simplifylog 2 
  (eq (simplify '(log (exp y))) 'y)) 

(result-test simplifylog 3 
  (= (simplify '(log 1)) 0)) 

(line)
;; общие simplify
(result-test simplify 1 
  (equal (simplify '(- (+ (- (log (exp x)) 2)) 1)) '(+ -3 X))) 

(result-test simplify 2 
  (equal (simplify '(- (+ (- (log (exp y)) 5)) 3)) '(+ -8 y))) 

(error-test simplify 3 on-unknown-expression 
  (equal (simplify '(- (+ (- (sinh (exp x)) 2)) 1)) '(+ -3 X))) 


(line)
(starline)
;; ПРОИЗВОДНАЯ ВЫРАЖЕНИЯ
;; Задание 9. Производная суммы и разности
;; +-deriv
(result-test +-deriv 1 
  (= (simplify 
       (deriv (normalize '(+ x y (+ x y 5) 25 x)) 
              'x)) 
     3)) 

(result-test +-deriv 2 
  (= (simplify 
       (deriv (normalize '(+ x y (+ x y 6) 36 x)) 
              'x)) 
     3)) 

(line)
;; --deriv
(result-test --deriv 1 
  (= (simplify 
       (deriv (normalize '(- (- (- (- x))))) 
              'x)) 
     1)) 

(result-test --deriv 2 
  (= (simplify 
       (deriv (normalize '(- (- (- (- 2 x))))) 
              'x)) 
     1)) 

;; Задание 10. Производная произведения
(line)
;; *-deriv
(result-test *-deriv 1 
  (= (let ((x 2) (y 3))
       (declare (special x y))
       (eval 
         (deriv (normalize '(* x 5 x y)) 
                'x))) 
     60))

(result-test *-deriv 2 
  (= (let ((x 4) (y 5))
       (declare (special x y))
       (eval 
         (deriv (normalize '(* x 9 x y)) 
                'x))) 
     360))


;; Задание 11. Производная обратного элемента
(line)
;; /-deriv
(result-test /-deriv 1 
  (= (let ((x 2) (y 3))
       (declare (special x y))
       (eval 
         (deriv (normalize '(/ x 5 x y)) 
                'x))) 
     0))

(result-test /-deriv 2 
  (= (let ((x 3) (y 4))
       (declare (special x y))
       (eval 
         (deriv (normalize '(/ x 6 x y)) 
                'x))) 
     0))

;; Задание 12. Производная степенной функции
(line)
;; expt-deriv
(result-test expt-deriv 1 
  (= (let ((x 1))
       (declare (special x))
       (eval 
         (deriv '(expt x x) 'x))) 
     1.0))

(result-test expt-deriv 2 
  (= (let ((x 2))
       (declare (special x))
       (eval 
         (deriv '(expt x x) 'x))) 
     6.7725887))

;; Задание 13. Производные тригонометрических функций
(line)
;; sin-deriv
(result-test sin-deriv 1 
  (let ((x (/ pi 4)))
    (declare (special x))
    (= (eval 
         (deriv '(sin x) 'x))
       (cos x))))

(result-test sin-deriv 2 
  (let ((x (/ pi 3)))
    (declare (special x))
    (= (eval 
         (deriv '(sin x) 'x))
       (cos x))))

(line)
;; cos-deriv
(result-test cos-deriv 1 
  (let ((x (/ pi 4)))
    (declare (special x))
    (= (eval 
         (deriv '(cos x) 'x))
       (- (sin x)))))

(result-test cos-deriv 2 
  (let ((x (/ pi 4)))
    (declare (special x))
    (= (eval 
         (deriv '(cos x) 'x))
       (- (sin x)))))

;; Задание 14. Производные обратных тригонометрических функций
(line)
;; asin-deriv
(result-test asin-deriv 1 
  (let ((x 0))
    (declare (special x))
    (= (eval 
         (deriv '(asin x) 'x))
       1.0)))

(line)
;; acos-deriv
(result-test acos-deriv 1 
  (let ((x 0))
    (declare (special x))
    (= (eval 
         (deriv '(acos x) 'x))
       -1.0)))

(result-test acos-deriv 2 
  (let ((x 2))
    (declare (special x))
    (= (eval 
         (deriv '(acos x) 'x))
       1.0)))

(line)
;; atan-deriv
(result-test atan-deriv 1 
  (let ((x 0))
    (declare (special x))
    (= (eval 
         (deriv '(atan x) 'x))
       1.0)))

(result-test atan-deriv 2 
  (let ((x 1))
    (declare (special x))
    (= (eval 
         (deriv '(atan x) 'x))
       (/ 1 (sqrt (+ 1 (expt x 2)))))))

;; Задание 15. Производные экспоненты и натурального логарифма
(line)
;; exp-deriv
(result-test exp-deriv 1 
  (equal (simplify (deriv '(exp x) 'x))
         '(exp x)))

(result-test exp-deriv 2 
  (equal (simplify (deriv '(exp y) 'y))
         '(exp y)))

(line)
;; log-deriv
(result-test log-deriv 1 
  (equal (simplify (deriv '(log x) 'x))
         '(/ x)))

(result-test log-deriv 2 
  (equal (simplify (deriv '(log y) 'y))
         '(/ y)))

(line)
;; Производные произвольных выражений
(result-test deriv 1 
  (let ((expr '(+ (* x x) 
                  (sqrt (* x x))
                  (* x y)
                  (* 2 x x)))
        (x 2) (y 3))
    (declare (special x y))
    (= (eval (deriv (normalize expr) 'x))
       16)))

(error-test deriv 2 on-unknown-expression
  (eq (deriv '(sqrt x) 'x) NIL))

(error-test deriv 3 on-unknown-expression
  (eq (deriv '(sqrt y) 'y) NIL))

(line)
(starline)