fun minMax [] = NONE
  | minMax (x :: xs) =
  let
    fun minN ([], vmin) = vmin
      | minN ([oneof], vmin) = if oneof < vmin then oneof else vmin
      | minN (x1 :: xs, vmin) = 
        if x1 < vmin then minN (xs, x1) else minN (xs, vmin)

    fun maxN ([], vmax) = vmax
      | maxN ([oneof], vmax) = if oneof > vmax then oneof else vmax
      | maxN (x1 :: xs, vmax) = 
        if x1 > vmax then maxN (xs, x1) else maxN (xs, vmax)
  in
    SOME (minN (xs, x), maxN (xs, x))
  end

(* ТЕСТОВЫЕ ЗАПУСКИ *)
val test0 = minMax []
val test1 = minMax [12]
val test2 = minMax [1, 2, 3, 0]
val test3 = minMax [9823, 11, ~1234, 10100]
val test4 = minMax [0, 0, 0, 0]