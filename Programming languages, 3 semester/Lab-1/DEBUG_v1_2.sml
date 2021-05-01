(*******************************************************************************
                     SoursXond // DEBUG 1.2 // 22.09.2019                       
*******************************************************************************)
structure D =
  struct
    type n_dt = string * (int * int * int)
    val listStr = ["1","2","3","4","5","6","7","8","9"]
    val listInt = [1,2,3,4,5,6,7,8,9]
    val studList =    [ ("Svetlana", (20,2, 2015)), ("Serega", (18,2, 1980))
                      , ("Sanya", (19,2, 2007)), ("Djegun", (16,2, 2015))
                      , ("Pavel", (14,2, 1980)), ("Maksim", (15,2, 2007))
                      , ("Svetlana2", (13,1, 2007)), ("Serega2", (2,2, 1980))
                      , ("Sanya2", (31,1, 2015)), ("Djegun2", (30,5, 2007))
                      , ("Pavel2", (31,8, 1980)), ("Maksim2", (22,12, 2015)) ]

    val studSheepL =  [ ("Svetlana",(20,2,2015)), ("Pavel",(14,2,1980))
                      , ("Serega2",(2,2,1980)), ("Maksim2",(22,12,2015)) ]

    val studMonkeyL = [("Serega",(18,2,1980)),("Pavel2",(31,8,1980))]
    val studPig =     [("Sanya",(19,2,2007)),("Djegun2",(30,5,2007))]
    val studHorseL =  [("Djegun",(16,2,2015)),("Sanya2",(31,1,2015))]
    val studDogL =    [("Maksim",(15,2,2007)),("Svetlana2",(13,1,2007))]

    val sEq =         [("Serega_Equal",(2,2,1980))]

    fun delta (x1, x2, delt) = abs (x1 - x2) <= delt
    fun getN (l : 'a list, n : int) : 'a =
      if null (tl l) orelse n < 1 then hd l else getN (tl l, n - 1)
    fun dNext (d, m, y) =
      if isCorrectDate (d + 1, m, y) then (d + 1, m, y) else
      if isCorrectDate (1, m + 1, y) then (1, m + 1, y) else (1, 1, y + 1)
    fun dPred (d, m, y) =
      if isCorrectDate (d - 1, m, y) then (d - 1, m, y) else
      if isCorrectDate (31, m - 1, y) then (31, m - 1, y) else
      if isCorrectDate (30, m - 1, y) then (30, m - 1, y) else
      if isCorrectDate (29, m - 1, y) then (29, m - 1, y) else
      if isCorrectDate (28, m - 1, y) then (28, m - 1, y) else
      if isCorrectDate (31, 12, y - 1) then (31, 12, y - 1) else (0,0,0)
    fun equalD (date1 : int * int * int, date2 : int * int * int) : bool =
      isCorrectDate date1 andalso (date1 = date2 orelse date1 = dNext date2
                                                 orelse date1 = dPred date2)
      fun compare (l1 : n_dt list, l2 : n_dt list) : bool =
        let 
          fun f (l1x : n_dt list, l2x : n_dt list) =
            if null l2x then true
            else if null l1x then false else
                 (hd l1x = hd l2x orelse f (tl l1x, l2x)) andalso f (l1, tl l2x)
        in
          f (l1, l2)
        end
      fun ifcomp (l1 : n_dt list, l2 : n_dt list) = 
        compare (l1,l2) = compare (l2,l1)
  end

val task1_test1 = isLeapYear 400  = true
val task1_test2 = isLeapYear 100  = false
val task1_test3 = isLeapYear 1000 = false
val task1_test4 = isLeapYear 1100 = false
val task1_test5 = isLeapYear 1004 = true
val task1_test6 = isLeapYear 1040 = true
val task1_test7 = isLeapYear 1600 = true

val task2_test1 = isCorrectDate (1,2,3)      = true
val task2_test2 = isCorrectDate (1,2,0)      = false
val task2_test3 = isCorrectDate (1,2,~1)     = false
val task2_test4 = isCorrectDate (1,0,1)      = false
val task2_test5 = isCorrectDate (1,~1,1)     = false
val task2_test6 = isCorrectDate (0,1,1)      = false
val task2_test7 = isCorrectDate (~1,1,1)     = false
val task2_test8 = isCorrectDate (1,13,1)     = false
val task2_test9 = isCorrectDate (32,1,2019)  = false
val task2_test10 = isCorrectDate (30,2,2019) = false
val task2_test11 = isCorrectDate (29,2,2000) = true
val task2_test12 = isCorrectDate (29,2,2001) = false
val task2_test13 = isCorrectDate (31,1,2001) = true
val task2_test14 = isCorrectDate (31,4,2001) = false
val task2_test15 = isCorrectDate (31,7,2001) = true
val task2_test16 = isCorrectDate (31,8,2001) = true
val task2_test17 = isCorrectDate (31,9,2001) = false

val task3_test1 = newStyleCorrection (5,10,1582)  = 10
val task3_test2 = newStyleCorrection (29,2,1600)  = 10
val task3_test3 = newStyleCorrection (28,2,1700)  = 10
val task3_test4 = newStyleCorrection (29,2,1700)  = 11
val task3_test5 = newStyleCorrection (1,1,2000)   = 13
val task3_test6 = newStyleCorrection (1,1,2001)   = 13
val task3_test7 = newStyleCorrection (28,2,2000)  = 13
val task3_test8 = newStyleCorrection (29,2,2000)  = 13
val task3_test9 = newStyleCorrection (31,1,2019)  = 13
val task3_test10 = newStyleCorrection (28,2,2100) = 13
val task3_test11 = newStyleCorrection (1,3,2100)  = 14
val task3_test12 = newStyleCorrection (1,3,2200)  = 15
val task3_test13 = newStyleCorrection (1,3,2300)  = 16
val task3_test14 = newStyleCorrection (1,3,2400)  = 16

val task4_test1 = getNthInt (D.listInt, 0) = 1
val task4_test2 = getNthInt (D.listInt, 2) = 3
val task4_test3 = getNthInt (D.listInt, 8) = 9
val task4_test4 = getNthInt (D.listInt, 4) = 5
val task4_test5 = getNthInt ([100,200,300,400,500,600,700,800,900], 3) = 400

val task5_test1 = getNthStr (D.listStr, 0) = "1"
val task5_test2 = getNthStr (D.listStr, 2) = "3"
val task5_test3 = getNthStr (D.listStr, 8) = "9"
val task5_test4 = getNthStr (D.listStr, 4) = "5"
val task5_test5 = getNthStr (["100","200","300","400","500", "600"], 3) = "400"

val task6_test1 = lastSmaller (10, D.listInt) = 9
val task6_test2 = lastSmaller (9, D.listInt)  = 8
val task6_test3 = lastSmaller (1, D.listInt)  = 0
val task6_test4 = lastSmaller (0, D.listInt)  = 0
val task6_test5 = lastSmaller (2, D.listInt)  = 1
val task6_test6 = lastSmaller (5, D.listInt)  = 4

val task7_test1 = firstNewMoonInt (1,12,2024) = SOME 100823
val task7_test2 = firstNewMoonInt (1,2,2033)  = NONE
val task7_test3 = firstNewMoonInt (1,9,2016)  = SOME 170823
(*Если выпадает солнцестояние на 29 февраля*)

val task8_test1 = firstNewMoon (1,12,2024)  = SOME (1,12,2024)
val task8_test2 = firstNewMoon (1,2,2033)   = NONE
val task8_test3 = firstNewMoon (1,9,2016)   = SOME (1,9,2016)
val task8_test4 = firstNewMoon (1,1,2015)   = SOME (20,1,2015)
val task8_test5 = firstNewMoon (1,1,2014)   = SOME (1,1,2014)
val task8_test6 = firstNewMoon (1,2,2003)   = SOME (1,2,2003)
val task8_test7 = firstNewMoon (1,2,1995)   = NONE
val task8_test8 = firstNewMoon (1,2,1900)   = NONE
val task8_test9 = firstNewMoon (31,8,1234)  = SOME (3,8,1234)
val task8_test10 = firstNewMoon (31,3,1900) = SOME (1,3,1900)

val task9_test1 = dateToString (1,1,1)      = "January 1, 1"
val task9_test2 = dateToString (28,2,10)    = "February 28, 10"
val task9_test3 = dateToString (3,3,100)    = "March 3, 100"
val task9_test4 = dateToString (26,4,1000)  = "April 26, 1000"
val task9_test5 = dateToString (5,5,2019)   = "May 5, 2019"
val task9_test6 = dateToString (24,6,2077)  = "June 24, 2077"
val task9_test7 = dateToString (7,7,1979)   = "July 7, 1979"
val task9_test8 = dateToString (22,8,2048)  = "August 22, 2048"
val task9_test9 = dateToString (9,9,1234)   = "September 9, 1234"
val task9_test10 = dateToString (5,10,2000) = "October 5, 2000"
val task9_test11 = dateToString (18,11,321) = "November 18, 321"
val task9_test12 = dateToString (13,12,32)  = "December 13, 32"

val task10_test1 = isOlder ((1,1,1),(2,2,2)) = true
val task10_test2 = isOlder ((1,1,1),(1,1,1)) = false
val task10_test3 = isOlder ((1,1,1),(1,1,2)) = true
val task10_test4 = isOlder ((1,1,2),(1,1,1)) = false
val task10_test5 = isOlder ((1,1,1),(1,2,1)) = true
val task10_test6 = isOlder ((1,2,1),(1,1,1)) = false
val task10_test7 = isOlder ((1,1,1),(2,1,1)) = true
val task10_test8 = isOlder ((2,1,1),(1,1,1)) = false
val task10_test9 = isOlder ((2,2,2),(1,1,1)) = false
val task10_test10 = isOlder ((5,10,2000),(7,12,2010)) = true

val task11_test1 = D.delta (winterSolstice 2018, 22, 0)
val task11_test2 = D.delta (winterSolstice 2017, 21, 1)
val task11_test3 = D.delta (winterSolstice 2013, 21, 1)
val task11_test4 = D.delta (winterSolstice 2009, 21, 1)
val task11_test5 = D.delta (winterSolstice 2007, 22, 0)
val task11_test7 = D.delta (winterSolstice 1903, 23, 0)
val task11_test8 = D.delta (winterSolstice 2303, 23, 0)
val task11_test9 = D.delta (winterSolstice 2307, 23, 0)
val task11_test10 = D.delta (winterSolstice 2311, 23, 0)
val task11_test11 = D.delta (winterSolstice 2315, 23, 0)

val task12_test1 = D.equalD (chineseNewYear 2025, (29,1,2025))
val task12_test2 = D.equalD (chineseNewYear 2019, (5,2,2019))
val task12_test3 = D.equalD (chineseNewYear 2018, (16,2,2018))
val task12_test4 = D.equalD (chineseNewYear 2017, (28,1,2017))
val task12_test5 = D.equalD (chineseNewYear 2016, (8,2,2016))
val task12_test7 = D.equalD (chineseNewYear 2015, (19,2,2015))
val task12_test8 = D.equalD (chineseNewYear 2014, (31,1,2014))
val task12_test9 = D.equalD (chineseNewYear 2000, (5,2,2000))
val task12_test10 = D.equalD (chineseNewYear 1900, (31,1,1900))
val task12_test11 = D.equalD (chineseNewYear 1903, (29,1,1903))
val task12_test12 = D.equalD (chineseNewYear 1906, (25,1,1906))
val task12_test13 = D.equalD (chineseNewYear 1909, (22,1,1909))
val task12_test14 = D.equalD (chineseNewYear 1919, (1,2,1919))

val task13_test1 = chineseYear 2015 = ("Yi-Wei","Green","Sheep","Cut timber")
val task13_test2 = chineseYear 1980 = ("Geng-Shen","White","Monkey","Metal")
val task13_test3 = chineseYear 2007 = ("Ding-Hai","Red","Pig","Artificial fire")
val task13_test4 = chineseYear 2017 = ("Ding-You","Red","Chicken","Artificial fire")
val task13_test5 = chineseYear 2025 = ("Yi-Si","Green","Snake","Cut timber")
val task13_test7 = chineseYear 2022 = ("Ren-Yin","Black","Tiger","Running water")

val task14_test1 = dateToChineseYear (20,2, 2015)
  = ("Yi-Wei","Green","Sheep","Cut timber")
val task14_test2 = dateToChineseYear (18,2, 1980)
  = ("Geng-Shen","White","Monkey","Metal")
val task14_test3 = dateToChineseYear (19,2, 2007)
  = ("Ding-Hai","Red","Pig","Artificial fire")
val task14_test4 = dateToChineseYear (16,2, 2015)
  = ("Jia-Wu","Green","Horse","Growing wood")
val task14_test5 = dateToChineseYear (14,2, 1980)
  = ("Ji-Wei","Brown","Sheep","Earthenware")
val task14_test6 = dateToChineseYear (15,2, 2007)
  = ("Bing-Xu","Red","Dog","Natural fire")

val task15_test1 = dateToAnimal (#2 (D.getN (D.studList, 0))) = "Sheep"
val task15_test2 = dateToAnimal (#2 (D.getN (D.studList, 1))) = "Monkey"
val task15_test3 = dateToAnimal (#2 (D.getN (D.studList, 2))) = "Pig"
val task15_test4 = dateToAnimal (#2 (D.getN (D.studList, 3))) = "Horse"
val task15_test5 = dateToAnimal (#2 (D.getN (D.studList, 4))) = "Sheep"
val task15_test6 = dateToAnimal (#2 (D.getN (D.studList, 5))) = "Dog"

                      (* [0]: (20, 2, 2015)    ||        /\             *
                       * [1]: (18, 2, 1980)    ||        ||             *
                       * [2]: (19, 2, 2007)    ||        ||             *
                       * [3]: (16, 2, 2015)    ||        ||             *
                       * [4]: (14, 2, 1980)    ||        ||             *
                       * [5]: (15, 2, 2007)    \/        ||             *)

val task16_test1 = animal (D.getN (D.studList, 0)) = "Sheep"
val task16_test2 = animal (D.getN (D.studList, 1)) = "Monkey"
val task16_test3 = animal (D.getN (D.studList, 2)) = "Pig"
val task16_test4 = animal (D.getN (D.studList, 3)) = "Horse"
val task16_test5 = animal (D.getN (D.studList, 4)) = "Sheep"
val task16_test6 = animal (D.getN (D.studList, 5)) = "Dog"

val task17_test1 =
  D.ifcomp (extractAnimal (D.studList, "Sheep") , D.studSheepL)
val task17_test2 =
  D.ifcomp (extractAnimal (D.studList, "Monkey"), D.studMonkeyL)
val task17_test3 =
  D.ifcomp (extractAnimal (D.studList, "Pig"), D.studPig)
val task17_test4 =
  D.ifcomp (extractAnimal (D.studList, "Horse") , D.studHorseL)
val task17_test5 =
  D.ifcomp (extractAnimal (D.studList, "Dog")   , D.studDogL)

val task18_test1 =
  D.ifcomp ( extractAnimals (D.studList, ["Sheep","Monkey"])
            , D.studSheepL @ D.studMonkeyL )
val task18_test2 =
  D.ifcomp ( extractAnimals (D.studList, ["Monkey","Dog"])
            , D.studMonkeyL @ D.studDogL )
val task18_test3 =
  D.ifcomp ( extractAnimals (D.studList, ["Pig","Horse"])
            , D.studPig @ D.studHorseL )
val task18_test4 =
  D.ifcomp ( extractAnimals (D.studList, ["Sheep","Dog"])
            , D.studSheepL @ D.studDogL )
val task18_test5 =
  D.ifcomp ( extractAnimals (D.studList, ["Dog","Pig"])
            , D.studDogL @ D.studPig )

val task19_test1 = oldest (D.studList)   = SOME (#1 (D.getN (D.studList, 7)))
val task19_test2 = oldest (D.studPig)    = SOME (#1 (D.getN (D.studPig, 0)))
val task19_test3 = oldest (D.studHorseL) = SOME (#1 (D.getN (D.studHorseL, 1)))
val task19_test4 = oldest (D.studDogL)   = SOME (#1 (D.getN (D.studDogL, 1)))
val task19_test5 = oldest [] = NONE
val task19_test6 = oldest (D.studSheepL @ D.sEq)
  = SOME ((#1 (D.getN (D.studSheepL, 2))))

val task20_test1 = oldestFromAnimals (D.studList, ["Sheep", "Monkey"]) =
  SOME (#1 (D.getN (D.studList, 7)))
val task20_test2 = oldestFromAnimals (D.studDogL, ["Sheep", "Monkey"]) =
  NONE
val task20_test3 = oldestFromAnimals (D.studDogL, ["Sheep", "Dog"]) =
  SOME (#1 (D.getN (D.studDogL, 1)))
val task20_test4 = oldestFromAnimals (D.studSheepL @ D.sEq, ["Sheep","Dog"]) =
  SOME (#1 (D.getN (D.studList, 7)))
val task20_test5 = oldestFromAnimals (D.sEq, ["Sheep"]) =
  SOME (#1 (D.getN (D.sEq, 0)))