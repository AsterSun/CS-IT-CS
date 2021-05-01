-- Описываем тип данных Complex, определяющий комплексные 
-- числа как в прямоугольной, так и в полярной формах
data Complex a = ComplRect (a, a)
                 | ComplPolar (a, a)

-- Реализуем функции rectToPolar, конвертирующую представление комплексного
-- числа из прямоугольного в полярное, polarToRect, конвертирующую
-- представление комплексного числа из полярного в прямоугольное,
-- a также реализуем 4 геттера, извлекающие необходимые данные,
-- причём из обеих форм представления комплексных чисел
rectToPolar (ComplRect (a, b)) = ComplPolar (sqrt (a * a + b * b), atan2 b a)
polarToRect (ComplPolar (a, b)) = ComplRect (a * cos b, a * sin b)
re (ComplRect (cReal, _)) = cReal
re inp = re (polarToRect inp)
im (ComplRect (_, cImaginary)) = cImaginary
im inp = im (polarToRect inp)
magnitude (ComplPolar (cMagnitude, _)) = cMagnitude
magnitude inp = magnitude (rectToPolar inp)
angle (ComplPolar (_, cAngle)) = cAngle
angle inp = angle (rectToPolar inp)

-- Реализуем вывод комплексного числа в необходимых формах через класс Show
instance (Show a) => Show (Complex a) where
    show (ComplRect (cReal, cImaginary)) = 
      "(" ++ show cReal ++ " + " ++ show cImaginary ++ "i)"
    show (ComplPolar (cRate, cAngle)) =
      "(" ++ show cRate ++ " * e ^ {i * " ++ show cAngle ++ "})"

-- Реализуем сравнение на равнество через класс Eq,
-- сравнение ведём через сравнение мнимой и действительной
-- части в прямоугольной форме представления
instance (Floating a) => Eq (Complex a) where
    (==) inp1 inp2 = (re inp1 == re inp2) && (im inp1 == im inp2)

-- Определяем функции через класс Num для комплексных чисел
-- через приведённые соотношения. inp - входные данные
instance (RealFloat a) => Num (Complex a) where
    (+) inp1 inp2 = ComplRect (re inp1 + re inp2, im inp1 + im inp2)
    (*) inp1 inp2 = ComplPolar (magnitude inp1 * magnitude inp2
                                , angle inp1 + angle inp2)
    negate inp = ComplRect (-(re inp), -(im inp))
    abs inp = ComplPolar (abs (magnitude inp), 0)
    signum inp = ComplRect (signum (re inp), signum (im inp))
    fromInteger inp = ComplRect (fromInteger inp, 0)

-- Опрелеляем функцию "/" через заданные соотношения
instance (RealFloat a) => Fractional (Complex a) where
    (/) inp1 inp2 = ComplPolar (magnitude inp1 / magnitude inp2
                                , angle inp1 - angle inp2)

main = do
  let test1 = ComplRect (0, 0)
  let test2 = ComplPolar (10, 6)
  let test3 = ComplRect (1, 1)
  let test4 = ComplRect (2, 2)
  let test5 = ComplPolar (2, 4)
  let test6 = ComplPolar (4, 8)
  let testSum = test3 + test4
  let testMult = test5 * test6
  let testNegate = negate test4
  let testAbs = abs test5
  let testSignum = signum test4
  let testDiv = test5 / test6

  print $ test1
  print $ test2
  print $ test3
  print $ test4
  print $ test5
  print $ test6
  print $ testSum
  print $ testMult
  print $ testNegate
  print $ testAbs
  print $ testSignum
  print $ testDiv