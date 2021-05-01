sinStream a = tail partSumSeq
  where
    partSumSeq = 0 : 0 : zipWith (+) (tail partSumSeq) (termSeq a)
    termSeq a = map (oneOfTermSeq a) [0 ..]
    oneOfTermSeq x i = ((-1) ^ i) 
                       * (x ^ (2 * i + 1))
                       / fromInteger (factorial (2 * i + 1))
    factorial n | n <= 0    = 1
                | otherwise = n * factorial (n - 1)

main = do
  print $ take 10 $ sinStream 1
  print $ drop 5 $ take 10 $ sinStream 1
  print $ take 10 $ sinStream 2 