(* Первоначальный набор тестов для лабораторной работы №1 *)

(* Задание 1 *)
val testIsLeapYear1 = isLeapYear 2000 = true 
val testIsLeapYear2 = isLeapYear 2015 = false
val testIsLeapYear3 = isLeapYear 2016 = true
val testIsLeapYear4 = isLeapYear 2017 = false
val testIsLeapYear5 = isLeapYear 8000 = true
val testIsLeapYear6 = isLeapYear 8800 = true
val testIsLeapYear7 = isLeapYear 8401 = false

(* Задание 2 *)
val testIsCorrectDate1 = isCorrectDate (1,9,2016) = true
val testIsCorrectDate2 = isCorrectDate (21,13,1900) = false
val testIsCorrectDate3 = isCorrectDate (~12,3,1857) = false
val testIsCorrectDate4 = isCorrectDate (30,2,1892) = false
val testIsCorrectDate5 = isCorrectDate (29,2,2015) = false
val testIsCorrectDate6 = isCorrectDate (10,3,1515) = true

(* Задание 3 *)
val testNewStyleCorrection1 = newStyleCorrection (1,3,2016) = 13
val testNewStyleCorrection2 = newStyleCorrection (28,2,1700) = 10
val testNewStyleCorrection3 = newStyleCorrection (28,10,1700) = 11
val testNewStyleCorrection4 = newStyleCorrection (29,10,4000) = 28
val testNewStyleCorrection5 = newStyleCorrection (1,1,2000) = 13

(* Задание 4 *)
val testGetNthInt1 = 
  let val tmp = getNthInt ([25, ~615, 834, ~38, 0], 3) 
  in tmp = ~38
  end
val testGetNthInt2 = 
  let val tmp = getNthInt ([25, ~615, 834, ~38, 0], 1) 
  in tmp = ~615
  end
val testGetNthInt3 = 
  let val tmp = getNthInt ([1, 2, 3, 4, 5], 3) 
  in tmp = 4
  end

(* Задание 5 *)
val testGetNthStr1 = 
  getNthStr (["hi", "there", "how", "are", "you"], 2) = "how"
val testGetNthStr2 = 
  getNthStr (["Winter", "Summer", "April"], 2) = "April"
val testGetNthStr3 = 
  getNthStr (["Hello", "World!"], 1) = "World!"

(* Задание 6 *)
val testLastSmaller1 = lastSmaller (3654, [0, 25, 834, 3800]) = 834
val testLastSmaller2 = lastSmaller (1, [0, 5, 1, 22]) = 0
val testLastSmaller3 = lastSmaller (112, [223, 1223]) = 0

(* Задание 7 *)
val testFirstNewMoonInt1 = firstNewMoonInt (1,9,2016) = SOME 170823
val testFirstNewMoonInt2 = firstNewMoonInt (2,11,3236)= SOME 2050823
val testFirstNewMoonInt3 = firstNewMoonInt (2,2,3244) = NONE

(* Задание 8 *)
val testFirstNewMoon1  = firstNewMoon (1,9,2016) = SOME (1,9,2016)
val testFirstNewMoon2  = firstNewMoon (12,10,2016) = SOME (1,10,2016)
val testFirstNewMoon3  = firstNewMoon (1,9,2126) = SOME (16,9,2126)

(* Задание 9 *)
val testDateToString1  = dateToString (5,5,1980) = "May 5, 1980"
val testDateToString2  = dateToString (1,9,2016) = "September 1, 2016"
val testDateToString3  = dateToString (22,12,2320) = "December 22, 2320"
val testDateToString4  = dateToString (11,11,1111) = "November 11, 1111"

(* Задание 10 *)
val testIsOlder1 = isOlder ((1,2,3), (2,3,4)) = true
val testIsOlder2 = isOlder ((2,3,4), (1,2,3)) = false
val testIsOlder3 = isOlder ((11,12,2000), (11,12,2003)) = true
val testIsOlder4 = isOlder ((11,11,2000), (11,12,2000)) = true

(* Задание 11 *)
val testWinterSolstice1 = winterSolstice 0 = 22
val testWinterSolstice2 = winterSolstice 3 = 23
val testWinterSolstice3 = winterSolstice 2014 = 22
val testWinterSolstice4 = winterSolstice 2020 = 21
val testWinterSolstice5 = winterSolstice 2033 = 21

(* Задание 12 *)
val testChineseNewYear1 = chineseNewYear 2016 = (8,2,2016)
val testChineseNewYear2 = chineseNewYear 2019 = (4,2,2019)
val testChineseNewYear3 = chineseNewYear 2044 = (29,1,2044)

(* Задание 13 *)
val testChineseYear1 = 
  chineseYear 1980 = ("Geng-Shen","White","Monkey","Metal")
val testChineseYear2 = 
  chineseYear 2015 = ("Yi-Wei","Green","Sheep","Cut timber")
val testChineseYear3 = 
  chineseYear 2019 = ("Ji-Hai","Brown","Pig","Earthenware")
val testChineseYear4 = 
  chineseYear 2044 = ("Jia-Zi","Green","Rat","Growing wood")

(* Задание 14 *)
val testDateToChineseYear1 = 
  dateToChineseYear (1,9,1980) = ("Geng-Shen","White","Monkey","Metal")
val testDateToChineseYear2 = 
  dateToChineseYear (1,9,2016) = ("Bing-Shen","Red","Monkey","Natural fire")
