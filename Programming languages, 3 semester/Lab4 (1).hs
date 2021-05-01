
-- Шаблон для выполнения заданий Лабораторной работы №4 
-- ВСЕ КОММЕНТАРИИ ПРИВЕДЕННЫЕ В ДАННОМ ФАЙЛЕ ДОЛЖНЫ ОСТАТЬСЯ НА СВОИХ МЕСТАХ
-- предыдущее замечание относится к тем комментариям, которые
-- не предполагают раскомментирование
-- НЕЛЬЗЯ ПЕРЕСТАВЛЯТЬ МЕСТАМИ КАКИЕ-ЛИБО БЛОКИ ДАННОГО ФАЙЛА
-- решения заданий должны быть вписаны в отведенные для этого позиции 

-- ниеже перечисляются имена, доступные после загрузки данного модуля
-- (например в файле с тестами)
-- по мере реализации решений заданий снимайте комментарий 
-- с соответствующей функции
module Lab4(
  Expr ( Var, IntNum, Add, IfGreater, Fun, Call, Let
       , Pair, Head, Tail, Unit, IsAUnit, Closure )
  , valOfIntNum
  , funName
  , funArg
  , funBody
  , pairHead
  , pairTail
  , closureFun
  , closureEnv
  , convertListToMUPL
  , convertListFromMUPL
  , envLookUp
  , evalExp
  , evalUnderEnv
  , ifAUnit
  , mLet
  , ifEq
  , mMap
  , mMapAddN
  , fact
  )
  where
--------------------------------------------------------------------------------
-- Вспомогательные определения
-- нельзя вносить изменения в следующий блок
--------------------------------------------------------------------------------
data Expr = Var String
          | IntNum Integer
          | Add Expr Expr
          | IfGreater Expr Expr Expr Expr
          | Fun String String Expr
          | Call Expr Expr
          | Let (String, Expr) Expr
          | Pair Expr Expr
          | Head Expr
          | Tail Expr
          | Unit 
          | IsAUnit Expr
          | Closure [(String, Expr)] Expr
  deriving (Show, Eq) 

valOfIntNum (IntNum n) = n
valOfIntNum e          = error $ "The expression " 
                                 ++ show (e) 
                                 ++ " is not a number"
--------------------------------------------------------------------------------
-- Задание 1 funName 
funName (Fun n a e) = n
funName e           = error $ "The expression "
                              ++ show e
                              ++ " is not a function"
-- Задание 2 funArg 
funArg (Fun n a e) = a
funArg e           = error $ "The expression "
                              ++ show e
                              ++ " is not a function"
-- Задание 3 funBody 
funBody (Fun n a e) = e
funBody e           = error $ "The expression "
                              ++ show e
                              ++ " is not a function"
-- Задание 4 pairHead 
pairHead (Pair x y) = x
pairHead e          = error $ "The expression "
                              ++ show e
                              ++ " is not a pair"
-- Задание 5 pairTail 
pairTail (Pair x y) = y
pairTail e          = error $ "The expression "
                              ++ show e
                              ++ " is not a pair"
-- Задание 6 closureFun 
closureFun (Closure env f) = f
closureFun e               = error $ "The expression "
                                     ++ show e
                                     ++ " is not a closure"
-- Задание 7 closureEnv 
closureEnv (Closure env f) = env
closureEnv e               = error $ "The expression "
                                     ++ show e
                                     ++ " is not a closure"
-- Задание 8 convertListToMUPL 
convertListToMUPL l = foldr (\x -> \y -> Pair x y) Unit l 
-- Задание 9 convertListFromMUPL 
convertListFromMUPL Unit = []
convertListFromMUPL (Pair x y) = x : (convertListFromMUPL y)
--------------------------------------------------------------------------------
-- Вспомогательные определения
-- нельзя вносить изменения в следующий блок
--------------------------------------------------------------------------------
envLookUp [] str = error $ "Unbound variable " ++ str
envLookUp ((var, expr) : xs) str 
  | var == str = expr
  | otherwise  = envLookUp xs str

