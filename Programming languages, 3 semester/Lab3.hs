
-- Шаблон для выполнения заданий Лабораторной работы №3 

-- ниеже перечисляются имена, доступные после загрузки данного модуля
-- (например в файле с тестами)
-- по мере реализации решений заданий снимайте комментарий 
-- с соответствующей функции
module Lab3 
  ( epsilon
  , epsilon'
  , epsilon''
  , nat
  , fibonacci
  , factorial
  --, powerSeq
  --, findCloseEnough
  --, streamSum
  --, expSummands
  --, expStream
  --, expSummands
  --, expStream
  --, expAppr
  --, derivativeAppr
  --, derivativeStream
  --, derivative
  --, funAkStream 
  --, invF
  --, average
  --, averageDump
  --, newtonTransform
  --, eitken
  --, fixedPoint
  --, fixedPointOfTransform
  --, sqrt1
  --, cubert1
  --, sqrt2
  --, cubert2
  --, extremum
  --, myPi
  ) where
--------------------------------------------------------------------------------
-- Вспомогательные определения
--------------------------------------------------------------------------------
import Data.List
epsilon  = 0.001
epsilon' = 0.00001
epsilon'' = 0.00000001
--------------------------------------------------------------------------------

-- Задание 1 nat 
nat = [1..]

-- Задание 2 fibonacci 
fibonacci = 0 : 1 : zipWith(+) fibonacci (tail fibonacci)

-- Задание 3 factorial 
factorial = 1 : zipWith(*) factorial (nat)

-- Задание 4 powerSeq 
powerSeq x = 1 : x : zipWith(*) powerSeq(x)

-- Задание 5 findCloseEnough 

-- Задание 6 streamSum 

-- Задание 7 expSummands 

-- Задание 8 expStream 

-- Задание 9 expAppr 

-- Задание 10 derivativeAppr 

-- Задание 11 derivativeStream 

-- Задание 12 derivative 

-- Задание 13 funAkStream и invF     

-- Задание 14 average 

-- Задание 15 averageDump 

-- Задание 16 newtonTransform 

-- Задание 17 eitken 

-- Задание 18 fixedPoint

-- Задание 19 fixedPointOfTransform 

-- Задание 20 sqrt1 

-- Задание 21 cubert1 

-- Задание 22 sqrt2 

-- Задание 23 cubert2 

-- Задание 24 extremum 

-- Задание 25 myPi 

