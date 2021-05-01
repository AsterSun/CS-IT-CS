--Говнокодить на Хаскеле здесь--

--Натуральны числа на тест--
nat = [1] ++ map (+1) nat

--факториал на тест--
factorial = [1, 1] ++ zipWith (*) (tail nat) (tail factorial)



findCloseEnough eps (x1 : x2 : stream) = 
  if abs (x1 - x2) < eps
  then x2
  else findCloseEnough eps (x2 : stream)

derivativeStreamHelp = [0, 0.5] ++ zipWith (/) 
      (map fromIntegral (repeat 1)) 
      (map fromIntegral (zipWith (^) (repeat 2) (tail nat)))