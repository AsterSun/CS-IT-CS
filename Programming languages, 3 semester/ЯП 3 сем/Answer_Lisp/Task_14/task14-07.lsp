;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 1. ���� ��� ���������� ���������� ����������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ������, ��������� �������� (thunk �� ��������� expr)
(defmacro delay (expr)
  `(cons NIL (lambda () ,expr)))

;; ������� ���������� ��������  
(defun force (delay)
  (if (car delay) 
      (cdr delay)
      (progn (setf (car delay) T)
             (setf (cdr delay) (funcall (cdr delay))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 2. ���� ��� ���������� �������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ������ ��� �������� ������ �� ������ a � ������ str
;; ��������� ���������� str - �����
(defmacro cons-stream (a str)
  `(cons ,a (delay ,str)))      

;; ������� ���������� ������ ������ (������ car-stream)
(defun head (stream)
  (car stream))

;; ������� ���������� ������ ������ (������ cdr-stream)
(defun tail (stream)
  (force (cdr stream)))

;; ������� �������� ������ �� �������
(defun empty-stream-p (stream)
  (null stream))  

;; ����������� ���������� ���������� - ������ �����
(defvar *the-empty-stream* '())  

;; ������� ���������� ������ stream � ������� ��������� p
(defun filter-stream (p stream)
  (cond ((empty-stream-p stream) *the-empty-stream*)
        ((funcall p (head stream)) 
         (cons-stream (head stream) 
                      (filter-stream p (tail stream))))
        (T (filter-stream p (tail stream)))))

;; ���� ������ ���� ���������� ��������������� ������� 
;; ��� ������ � �������� ��� ��������������� �������

(defun drop (n stream)
  (if (> n 0) 
      (drop (- n 1) (tail stream)) 
      stream))

(defun take (n stream)
  (if (> n 0)
      (cons (head stream) (take (- n 1) (tail stream)))
      NIL))

;; �������� ��� �������������� ������� � ����������� �� �������        
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 3. ������� �������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ���������� ����������, ���������� ����� ������
(defvar *ones*) ; ���������� ����������
(setq *ones* (cons-stream 1 *ones*)) 

;; �������, �������� ����� ����� �����, ������������ � n
(defun integers-starting-from (n)
  (cons-stream n (integers-starting-from (+ n 1))))
  
;; ��������������� �������, ����������� ������� �� x �� y
(defun divisible-p (x y)
  (= (mod x y) 0))

;; �������, ���������� ����� ������� ����� �� ������ stream ��� �������,
;; ��� stream - ������������ ������������������ ����� ����� � �������
;; �������� ������� - ������� ����� � � stream ��� �����, � �������
;; ���������� �������� ����� ������� ��������� �������� (����� �������).
(defun sieve (stream)
  (cons-stream
    (head stream)
    (sieve 
      (filter-stream
        (lambda (x) (not (divisible-p x (head stream))))
        (tail stream)))))

;; ���������� ����������, ���������� ����� ������� �����
(defvar *primes* (sieve (integers-starting-from 2)))  


;; ���� ������ ���� ���������� ��������������� �������/���������� ���������� 
;; ��� ��������������� �������

;;���������� ������� div
;;�������� �� ����� ������� �� ������� ����� ��������
;;������� ����� � ������� ����� ����� �� �������
(defun div (x y)
  (/ (- x (mod x y)) y))

;; ���������� ������� map
(defun new-map (fun stream)
  (cons-stream (funcall fun (head stream)) 
               (new-map fun (tail stream))))

;;������� ������ ����� ���� ��� ������� �����
(defun square (xs)
  (if (= xs 0) 0
      (+ (mod xs 10)
         (square (div xs 10)))))

;;������� seqn ������������ ����� �� ������� �������� 
;;(�� ����� ��������� � ������� �) � ����������� ������� map 
;;(���������� ������� 7 ��������)
(defun seqn (x)
  (cons-stream x (new-map (lambda (y) (square (* y y))) (seqn x))))

;;����������� ���� ���������� ������� � ����� �������
;;� ����������� ��� ������� ��������� (���������� ������� 7 ��������)
(defun squareDigitsSum (x) (seqn x))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 4. �������� �������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(print (head (tail (tail (tail (tail (tail *primes*))))))) ; 6-� ������� �����
(print 
  (head (tail (tail (tail (tail (tail (tail (tail *primes*))))))))) ; 8-� �����

;; ���� ������ ���� ���������� ������� ������ 
;; ��� ��������������� ������� � �������������� ������� drop � take

(print (take 5 (squareDigitsSum 136)))
(print (take 5 (squareDigitsSum 128)))
(print (take 5 (squareDigitsSum 26)))