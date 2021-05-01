fun maxFactorSum (a : real, b : real, c : real) : real = 
  let
    val AxB = a * b
    val AxC = a * c
    val BxC = b * c
  in
    if AxB > AxC andalso AxB > BxC then a + b 
    else if AxC > AxB andalso AxC > BxC then a + c 
         else  b + c 
  end

  (* ТЕСТОВЫЕ ЗАПУСКИ *)
val test1 = maxFactorSum (~1.7, 2.0, 3.0)
val test2 = maxFactorSum (2.9, 3.0, 3.8)
val test3 = maxFactorSum (3.0, ~1.7, 2.0)
val test4 = maxFactorSum (5.0, 2.0, ~1.7)
val test5 = maxFactorSum (1.7, 5.14, ~1.7)
val test6 = maxFactorSum (2.7, 2.7, 2.3)
val test7 = maxFactorSum (1.7, 1.7, 1.7)
val test8 = maxFactorSum (1.7, 2.7, 2.7)