data Complex a = ComplRect (a, a)
                 | ComplPolar (a, a)

rectToPolar (ComplRect (a, b)) = ComplPolar (sqrt (a * a + b * b), atan2 b a)

polarToRect (ComplPolar (a, b)) = ComplRect (a * cos b, a * sin b)

re (ComplRect (a, _)) = a

im (ComplRect (_, b)) = b

magnitude (ComplPolar (r, _)) = r

angle (ComplPolar (_, a)) = a

instance (Show a) => Show (Complex a) where
  show (ComplRect (a, b)) = 
    "(" ++ show a ++ " + " ++ show b ++ "i)"
  show (ComplPolar (r, a)) =
    "(" ++ show r ++ " * e ^ {i *" ++ show a ++ "})"

instance (Floating a) => Eq (Complex a) where
  (==) c1 c2 = (re c1 == re c2) && (im c1 == im c2)

instance (RealFloat a) => Num (Complex a) where
  (+) c1 c2 = ComplRect (re c1 + re c2, im c1 + im c2)
  (*) c1 c2 = ComplPolar (magnitude c1 * magnitude c2,
                          angle c1 + angle c2)
  negate a = ComplRect (-(re a), -(im a))
  abs a = ComplPolar (abs (magnitude a), 0)
  signum a = ComplRect (signum (re a), signum (im a))
  fromInteger n = ComplRect (fromInteger n, 0)

instance (RealFloat a) => Fractional (Complex a) where
  (/) c1 c2 = ComplPolar (magnitude c1 / magnitude c2, angle c1 - angle c2)

main = do
  let i1 = ComplRect (5, 10)
  let i2 = ComplPolar (3, 6)

  print $ i1
  print $ i2
