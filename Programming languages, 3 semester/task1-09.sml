fun sumDivisibleBy3 (a : int, b : int, c : int, d : int) : int = 
  (if a mod 3 = 0 then a else 0)
  + (if b mod 3 = 0 then b else 0)
  + (if c mod 3 = 0 then c else 0)
  + (if d mod 3 = 0 then d else 0)

(* ТЕСТОВЫЕ ЗАПУСКИ *)
val test1 = sumDivisibleBy3 (1, 2, 3, 4) = 3
val test2 = sumDivisibleBy3 (3, 2, 3, 4) = 6
val test3 = sumDivisibleBy3 (0, 0, 0, 0) = 0
val test4 = sumDivisibleBy3 (3, 9, 3, 9) = 24
val test5 = sumDivisibleBy3 (100, 200, 300, 400) = 300
val test6 = sumDivisibleBy3 (100, 200, 900000000, 400) = 900000000