fun maxSin (a : real, b : real, c : real) : real =
  let
  (* Вычисляем значения синуса для каждого из аргументов. 
   * Связываем сразу три имени со значениями.
   * Имя sinC используется лишь один раз, но введено для единообразия *)
    val (sinA, sinB, sinC) = (Math.sin a, Math.sin b, Math.sin c)
  (* Из первых двух аргументов функции выбирается тот, чей синус
   * больше, и его значение связывается с именем max. Имя maxOfAB 
   * связывается с максимальным из первых двух значений синусов. 
   * Имя maxOfAB используется лишь один раз, но введено ради
   * уменьшения громоздкости выражения *)
    val (max, maxOfAB) = if sinA > sinB then (a, sinA)
                         else (b, sinB)
  in
  (* В соответствии с максимальным значением синуса вычисляется
   * итоговый результат *)
    if sinC > maxOfAB then c * c else max * max
  end

(* ТЕСТОВЫЕ ЗАПУСКИ *)
val test1 = maxSin (~1.7, 2.0, 3.0)
val test2 = maxSin (2.0, ~1.7, 3.0)
val test3 = maxSin (3.0, ~1.7, 2.0)
val test4 = maxSin (1.7, 2.0, ~1.7)
val test5 = maxSin (1.7, 5.14, ~1.7)
val test6 = maxSin (Math.pi * 10.0, Math.pi / 2.0, Math.pi * 3.0 / 2.0)