-- Тип данных "интервал" с инфиксным конструктором :-:
data Interval a = a :-: a

-- Нормализация интервала
iNormalize (x :-: y) = (min x y) :-: (max x y)

-- Селекторы (геттеры) для начала и конца интервала
iStart i = x
  where (x :-: _) = iNormalize i
iEnd i = y
  where (_ :-: y) = iNormalize i

-- Предикат (инфиксный) для определения принадлежности x интервалу i
(<~) x i = (x >= iStart i) && (x <= iEnd i)

-- Функция применения функции operation к интервалу i
iMap operation i  =
  iNormalize (operation (iStart i) :-: operation (iEnd i))

-- Назначение типа данных Interval экземпляром класса Eq
instance (Eq a, Ord a) => Eq (Interval a) where
    (==) i1 i2  = (iStart i1 == iStart i2) && (iEnd i1 == iEnd i2)

-- Назначение типа данных Interval экземпляром класса Show
instance (Show a, Ord a) => Show (Interval a) where
    show i = "(" ++ show (iStart i) ++ " :-: " ++ show (iEnd i) ++")"

-- Назначение типа данных Interval экземпляром класса Num
instance (Num a, Ord a) => Num (Interval a) where
    (+) i1 i2 = (iStart i1 + iStart i2) :-: (iEnd i1 + iEnd i2)
    (*) (x1 :-: y1) (x2 :-: y2) = a :-: b
          where a1 = x1 * x2
                as = [x1 * y2, y1 * x2, y1 * y2]
                a = foldr min a1 as
                b = foldr max a1 as
    negate i = iMap negate i
    abs (x :-: y) = 
      if signum x == signum y then iNormalize (ax :-: ay)
      else 0 :-: (max ax ay)
          where ax = abs x
                ay = abs y
    signum i = iMap signum i
    fromInteger x = (fromInteger x) :-: (fromInteger x)

-- Назначение типа данных Interval экземпляром класса Fractional
instance (Fractional a, Ord a) => Fractional (Interval a) where
    (/) (x1 :-: y1) (i2 @ (x2 :-: y2)) =
      if 0 <~ i2 then error "Division by zero"
      else a :-: b
          where a1 = x1 / x2
                as = [x1 / y2, y1 / x2, y1 / y2]
                a = foldr min a1 as
                b = foldr max a1 as

-- Назначение типа данных Interval экземпляром класса Ord
instance (Ord a) => Ord (Interval a) where
    (<)  i1 i2 = iEnd i1 <  iStart i2
    (<=) i1 i2 = iEnd i1 <= iStart i2
    (>)  i1 i2 = i2 < i1
    (>=) i1 i2 = i2 <= i1
    compare i1 i2
      | i1 <= i2  = LT
      | i1 >= i2  = GT
      | i1 == i2  = EQ
      | otherwise = error "The intervals are non-comparable"

-------------------------------------------------------------------------------
--                                  ПРИМЕРЫ
-------------------------------------------------------------------------------
main = do
  -- предопределяем три интервала
  let i1 = (-12) :-: (-4)
  let i2 = 16 :-: 8
  let i3 = (-10) :-: 5
  -- вывод значений первых двух интервалов
  print $ i1
  print $ iStart i2
  print $ iEnd i2
  print $ iNormalize i2
  print $ i2
  -- операции над интервалами
  print $ 0 <~ i1
  print $ 0 <~ i3
  print $ 7 <~ i3
  print $ iMap sin i3 
  -- арифметические операции  над интервалами
  print $ i1 + i2
  print $ i1 - i3
  print $ i3 * i1
  print $ i3 / i1
  print $ negate i1
  print $ abs i1
  print $ abs i3
  print $ signum i3
  -- смешанные арифметические операции, подключающие frominteger
  print $ 2 * i1
  print $ ((2 :-: 5) :-: (7 :-: 9)) + 1
  print $ i1 / 4
  print $ 4 / i1
  print $ i1 / (4 / 3)
  -- операции сравнения интервалов
  print $ i1 < i2
  print $ i1 <= i3
  print $ i1 > i3
  print $ compare i2 i3
  print $ compare i1 i2
  -- сравнение i1 и i3 с помощью compare приведет к ошибке
  -- так как интервалы не сравнимы
  -- можно раскомментировать следующую строку, чтобы в этом убедиться
  -- print (compare i1 i3)
  -- так как интервалу i3 принадлежит 0 то при делении на него
  -- выйдет сообщение об ошибке
  -- можно раскомментировать следующую строку, чтобы в этом убедиться
  -- print (i1 / i3)
