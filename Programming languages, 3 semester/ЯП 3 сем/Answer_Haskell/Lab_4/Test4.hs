-- Первоначальный набор тестов для лабораторной работы №4
-- по мере реализации решений заданий снимайте комментарий 
-- с тестов соответствующей функции и пополняйте их своими тестами
-- кроме того, снимайте комментарий соответствующих строк вывода 
-- результатов тестов в функции main в конце файла и пополняйте эту 
-- функцию своими строками

-- Для проведения тестов запустите этот файл и выполните запуск main

import Lab4
--------------------------------------------------------------------------------
-- Блок вспомогательных определений
-- Не вносите изменения в этот блок
--------------------------------------------------------------------------------
import Control.Exception

-- вспомогательная функция, для вывода на экран True, когда 
-- возникает сообщение об ошибке
handler1 = (\_ -> putStrLn "True") :: Exception -> IO ()

-- вспомогательная функция, для вывода на экран False, когда 
-- возникает сообщение об ошибке
handler2 = (\_ -> putStrLn "False") :: Exception -> IO ()
--------------------------------------------------------------------------------

------ Задание 1 funName 
test_funName_1 = funName (Fun "" "a" Unit) == ""
test_funName_2 = funName Unit == []
test_funName_3 = funName (Fun "snow" "a" Unit) == "snow"
test_funName_4 = funName (Fun "test" "a" Unit) == "test"

------ Задание 2 funArg 
test_funArg_1 = funArg (Fun "" "a" Unit) == "a"
test_funArg_2 = funArg Unit == []
test_funArg_3 = funArg (Fun "" "show" Unit) == "show"
test_funArg_4 = funArg (Fun "" "test" Unit) == "test"


------ Задание 3 funBody 
test_funBody_1 = funBody (Fun "" "a" Unit) == Unit
test_funBody_2 = funBody Unit == Unit
test_funBody_3 = funBody (Fun "" "snow" Unit) == Unit
test_funBody_4 = funBody (Fun "" "test" Unit) == Unit

------ Задание 4 pairHead 
test_pairHead_1 = pairHead (Pair (Var "a") Unit) == Var "a"
test_pairHead_2 = pairHead Unit == Unit
test_pairHead_3 = pairHead (Pair (Var "snow") Unit) == Var "snow"
test_pairHead_4 = pairHead (Pair (Var "test") Unit) == Var "test"

------ Задание 5 pairTail 
test_pairTail_1 = pairTail (Pair (Var "a") Unit) == Unit
test_pairTail_2 = pairTail Unit == Unit
test_pairTail_3 = pairTail (Pair (Var "snow") Unit) == Unit
test_pairTail_4 = pairTail (Pair (Var "test") Unit) == Unit

------ Задание 6 closureFun 
test_closureFun_1 = closureFun (Closure [] (Fun "" "a" Unit)) 
                    == (Fun "" "a" Unit)
test_closureFun_2 = closureFun Unit == Unit 
test_closureFun_3 = closureFun (Closure [] (Fun "" "snow" Unit)) 
                    == (Fun "" "snow" Unit)


------ Задание 7 closureEnv 
test_closureEnv_1 = closureEnv (Closure [] (Fun "" "a" Unit)) == []
test_closureEnv_2 = closureEnv Unit == [("a", IntNum 5)]
test_closureEnv_3 = closureEnv (Closure [] (Fun "" "snow" Unit)) == []
test_closureEnv_4 = closureEnv (Closure [] (Fun "" "test" Unit)) == []

------ Задание 8 convertListToMUPL 
test_convertListToMUPL_1 = convertListToMUPL [] == Unit
test_convertListToMUPL_2 = convertListToMUPL [Unit] == Pair Unit Unit

------ Задание 9 convertListFromMUPL 
test_convertListFromMUPL_1 = convertListFromMUPL Unit == []
test_convertListFromMUPL_2 = convertListFromMUPL (Pair Unit Unit) == [Unit]


---- Запуск всех тестов

