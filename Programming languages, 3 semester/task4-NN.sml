(* Функция y определяется с помощью шаблонов *)
fun y (_, _, 0) = (1.0, 0)     (* при N=0 - результат y0 *)
  | y (x, _, 1) = (x / 2.0, 1) (* при N=1 - результат y1 *)
  | y (x, e, N) =  (* иначе определим вспомогательные элементы *)
      let
        (* функция yNext - функция вычисления очередного i-го 
         * элемента последовательности. Параметры yPred и yPredpred -
         * (i-1)-й (i-2)-й элементы последовательности, соответственно *)
        fun yNext (yPred, yPredpred, i) =
          (* Если разность yPred и yPredpred по модулю не превосходит
           * значения e, то yPred - искомый элемент *)
          if abs (yPred - yPredpred) < e then (yPred, i - 1)
          else
            let
              (* вычисляется yCur - i-й элемент последовательности *)
              val yCur = (x * yPred * yPred - 5.0) 
                         / (yPredpred * yPred)
            in
              (* если i достигло значения N то вернуть yCur как результат
               * в противном случае запускается алгоритм
               * вычисления i+1-го элемента *)
              if i >= N then (yCur, i)
              else yNext (yCur, yPred, i + 1)
            end

        (* Для вычисления второго элемента последовательности
         * нам потрубуются значения нулевого и первого элементов.
         * Не будем повторять описание их вычисления, а используем 
         * уже описанные алгоритмы. Так как функция y возвращает пару 
         * значений, а второй элемент этой пары нам не нужен, 
         * то с помощью шаблонов извлекаем первый элемент пары *)
        val (y0, _) = y (x, e, 0)
        val (y1, _) = y (x, e, 1)
      in
        (* запуск вычисления 2-го элемента последовательности:
         * не повторяем вычисления нулевого и первого элемента,
         * а используем описанные ранее алгоритмы их вычисления. *)
        yNext (y1, y0, 2)
      end

(* ТЕСТОВЫЕ ЗАПУСКИ *)
val test1 = y (0.09, 0.1, 0)
val test2 = y (0.09, 0.1, 1)
val test3 = y (0.09, 0.1, 60)
val test4 = y (0.09, 0.001, 5)
val test5 = y (0.09, 0.001, 60)
val test6 = y (0.09, 0.001, 500)
val test7 = y (0.09, 0.001, 501)
val test8 = y (0.09, 0.001, 1000)
val test9 = y (0.09, 0.001, 1001)