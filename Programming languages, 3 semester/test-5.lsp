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

(load "C:\\Users\\AsterSun\\Downloads\\lab-5 (2).lsp")

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
  (eq (0? '(3)) NIL))

(result-test 0? 5
  (eq (0? '(a)) NIL))

(line)
;; 1?
(result-test 1? 1
  (eq (1? 1) T))

(result-test 1? 2
  (eq (1? 0) NIL))

(result-test 1? 3
  (eq (1? 9) NIL))

(line)
;; +?
(result-test +? 1
  (eq (+? '(+ 1 2)) T))

(result-test +? 2
  (eq (+? '(+ 10)) T))

(result-test +? 3
  (eq (+? '()) NIL))

(result-test +? 4
  (eq (+? '(+)) T))

(line)
;; -?
(result-test -? 1
  (eq (-? '(- 1 2)) T))

(result-test -? 2
  (eq (-? '(- 1)) T))

(result-test -? 3
  (eq (-? '(-)) NIL))

(result-test -? 4
  (eq (-? '()) NIL))


(line)
;; *?
(result-test *? 1
  (eq (*? '(* 1 2)) T))

(result-test *? 2
  (eq (*? '(* 1)) T))

(result-test *? 3
  (eq (*? '(*)) T))

(result-test *? 4
  (eq (*? '()) NIL))

(line)
;; /?
(result-test /? 1
  (eq (/? '(/ 1 2)) T))

(result-test /? 2
  (eq (/? '(/ 1)) T))

(result-test /? 3
  (eq (/? '(/)) NIL))

(result-test /? 4
  (eq (/? '()) NIL))

(line)
;; expt?
(result-test expt? 1
  (eq (expt? '(expt 1 2)) T))

(result-test expt? 2
  (eq (expt? '(expt 1)) NIL))

(result-test expt? 3
  (eq (expt? '(expt)) NIL))

(line)
;; sqrt?
(result-test sqrt? 1
  (eq (sqrt? '(sqrt 1)) T))

(result-test sqrt? 2
  (eq (sqrt? '(sqrt)) NIL))

(result-test sqrt? 3
  (eq (sqrt? '()) NIL))

(line)
;; sin?
(result-test sin? 1
  (eq (sin? '(sin 1)) T))

(result-test sin? 2
  (eq (sin? '(sin)) NIL))

(result-test sin? 3
  (eq (sin? '()) NIL))

(line)
;; cos?
(result-test cos? 1
  (eq (cos? '(cos 1)) T))

(result-test cos? 2
  (eq (cos? '(cos)) NIL))

(result-test cos? 3
  (eq (cos? '()) NIL))

(line)
;; tan?
(result-test tan? 1
  (eq (tan? '(tan 1)) T))

(result-test tan? 2
  (eq (tan? '(tan)) NIL))

(result-test tan? 3
  (eq (tan? '()) NIL))

(line)
;; asin?
(result-test asin? 1
  (eq (asin? '(asin 1)) T))

(result-test asin? 2
  (eq (asin? '(asin)) NIL))

(result-test asin? 3
  (eq (asin? '()) NIL))


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
  (eq (acos? '(acos 12)) T))

(line)
;; atan?
(result-test atan? 1
  (eq (atan? '(atan 1)) T))

(result-test atan? 2
  (eq (atan? '(atan)) NIL))

(result-test atan? 3
  (eq (atan? '()) NIL))

(line)
;; exp?
(result-test exp? 1
  (eq (exp? '(exp 1)) T))

(result-test exp? 2
  (eq (exp? '(exp)) NIL))

(result-test exp? 3
  (eq (exp? '()) NIL))

(line)
;; log?
(result-test log? 1
  (eq (log? '(log 2 3)) T))

(result-test log? 2
  (eq (log? '(log 2)) T))

(result-test log? 3
  (eq (log? '(log)) NIL))

(result-test log? 4
  (eq (log? '()) NIL))

(line)
(starline)
;; Задание 2. Конструкторы для выражений
;; make+
(result-test make+ 1
  (equal (make+ 2 3 4) '(+ 2 3 4)))

(result-test make+ 2
  (equal (make+ 4) '(+ 4)))

(result-test make+ 3
  (equal (make+ 2 4) '(+ 2 4)))

(line)
;; make-
(result-test make- 1
  (equal (make- 2 3 4) '(- 2 3 4)))

(error-test make- 2 T
  (equal (make-) '(- 2 3 4)))

(result-test make- 3
  (equal (make- 1 4) '(- 1 4)))

(line)
;; make*
(result-test make* 1
  (equal (make* 2 3 4) '(* 2 3 4)))

(result-test make* 2
  (equal (make* 2 4) '(* 2 4)))

(result-test make* 3
  (equal (make* 2) '(* 2)))

(line)
;; make/
(result-test make/ 1
  (equal (make/ 2 3 4) '(/ 2 3 4)))

(result-test make/ 2
  (equal (make/ 2 4) '(/ 2 4)))

(result-test make/ 3
  (equal (make/ 2) '(/ 2)))

(line)
;; makeexpt
(result-test makeexpt 1
  (equal (makeexpt 2 3) '(expt 2 3)))

(result-test makeexpt 2
  (equal (makeexpt 1 3) '(expt 1 3)))

(result-test makeexpt 3
  (equal (makeexpt 1 1) '(expt 1 1)))

(line)
;; makesqrt
(result-test makesqrt 1
  (equal (makesqrt 2) '(sqrt 2)))

(error-test makesqrt 2 T
  (equal (makesqrt) '(sqrt 2)))

(result-test makesqrt 3
  (equal (makesqrt 10) '(sqrt 10)))

(line)
;; makesin
(result-test makesin 1
  (equal (makesin 1) '(sin 1)))

(error-test makesin 2 T
  (equal (makesin) '(sin 1)))

(result-test makesin 3
  (equal (makesin 10) '(sin 10)))

(line)
;; makecos
(result-test makecos 1
  (equal (makecos 1) '(cos 1)))

(error-test makecos 2 T
  (equal (makecos) '(cos 1)))

(result-test makecos 3
  (equal (makecos 10) '(cos 10)))

(line)
;; maketan
(result-test maketan 1
  (equal (maketan 1) '(tan 1)))

(error-test maketan 2 T
  (equal (maketan) '(tan 1)))

(result-test maketan 3
  (equal (maketan 10) '(tan 10)))

(line)
;; makeasin
(result-test makeasin 1
  (equal (makeasin 1) '(asin 1)))

(error-test makeasin 2 T
  (equal (makeasin) '(asin 1)))

(result-test makeasin 3
  (equal (makeasin 10) '(asin 10)))

(line)
;; makeacos
(result-test makeacos 1
  (equal (makeacos 1) '(acos 1)))

(error-test makeacos 2 T
  (equal (makeacos) '(acos 1)))

(result-test makeacos 3
  (equal (makeacos 10) '(acos 10)))

(line)
;; makeatan
(result-test makeatan 1
  (equal (makeatan 1) '(atan 1)))

(error-test makeatan 2 T
  (equal (makeatan) '(atan 1)))

(result-test makeatan 3
  (equal (makeatan 10) '(atan 10)))

(line)
;; makeexp
(result-test makeexp 1
  (equal (makeexp 1) '(exp 1)))

(error-test makeexp 2 T
  (equal (makeexp) '(exp 1)))

(result-test makeexp 1
  (equal (makeexp 10) '(exp 10)))

(line)
;; makelog
(result-test makelog 1
  (equal (makelog 1 2) '(log 1 2)))

(error-test makelog 2 T
  (equal (makelog) '(log 1 2)))

(result-test makelog 3
  (equal (makelog 1) '(log 1)))

(line)
(starline)
;; Задание 3. НОРМАЛИЗАЦИЯ ВЫРАЖЕНИЙ
;; +-normalize
(result-test +-normalize 1
  (equal (normalize '(+)) 0))

(result-test +-normalize 2
  (equal (normalize '(+ 1 2 3 4 5 6))
         '(+ 1 (+ 2 (+ 3 (+ 4 (+ 5 6)))))))

(result-test +-normalize 3
  (equal (normalize '(+ 1)) 1)) 

(line)
;; *-normalize
(result-test *-normalize 1
  (equal (normalize '(*)) 1))

(result-test *-normalize 2
  (equal (normalize '(* 1)) 1)) 

(result-test *-normalize 3
  (equal (normalize '(* 1 2 3)) '(* 1 (* 2 3))))

(line)
;; /-normalize
(error-test /-normalize 1 on-unknown-expression
  (equal (normalize '(/)) 1))

(result-test /-normalize 2
  (equal (normalize '(/ 1 2 3)) '(* 1 (/ (* 2 3)))))

(result-test /-normalize 3
  (equal (normalize '(/ 1)) '(/ 1)))

(line)
;; expt-normalize
(result-test expt-normalize 1
  (equal (normalize '(expt 2 1)) '(expt 2 1)))

(error-test expt-normalize 2 T
  (equal (normalize '(expt 2)) '(expt 2 1)))

(error-test expt-normalize 3 T
  (equal (normalize '(expt 2 1 1)) '(expt 2 1 1)))

(line)
;; sqrt-normalize
(result-test sqrt-normalize 1
  (equal (normalize '(sqrt 4)) '(expt 4 1/2)))

(error-test sqrt-normalize 2 T
  (equal (normalize '(sqrt 4 2)) '(expt 4 1/2)))

(error-test sqrt-normalize 3 T
  (equal (normalize '(sqrt)) '(expt 4 1/2)))

(line)
;; sin-normalize
(result-test sin-normalize 1
  (equal (normalize '(sin x)) '(sin x)))

(error-test sin-normalize 2 T
  (equal (normalize '(sin)) '(sin x)))

(line)
;; cos-normalize
(result-test cos-normalize 1
  (equal (normalize '(cos x)) '(cos x)))

(error-test cos-normalize 2 T
  (equal (normalize '(cos)) '(cos x)))

(line)
;; tan-normalize
(result-test tan-normalize 1
  (equal (normalize '(tan x)) '(* (sin x) (/ (cos x)))))

(error-test tan-normalize 2 T
  (equal (normalize '(tan)) '(* (sin x) (/ (cos x)))))

(line)
;; asin-normalize
(result-test asin-normalize 1
  (equal (normalize '(asin x)) '(asin x)))

(error-test asin-normalize 2 T
  (equal (normalize '(asin)) '(asin x)))

(line)
;; acos-normalize
(result-test acos-normalize 1
  (equal (normalize '(acos x)) '(acos x)))

(error-test acos-normalize 2 T
  (equal (normalize '(acos)) '(acos x)))


(line)
;; atan-normalize
(result-test atan-normalize 1
  (equal (normalize '(atan x)) '(atan x)))

(error-test atan-normalize 2 T
  (equal (normalize '(atan)) '(atan x)))

(line)
;; exp-normalize
(result-test exp-normalize 1
  (equal (normalize '(exp x)) '(exp x)))

(error-test exp-normalize 2 T
  (equal (normalize '(exp)) '(exp x)))

(line)
;; log-normalize
(result-test log-normalize 1
  (equal (normalize '(log x y)) '(* (log x) (/ (log y)))))

(error-test log-normalize 2 T
  (equal (normalize '(log x y 2)) '(* (log x) (/ (log y)))))

(error-test log-normalize 3 T
  (equal (normalize '(log)) '(log x)))

(result-test log-normalize 4
  (equal (normalize '(log x)) '(log x)))

(line)
;; общие тесты normalize
(result-test normalize 1
  (equal (normalize '(+ x (- y 1 3))) '(+ x (+ y (* -1 (+ 1 3))))))

(result-test normalize 2
  (equal (normalize '(* x (- y (sqrt q) z)))
         '(* x (+ y (* -1 (+ (expt q 1/2) z))))))

(result-test normalize 3
  (equal (normalize '(cos (sin (sqrt (+ (- 2) 2)))))
         '(cos (sin (expt (+ (* -1 2) 2) 1/2)))))

(line)
(starline)
;; УПРОЩЕНИЕ ВЫРАЖЕНИЙ
;; Задание 4. Упрощение сложения
;; simplify+
(result-test simplify+ 1 
  (= (simplify '(+ 3 8)) 11)) 

(line)
;; simplify+-aux1
(result-test simplify+-aux1 1 
  (= (simplify+-aux1 2 3) 5)) 

(line)
;; simplify+-aux2
(result-test simplify+-aux2 1 
  (equal (simplify+-aux2 '3 '(+ 5 y)) '(+ 8 y))) 

;; Задание 5. Упрощение умножения
(line)
;; simplify*
(result-test simplify* 1 
  (= (simplify '(* 3 8)) 24)) 

(line)
;; simplify*-through+
(result-test simplify*-through+ 1 
  (equal (simplify*-through+ '(4 (+ 4 x) (* 5 y) (- x)) 3) 
         '((* 3 4) (* 3 (+ 4 x)) (* 3 (* 5 y)) (* 3 (- x))))) 

(line)
;; simplify*-aux1
(result-test simplify*-aux1 1 
  (= (simplify*-aux1 2 3) 6)) 

(line)
;; simplify*-aux2
(result-test simplify*-aux2 1 
  (equal (simplify*-aux2 3 '(* 5 y)) '(* 15 y))) 

;; Задание 6. Упрощение обратного элемента (унарного деления)
(line)
;; simplify/
(result-test simplify/ 1 
  (equal (simplify '(/ (/ (/ (/ x))))) 'x)) 

(line)
;; simplify/-through*
(result-test simplify/-through* 1 
  (equal (simplify/-through* '(4 (+ 4 x) (* 5 y) (/ x))) 
         '((/ 4) (/ (+ 4 x)) (/ (* 5 y)) (/ (/ x))))) 

;; Задание 7. Упрощение возведения в степень
(line)
;; simplifyexpt
(result-test simplifyexpt 1 
  (equal (simplify '(expt x 1)) 'x)) 

;; Задание 8. Упрощение остальных функций
(line)
;; simplify-fun-1
(result-test simplify-fun-1 1 
  (= (simplify '(cos (sin 0))) 1)) 

(line)
;; simplifyexp
(result-test simplifyexp 1 
  (= (simplify '(exp 0)) 1)) 

(line)
;; simplifylog
(result-test simplifylog 1 
  (eq (simplify '(log (exp x))) 'x)) 

(result-test simplifylog 2 
  (= (simplify '(log 1)) 0)) 

(line)
;; общие simplify
(result-test simplify 1 
  (equal (simplify '(- (+ (- (log (exp x)) 2)) 1)) '(+ -3 X))) 

(error-test simplify 2 on-unknown-expression 
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


(line)
;; --deriv
(result-test --deriv 1 
  (= (simplify 
       (deriv (normalize '(- (- (- (- x))))) 
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

;; Задание 12. Производная степенной функции
(line)
;; expt-deriv
(result-test expt-deriv 1 
  (= (let ((x 1))
       (declare (special x))
       (eval 
         (deriv '(expt x x) 'x))) 
     1.0))

;; Задание 13. Производные тригонометрических функций
(line)
;; sin-deriv
(result-test sin-deriv 1 
  (let ((x (/ pi 4)))
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

(line)
;; atan-deriv
(result-test atan-deriv 1 
  (let ((x 0))
    (declare (special x))
    (= (eval 
         (deriv '(atan x) 'x))
       1.0)))

;; Задание 15. Производные экспоненты и натурального логарифма
(line)
;; exp-deriv
(result-test exp-deriv 1 
  (equal (simplify (deriv '(exp x) 'x))
         '(exp x)))

(line)
;; log-deriv
(result-test log-deriv 1 
  (equal (simplify (deriv '(log x) 'x))
         '(/ x)))

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

(line)
(starline)