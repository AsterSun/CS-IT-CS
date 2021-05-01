
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
  , powerSeq
  , findCloseEnough
  , streamSum
  , expSummands
  , expStream
  , expSummands
  , expStream
  , expAppr
  , derivativeAppr
  --, derivativeStream
  --, derivative
  --, funAkStream 
  --, invF
  , average
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
nat = [1] ++ map (+1) nat

-- Задание 2 fibonacci 
fibonacci = [0, 1] ++ zipWith (+) fibonacci (tail fibonacci)

-- Задание 3 factorial 
factorial = [1, 1] ++ zipWith (*) (tail nat) (tail factorial)

-- Задание 4 powerSeq 
powerSeq x =  [1, x] ++ zipWith (^) (repeat x) (tail nat)

-- Задание 5 findCloseEnough 
findCloseEnough eps (x1 : x2 : stream) = 
  if abs (x1 - x2) <= eps
  then x2
  else findCloseEnough eps (x2 : stream)

-- Задание 6 streamSum 
streamSum stream = 
  [0] ++ zipWith (+) (streamSum stream) stream

-- Задание 7 expSummands 
expSummands x = 
  zipWith (/) (map fromIntegral (powerSeq x)) (map fromIntegral factorial)

-- Задание 8 expStream 
expStream x = streamSum (expSummands x)

-- Задание 9 expAppr 
expAppr eps = (findCloseEnough eps) . expStream

-- Задание 10 derivativeAppr 
derivativeAppr f dx = 
  let 
    derivativeApprHelp x = ( f (x + dx) - f x ) / dx 
  in 
    derivativeApprHelp 

-- Задание 11 derivativeStream 

-- Задание 12 derivative 

-- Задание 13 funAkStream и invF     

-- Задание 14 average 
average x y = (x + y) / 2

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