main = do      
  putStr ("1 test_funName_1 ")
  Control.Exception.catch (putStrLn $ show test_funName_1) handler2 
  putStr ("1 test_funName_2 ")
  Control.Exception.catch (putStrLn $ show test_funName_2) handler1
  putStr ("1 test_funName_3 ")
  Control.Exception.catch (putStrLn $ show test_funName_3) handler2 
  putStr ("1 test_funName_4 ")
  Control.Exception.catch (putStrLn $ show test_funName_4) handler2 

  putStr ("2 test_funArg_1 ")
  Control.Exception.catch (putStrLn $ show test_funArg_1) handler2 
  putStr ("2 test_funArg_2 ")
  Control.Exception.catch (putStrLn $ show test_funArg_2) handler1 
  putStr ("2 test_funArg_3 ")
  Control.Exception.catch (putStrLn $ show test_funArg_3) handler2 
  putStr ("2 test_funArg_4 ")
  Control.Exception.catch (putStrLn $ show test_funArg_4) handler2 

  putStr ("3 test_funBody_1 ")
  Control.Exception.catch (putStrLn $ show test_funBody_1) handler2 
  putStr ("3 test_funBody_2 ")
  Control.Exception.catch (putStrLn $ show test_funBody_2) handler1 
  putStr ("3 test_funBody_3 ")
  Control.Exception.catch (putStrLn $ show test_funBody_3) handler2 
  putStr ("3 test_funBody_4 ")
  Control.Exception.catch (putStrLn $ show test_funBody_4) handler2 

  putStr ("4 test_pairHead_1 ")
  Control.Exception.catch (putStrLn $ show test_pairHead_1) handler2 
  putStr ("4 test_pairHead_2 ")
  Control.Exception.catch (putStrLn $ show test_pairHead_2) handler1 
  putStr ("4 test_pairHead_3 ")
  Control.Exception.catch (putStrLn $ show test_pairHead_3) handler2 
  putStr ("4 test_pairHead_4 ")
  Control.Exception.catch (putStrLn $ show test_pairHead_4) handler2 

  putStr ("5 test_pairTail_1 ")
  Control.Exception.catch (putStrLn $ show test_pairTail_1) handler2 
  putStr ("5 test_pairTail_2 ")
  Control.Exception.catch (putStrLn $ show test_pairTail_2) handler1 
  putStr ("5 test_pairTail_3 ")
  Control.Exception.catch (putStrLn $ show test_pairTail_3) handler2 
  putStr ("5 test_pairTail_4 ")
  Control.Exception.catch (putStrLn $ show test_pairTail_4) handler2 

  putStr ("6 test_closureFun_1 ")
  Control.Exception.catch (putStrLn $ show test_closureFun_1) handler2 
  putStr ("6 test_closureFun_2 ")
  Control.Exception.catch (putStrLn $ show test_closureFun_2) handler1 
  putStr ("6 test_closureFun_3 ")
  Control.Exception.catch (putStrLn $ show test_closureFun_3) handler2 

  putStr ("7 test_closureEnv_1 ")
  Control.Exception.catch (putStrLn $ show test_closureEnv_1) handler2 
  putStr ("7 test_closureEnv_2 ")
  Control.Exception.catch (putStrLn $ show test_closureEnv_2) handler1 
  putStr ("7 test_closureEnv_3 ")
  Control.Exception.catch (putStrLn $ show test_closureEnv_3) handler2 
  putStr ("7 test_closureEnv_4 ")
  Control.Exception.catch (putStrLn $ show test_closureEnv_4) handler2 

  putStr ("8 test_convertListToMUPL_1 ")
  Control.Exception.catch (putStrLn $ show test_convertListToMUPL_1) handler2 
  putStr ("8 test_convertListToMUPL_2 ")

  Control.Exception.catch (putStrLn $ show test_convertListToMUPL_2) handler2 
  putStr ("9 test_convertListFromMUPL_1 ")
  Control.Exception.catch (putStrLn $ show test_convertListFromMUPL_1) handler2 
  putStr ("9 test_convertListFromMUPL_2 ")
  Control.Exception.catch (putStrLn $ show test_convertListFromMUPL_2) handler2 

  putStrLn "all tests done"


