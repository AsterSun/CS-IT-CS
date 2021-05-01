allDigitsByN x n = lst
  where
    lst = [x, x2] 
          ++ map (\ y -> y `mod` n) ( zipWith (+) (tail lst) 
                                      (map (sumPart 0) (tail lst)) )
    x2 =mod (sumPart 0 x) n
    sumPart rez a
      | a == 0    = rez 
      | otherwise = sumPart ((+) rez (a `mod` 10)) (a `div` 10)

main = do
  print $ take 15 $ allDigitsByN 115 17
  print $ take 7 $ allDigitsByN 456 18
  print $ take 8 $ allDigitsByN 16 9