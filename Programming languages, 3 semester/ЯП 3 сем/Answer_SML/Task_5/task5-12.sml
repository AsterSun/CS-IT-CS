fun splitAt (xs, n)=
  let
    fun delDuplIter ([], (res1, res2)) = (rev res2, rev res1)
      | delDuplIter (x :: xs, (res1, res2)) =
          if x > n
          then delDuplIter (xs, (x :: res1, res2))
          else delDuplIter (xs, (res1, x :: res2))
  in
    delDuplIter (xs, ([], []))
  end

(* ТЕСТОВЫЕ ЗАПУСКИ *)
val test0 = splitAt ([1,2,3,4,5,6], 3)
val test2 = splitAt ([1,2,3,4,5,6], 4)
val test3 = splitAt ([1,2,3,4,5,6], 5)
val test4 = splitAt ([1,2,3,4,5,6], 6)

