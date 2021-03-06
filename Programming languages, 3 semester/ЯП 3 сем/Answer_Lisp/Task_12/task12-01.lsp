;; ��������� ������� ���������. ����� ������������� �������� ������ 
;; �� �������: ������� ��� ��������� ������� ������, ����� ��� �������� 
;; ������� � �. �. �������� ���������� ������ ����� �������� 
;; ��������� ��� ��������-������ �������� ������.
;; ������� - ������� �� ������ ���������, �� ����� �� ���������� 
;; ��������������� �������, ��������� �������������� 
;; �������������� ���������
;; l - ������������ �������� - �������� ������
;; ��������� ��������� ��������������
;; new-l - ������ ��������� ���������� ������
;; cur-depth-num - ����� �������� ������; ������������� ����� 1
;; cnt - ���������� ��������� �������� ������, ���������� ��������
;; res - ����� ���������� ������, �� ������� ���������� �����
(defun number-depth (l &optional new-l (cur-depth-num 1) (cnt 0) (res 0))
  (if (null l)          ; ���� ������ l ���� ������ 
      (if (= cnt 0) res ; � �� ������� ������ �� ���� ����������, 
                        ; ������ ������� ���������
          ; ���� �� ��������� ����, �� ���� ��� ���� �������, �������� ��������
          ; ���������� ������ new-l, �� �������� ���������� ��������� �������
          (number-depth new-l () (+ cur-depth-num 1) 0 res))
      ; ���� ������ l ���� �� ������, �� � ��� ���� ������ �������, 
      ; ��������� ��� el
      (let ((el (car l)))
        (cond 
          ((numberp el) ; ���� el - �����, �� ����� �������� ������ �������� 
                        ; � �������� ��������� res ��� ����������� ������
             (number-depth (cdr l) 
                           new-l 
                           cur-depth-num 
                           cnt 
                           cur-depth-num)) 
          ((listp el) ; ���� el - ������, �� ��� �������� ���������  
                      ; � ��������� ���������� ������
             (number-depth (cdr l) 
                           (append el new-l) 
                           cur-depth-num 
                           (+ 1 cnt) 
                           res))
          ; � ��������� ������ ������ ���������� ������� el
          (T (number-depth (cdr l) new-l cur-depth-num cnt res)))))) 

(defun find_list_part (l1 l2 &optional )
  )

(print (number-depth '(5 (7 8 a) ((6 (b () 9) 7) s) b)))
(print (number-depth '(a b (c ((d e) f 5 (g) h) i (j (k () l))) 
                        (m (n ((o p (9))) q ((r) (s t))) (u ((v) w))) 
                        ((x) ()) ((((10 (() y))))))))
(print (number-depth '(() 6)))
(print (number-depth '()))


