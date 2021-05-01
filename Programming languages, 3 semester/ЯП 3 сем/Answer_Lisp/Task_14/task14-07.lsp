;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 1. блок для реализации отложенных вычислений
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; макрос, создающий обещание (thunk из выражения expr)
(defmacro delay (expr)
  `(cons NIL (lambda () ,expr)))

;; функция вычисления обещания  
(defun force (delay)
  (if (car delay) 
      (cdr delay)
      (progn (setf (car delay) T)
             (setf (cdr delay) (funcall (cdr delay))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 2. блок для реализации потоков
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; макрос для создания потока из головы a и хвоста str
;; результат вычисления str - поток
(defmacro cons-stream (a str)
  `(cons ,a (delay ,str)))      

;; функция извлечения головы потока (вместо car-stream)
(defun head (stream)
  (car stream))

;; функция извлечения хвоста потока (вместо cdr-stream)
(defun tail (stream)
  (force (cdr stream)))

;; функция проверки потока на пустоту
(defun empty-stream-p (stream)
  (null stream))  

;; определение глобальной переменной - пустой поток
(defvar *the-empty-stream* '())  

;; функция фильтрации потока stream с помощью предиката p
(defun filter-stream (p stream)
  (cond ((empty-stream-p stream) *the-empty-stream*)
        ((funcall p (head stream)) 
         (cons-stream (head stream) 
                      (filter-stream p (tail stream))))
        (T (filter-stream p (tail stream)))))

;; ниже должны быть определены вспомогательные функции 
;; для работы с потоками для индивидуального задания

(defun drop (n stream)
  (if (> n 0) 
      (drop (- n 1) (tail stream)) 
      stream))

(defun take (n stream)
  (if (> n 0)
      (cons (head stream) (take (- n 1) (tail stream)))
      NIL))

;; возможны еще дополнительные функции в зависимости от задания        
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 3. примеры потоков
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; глобальная переменная, содержащая поток единиц
(defvar *ones*) ; объявление переменной
(setq *ones* (cons-stream 1 *ones*)) 

;; функция, выдающая поток целых чисел, начинающийся с n
(defun integers-starting-from (n)
  (cons-stream n (integers-starting-from (+ n 1))))
  
;; вспомогательная функция, проверяющая делится ли x на y
(defun divisible-p (x y)
  (= (mod x y) 0))

;; функция, получающая поток простых чисел из потока stream при условии,
;; что stream - возрастающая последовательность целых чисел в которой
;; головной элемент - простое число и в stream нет чисел, у которых
;; делителями являются числа меньшие головного элемента (кроме единицы).
(defun sieve (stream)
  (cons-stream
    (head stream)
    (sieve 
      (filter-stream
        (lambda (x) (not (divisible-p x (head stream))))
        (tail stream)))))

;; глобальная переменная, содержащая поток простых чисел
(defvar *primes* (sieve (integers-starting-from 2)))  


;; ниже должны быть определены вспомогательные функции/глобальные переменные 
;; для индивидуального задания

;;Реализация функции div
;;Вычитаем из числа остаток от деления чтобы получить
;;кратное число и находим целую часть от деления
(defun div (x y)
  (/ (- x (mod x y)) y))

;; Реализация функции map
(defun new-map (fun stream)
  (cons-stream (funcall fun (head stream)) 
               (new-map fun (tail stream))))

;;Функция взятия суммы цифр для данного числа
(defun square (xs)
  (if (= xs 0) 0
      (+ (mod xs 10)
         (square (div xs 10)))))

;;Функция seqn объединяющая поток из первого элемента 
;;(он всгда совпадает с входным х) и собственной функции map 
;;(повторение решения 7 варианта)
(defun seqn (x)
  (cons-stream x (new-map (lambda (y) (square (* y y))) (seqn x))))

;;Объединение всех предыдущих функций в видее функции
;;с необходимым для задания названием (повторение решения 7 варианта)
(defun squareDigitsSum (x) (seqn x))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 4. тестовые примеры
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(print (head (tail (tail (tail (tail (tail *primes*))))))) ; 6-е простое число
(print 
  (head (tail (tail (tail (tail (tail (tail (tail *primes*))))))))) ; 8-е число

;; ниже должны быть определены примеры потока 
;; для индивидуального задания с использованием функций drop и take

(print (take 5 (squareDigitsSum 136)))
(print (take 5 (squareDigitsSum 128)))
(print (take 5 (squareDigitsSum 26)))