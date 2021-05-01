fun y (_, _, 0) = (1.0, 0)
  | y (x, _, 1) = (x / 2.0, 1)
  | y (x, e, N) = 
      let
        fun yNext (yPred, yPredpred, i) =

          if abs (yPred - yPredpred) < e then (yPred, i - 1)
          else
            let
              val iPlus = real(i - 1)
              val yCur = 2.0 * yPred - x * x * yPredpred / iPlus / iPlus
            in
              if i >= N then (yCur, i)
              else yNext (yCur, yPred, i + 1)
            end
        val (y0, _) = y (x, e, 0)
        val (y1, _) = y (x, e, 1)
      in
        yNext (y1, y0, 2)
      end

(* ТЕСТОВЫЕ ЗАПУСКИ *)
val test1 = y (0.09, 0.1, 0)
val test2 = y (0.09, 0.1, 1)
val test3 = y (0.09, 0.1, 60)
val test4 = y (0.4, 0.001, 5)
val test5 = y (2.09, 5.001, 6)
val test6 = y (0.09, 0.001, 9)
val test7 = y (1.0, 7.0, 10)
val test8 = y (1.09, 1.001, 10)
val test9 = y (0.09, 2.001, 10)