squareDigitsSum x = seqn
  where
    square 0 = 0
    square xs = xs `mod` 10 + square (xs `div` 10)
    seqn = [x] 
           ++ map (\y -> square (y * y)) (seqn)


main = do
  print $ take 5 $ squareDigitsSum 136
  print $ take 5 $ squareDigitsSum 128
  print $ take 5 $ squareDigitsSum 26
