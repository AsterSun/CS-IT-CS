data Vector a = Vec3 (a, a, a)

xCoor (Vec3 (x, _, _)) = x

yCoor (Vec3 (_, y, _)) = y

zCoor (Vec3 (_, _, z)) = z

instance Show a => Show (Vector a) where
  show v = "(" ++show (xCoor v) ++ ", " 
           ++ show (yCoor v) ++ ", " 
           ++ show (zCoor v) ++ ")"

instance Eq a => Eq (Vector a) where
  (==) v1 v2 = (xCoor v1 == xCoor v2) 
               && (yCoor v1 == yCoor v2)
               && (zCoor v1 == zCoor v2)

instance (Num a, Floating a) => Num (Vector a) where
  (+) v1 v2 = Vec3 (xCoor v1 + xCoor v2, 
                    yCoor v1 + yCoor v2,
                    zCoor v1 + zCoor v2)

  (*) v1 v2 = Vec3 (yCoor v1 * zCoor v2 - yCoor v2 * zCoor v1,
                    zCoor v1 * xCoor v2 - zCoor v2 * xCoor v1,
                    xCoor v1 * yCoor v2 - xCoor v2 * yCoor v1)

  negate v = Vec3 (- xCoor v, - yCoor v, - zCoor v)

  abs v = Vec3 (sqrt((xCoor v) * (xCoor v) +
                     (yCoor v) * (yCoor v) + 
                     (zCoor v) * (zCoor v)), 0, 0)

  signum v = Vec3 (xCoor v / absVec,
                   yCoor v / absVec,
                   zCoor v / absVec)
    where absVec = xCoor (abs v)

  fromInteger n = Vec3 (fromInteger n, 0, 0)



-----
main = do

  let v1 = Vec3 (3, 4, 5)
  let v2 = Vec3 (6, 8, 10)

  print $ v1
  print $ xCoor v1
  print $ yCoor v1
  print $ zCoor v1

  print $ v1 + v2
  print $ v1 * v2
  print $ negate v1
  print $ abs v1
  print $ signum v1
  print $ v1 + fromInteger 3