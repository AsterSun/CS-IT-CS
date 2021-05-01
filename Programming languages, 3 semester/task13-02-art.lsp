(defmacro for (e1 (e3 e4) &body e2)
  ; Задаем идентификаторы имени и параметров функции
  (let ((func-name (gensym)) (res (gensym)) (con (gensym)))
    ; Вычисляем е1
    `(let ,e1
       ; Вычисляем е2, е3, у4
       (let ((,res (progn ,@e2)) (,con (progn ,e4 ,e3)))
            ; Заменяем вызов макроса на вызов функции
            (labels ((,func-name (,res ,con)
                        ; Если условие выполнения цикла верны, 
                        ; рекурсивно вызываем функцию
                        (if ,con 
                           (,func-name (prog1 (progn ,@e2) ,e4) ,e3)
                           ; иначе выдаеи результат
                           ,res)))
       ; начальный вызов функции
       (,func-name ,res ,con))))))

(defun y (n)
  ; Создаем переменную для ответа
  (let ((ans 0))
    ; Запускаем итерацию по i
    (for ((i 1)
          (max-i (+ n 2))
          (max-j (- n 2))
          (fun-ij (lambda (i j) (+ 1 (sqrt (/ i j))))))
          ((<= i max-i) (incf i))
          (let ((tmp-ans 1.0))
            ; Запускаем итерацию по j
            (for ((j 2))
                 ((<= j max-j) (incf j))
                 (setq tmp-ans (* tmp-ans (funcall fun-ij i j))))
            (incf ans tmp-ans)))
    ans))

(print (y 3))
(print (y 5))