val testDateToChineseYear3 = 
  dateToChineseYear (1,9,2019) = ("Ji-Hai","Brown","Pig","Earthenware")
val testDateToChineseYear4 = 
  dateToChineseYear (1,9,2044) = ("Jia-Zi","Green","Rat","Growing wood")

(* Задание 15 *)
val testDateToAnimal1 = 
  dateToAnimal (1,9,1980) = "Monkey"
val testDateToAnimal2 = 
  dateToAnimal (1,9,2016) = "Monkey"
val testDateToAnimal3 = 
  dateToAnimal (1,9,2019) = "Pig"
val testDateToAnimal4 = 
  dateToAnimal (1,9,2044) = "Rat"

(* Задание 16 *)
val testAnimal1 = 
  animal ("Ivan", (1,9,1980)) = "Monkey"
val testAnimal2 = 
  animal ("Svetlana", (1,9,2016)) = "Monkey"
val testAnimal3 = 
  animal ("Gregor", (1,1,2000)) = "Rabbit"
val testAnimal4 = 
  animal ("Afanasiy", (12,12,1988)) = "Dragon"

(* Вспомогательная функция для тестирования заданий 17 и 18
 * выдает true, когда элемент a присутствует в списке l 
 * иначе выдает false *)
fun member ( a : string * (int * int * int)
           , l : (string * (int * int * int)) list
           ) : bool =
  if null l then false
  else a = hd l orelse member (a, tl l)

(* Задание 17 *)
val testExtractAnimal1 = 
  extractAnimal ( [ ("Ivan", (1,9,1980))
                   , ("Svetlana", (1,9,2015)) ]
                 , "Monkey" ) 
  = [("Ivan", (1, 9, 1980))]
val testExtractAnimal2 = 
  let val tmp = extractAnimal ( [ ("Ivan", (1,9,1980))
                                 , ("Svetlana", (1,9,2015))
                                 , ("Alex", (1,9,1955)) 
                                 ]
                               , "Sheep" )
  in
    member (("Svetlana", (1,9,2015)), tmp)
    andalso member (("Alex", (1,9,1955)), tmp)
    andalso length tmp = 2
  end 
val testExtractAnimal3 = 
  extractAnimal ( [ ("Fedor", (1,1,1980))
                   , ("Svetlana", (1,1,1981)) ]
                 , "Monkey" ) 
  = [("Svetlana",(1,1,1981))]
val testExtractAnimal4 = 
  extractAnimal ( [ ("Fedor", (1,1,1980))
                   , ("Svetlana", (1,9,2015)) ]
                 , "Dragon" ) 
  = []

(* Задание 18 *)
val testExtractAnimals1 = 
  extractAnimals ( [ ("Ivan", (1,9,1980))
                    , ("Svetlana", (1,9,2015)) ]
                  , ["Monkey"] ) 
  = [("Ivan", (1,9,1980))]
val testExtractAnimals2 = 
  let val tmp = extractAnimals ( [ ("Ivan", (1,9,1980))
                                  , ("Svetlana", (1,9,2015)) 
                                  , ("Alex", (1,9,1955)) 
                                  ]
                                , ["Monkey", "Sheep"] )
  in
    member (("Svetlana", (1,9,2015)), tmp)
    andalso member (("Alex", (1,9,1955)), tmp)
    andalso member (("Ivan", (1,9,1980)), tmp)
    andalso length tmp = 3
  end
val testExtractAnimals3 = 
  extractAnimals ( [ ("Ivan", (1,9,1980))
                    , ("Svetlana", (1,9,2015)) ]
                  , ["Dragon"] ) 
  = []
val testExtractAnimals4 = 
  extractAnimals ( [ ("Ivan", (1,9,1980))
                    , ("Svetlana", (1,9,2000)) ]
                  , ["Dragon"] ) 
  = [("Svetlana",(1,9,2000))]

(* Задание 19 *)
val testOldest1 = 
  oldest [ ("Ivan", (1,9,1980))
         , ("Svetlana", (1,9,2015))
         , ("Alex", (1,9,1955)) ] 
  = SOME "Alex"
val testOldest2 = 
  oldest [ ("Ivan", (1,1,2000))
         , ("Svetlana", (1,1,2001))
         , ("Alex", (1,1,2002)) ] 
  = SOME "Ivan"
val testOldest3 = 
  oldest [ ("Ivan", (1,9,1980))
         , ("Svetlana", (2,9,1980))
         , ("Alex", (3,9,1980)) ] 
  = SOME "Ivan"

(* Задание 20 *)
val testOldestFromAnimals1 = 
  oldestFromAnimals ( [ ("Ivan", (1,9,1980))
                        , ("Svetlana", (1,9,2015)) 
                        , ("Alex", (1,9,1955)) 
                        ]
                      , ["Monkey", "Sheep"] ) 
  = SOME "Alex"
val testOldestFromAnimals2 = 
  oldestFromAnimals ( [ ("Ivan", (1,9,1980))
                        , ("Svetlana", (1,9,2015)) 
                        , ("Alex", (1,9,1955)) 
                        ]
                      , ["Dragon", "Rabbit"] ) 
  = NONE
val testOldestFromAnimals3 = 
  oldestFromAnimals ( [ ("Ivan", (1,9,2000))
                        , ("Svetlana", (1,9,2001)) 
                        , ("Alex", (1,9,1999)) 
                        ]
                      , ["Dragon", "Rabbit"] ) 
  = SOME "Alex"