evalExp e = evalUnderEnv e []
--------------------------------------------------------------------------------
-- Задание 10 evalUnderEnv 
-- Заданную строку определения изменять нельзя
-- необходимо дополнить определение функции
evalUnderEnv (Var name) env = envLookUp env name

evalUnderEnv (IntNum a) env = IntNum a

evalUnderEnv (Unit) env = Unit

evalUnderEnv (Closure env1 f) env = Closure env1 f

evalUnderEnv (Add x y) env =
  IntNum (valOfIntNum (evalUnderEnv x env) + valOfIntNum (evalUnderEnv y env))

evalUnderEnv (IfGreater x y mAns lAns) env =
  if (valOfIntNum (evalUnderEnv x env)) > (valOfIntNum (evalUnderEnv y env))
  then evalUnderEnv mAns env
  else evalUnderEnv lAns env

evalUnderEnv (Pair x y) env =
  Pair (evalUnderEnv x env) (evalUnderEnv y env)

evalUnderEnv (Head e) env = pairHead (evalUnderEnv e env)

evalUnderEnv (Tail e) env = pairTail (evalUnderEnv e env)

evalUnderEnv (IsAUnit a) env = 
  case (evalUnderEnv a env) of 
    Unit -> IntNum 1
    otherwise -> IntNum 0

evalUnderEnv (Let (str, e1) e2) env =
  evalUnderEnv e2 ((str, evalUnderEnv e1 env) : env)

evalUnderEnv (f @ (Fun n a e)) env = Closure env f

evalUnderEnv (Call e1 e2) env = evalUnderEnv (funBody closFun) srcEnv
  where
    closEnv = closureEnv (evalUnderEnv e1 env)
    closFun = closureFun (evalUnderEnv e1 env)
    plusEnv = (funArg closFun, evalUnderEnv e2 env) : closEnv
    srcEnv = if (funName closFun) == ""
      then plusEnv
      else ((funName closFun), evalUnderEnv e1 env) : plusEnv

--------------------------------------------------------------------------------
-- Последующие решения связывают переменные Haskellа с выражениями на MUPL
-- (определяют макросы языка MUPL)
-- Задание 11 ifAUnit 
ifAUnit e tAns fAns =
  IfGreater (IsAUnit e) (IntNum 0) tAns fAns
-- Задание 12 mLet 
mLet (l:lst) e = Let l (mLet lst e)
mLet [] e = e
-- Задание 13 ifEq 
ifEq e1 e2 tAns fAns =
  mLet [("_x", e1), ("_y", e2)]
    (IfGreater (Var "_x") (Var "_y") fAns 
      (IfGreater (Var "_y") (Var "_x") fAns tAns))
-- Задание 14 mMap 
mMap =
  Fun "map" "f"
    (Fun "" "lst" (ifAUnit (Var "lst") Unit 
      (Pair (Call (Var "f") (Head (Var "lst")))
            (Call (Call (Var "map") (Var "f")) (Tail (Var "lst"))))))
-- Задание 15 mMapAddN 
mMapAddN =
  Call (Fun "" "x" (Call mMap (Fun "" "y" (Add (Var "x") (Var "y")))))
-- Задание 16 fact 
fact = 
  mLet [
    ("-1", Fun "-1" "x" 
      (Call (Fun "+1" "res" (Let ("hlp", Add (IntNum 1) (Var "res"))
                  (ifEq (Var "x") (Var "hlp") 
                    (Var "res")
                    (Call (Var "+1") (Var "hlp")))))
      (IntNum 0))),
    ("*", Fun "*" "x" ((Fun "*-1" "tmp" 
                            (ifEq (Var "tmp") (IntNum 0)
                              (IntNum 0) 
                              (Add (Var "x") 
                                (Call (Var "*-1") 
                                (Call (Var "-1") (Var "tmp"))))))))
        ]
  (Fun "fact" "n" (IfGreater (IntNum 2) (Var "n")
                  (IntNum 1) 
                  (Call (Call (Var "*") (Var "n")) 
                        (Call (Var "fact") 
                              (Call (Var "-1")(Var "n"))))))

