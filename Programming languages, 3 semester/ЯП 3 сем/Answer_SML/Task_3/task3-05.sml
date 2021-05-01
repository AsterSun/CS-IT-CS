(* N - целочисленный параметр *)
fun y (N : int) : real =
  let
    val rNplus = real (N + 1)
    val rNminus = real (N - 1)

    fun jIter (i : real, j : real, slag : real) : real =
      if j > rNminus 
      then slag
      else jIter (i, j + 1.0, slag + Math.cos i + Math.sin j)

    fun iIter (i : real, rez : real) : real =
      if i > rNplus 
      then rez
      else iIter (i + 1.0, rez + jIter (i, 1.0, 0.0))
  in
    iIter (~1.0, 0.0)
  end

(* ТЕСТОВЫЕ ЗАПУСКИ *)
val test1 = y 1
val test2 = y 2
val test3 = y 3
val test4 = y 4
val test5 = y 5
val test6 = y 6
