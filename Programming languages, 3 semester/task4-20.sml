fun y (_, _, 0) = (1.0, 0)
  | y (x, _, 1) = (x, 1)
  | y (x, e, N) =
      let
        fun yNext (yPred, yPredpred, i) =
          if abs (yPred - yPredpred) < e then (yPred, i - 1)
          else
            let
              val yCur = x * yPred * yPred / real i - yPredpred
            in
              if i >= N then (yCur, i)
              else yNext (yCur, yPred, i + 1)
            end

        val (y0, _) = y (x, e, 0)
        val (y1, _) = y (x, e, 1)
  in
    yNext (y1, y0, 2)
  end

val test1 = y (0.09, 0.1, 0)
val test2 = y (0.09, 0.1, 1)
val test3 = y (0.09, 0.1, 2)
val test4 = y (0.09, 0.1, 10000)
val test5 = y (1.0, 0.1, 1)
val test6 = y (1.0, 0.1, 2)
val test7 = y (1.0, 0.1, 1000)
val test8 = y (1.0, 0.001, 1000)
val test9 = y (2.0, 0.001, 1000)