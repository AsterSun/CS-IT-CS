fun y (N : int) : real =
  let
    val rN = real N
    val rjN = rN - 1.0
    val riN = rN + 1.0

    fun jIter (i : real, j : real, slag : real, cosin : real) : real =
      if j > rjN 
      then slag
      else jIter (i, j + 1.0, slag + cosin + Math.sin j, cosin)

    fun iIter (i : real, rez : real) : real =
      if i > riN 
      then rez
      else iIter (i + 1.0, rez + jIter (i, 1.0, 1.0, Math.cos i))
  in
    iIter (~1.0, 0.0)
  end

val test1 = y 2
val test2 = y 3
val test3 = y 4
val test4 = y 5
val test5 = y 6
val test6 = y 7
val test7 = y 8