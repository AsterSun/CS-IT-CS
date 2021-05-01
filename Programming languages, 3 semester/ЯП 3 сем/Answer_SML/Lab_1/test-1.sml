(* Первоначальный набор тестов для лабораторной работы №1 *)

(* Задание 1 *)
val testIsLeapYear1 = isLeapYear 2000 = true 
val testIsLeapYear2 = isLeapYear 2015 = false
val testIsLeapYear3 = isLeapYear 2016 = true
val testIsLeapYear4 = isLeapYear 2017 = false
val testIsLeapYear5 = isLeapYear 2018 = false

(* Задание 2 *)
val testIsCorrectDate1 = isCorrectDate (1,9,2016) = true
val testIsCorrectDate2 = isCorrectDate (21,13,1900) = false
val testIsCorrectDate3 = isCorrectDate (12,~3,1857) = false
val testIsCorrectDate4 = isCorrectDate (5,15,1857) = false

(* Задание 3 *)
val testNewStyleCorrection1 = newStyleCorrection (1,3,2016) = 13
val testNewStyleCorrection2 = newStyleCorrection (28,2,1700) = 10
val testNewStyleCorrection3 = newStyleCorrection (20,2,1800) = 11
val testNewStyleCorrection4 = newStyleCorrection (20,2,1950) = 13
val testNewStyleCorrection5 = newStyleCorrection (20,2,1300) = 7

(* Задание 4 *)
val testGetNthInt1 = 
  let val tmp = getNthInt ([25, ~615, 834, ~38, 0], 3) 
  in tmp = ~38
  end
val testGetNthInt2 = getNthInt ([0, 1, 2, 5, 4], 3) = 5
val testGetNthInt3 = getNthInt ([1, 2, 3, 4, 5], 1) = 2
val testGetNthInt4 = getNthInt ([0, 6], 1) = 6
val testGetNthInt5 = getNthInt ([9, 1, 4], 0) = 9


(* Задание 5 *)
val testGetNthStr1 = 
  getNthStr (["hi", "there", "how", "are", "you"], 2) = "how"
val testGetNthStr2 = 
  getNthStr (["hi", "there", "how", "are", "you"], 3) = "are"
  val testGetNthStr3 = 
  getNthStr (["hi", "there", "how", "are", "you"], 4) = "you"

(* Задание 6 *)
val testLastSmaller1 = lastSmaller (3654, [0, 25, 834, 3800]) = 834 
val testLastSmaller2 = lastSmaller (50, [0, 25, 834, 3800]) = 25 
val testLastSmaller3 = lastSmaller (20, [0, 25, 834, 3800]) = 0 

(* Задание 7 *)
val testFirstNewMoonInt1 = firstNewMoonInt (1,9,2016) = SOME 170823
val testFirstNewMoonInt2 = firstNewMoonInt (1,9,2010) = SOME 843882
val testFirstNewMoonInt3 = firstNewMoonInt (1,9,1980) = SOME 963882

(* Задание 8 *)
val testFirstNewMoon1  = firstNewMoon (1,9,2016) = SOME (1,9,2016)
val testFirstNewMoon2  = firstNewMoon (1,9,2010) = SOME (8,9,2010)
val testFirstNewMoon3  = firstNewMoon (1,9,1980) = SOME (9,9,1980)

(* Задание 9 *)
val testDateToString1  = dateToString (5,5,1980) = "May 5, 1980"
val testDateToString2  = dateToString (1,9,2016) = "September 1, 2016"
val testDateToString3  = dateToString (2,9,1980) = "September 2, 1980"
val testDateToString4  = dateToString (5,5,2016) = "May 5, 2016"

(* Задание 10 *)
val testIsOlder1 = isOlder ((1,2,3), (2,3,4)) = true
val testIsOlder2 = isOlder ((2,3,4), (1,2,3)) = false
val testIsOlder3 = isOlder ((1,3,4), (2,4,6)) = true
val testIsOlder4 = isOlder ((2,2,2), (2,2,3)) = true

(* Задание 11 *)
val testWinterSolstice1 = winterSolstice 0 = 22
val testWinterSolstice2 = winterSolstice 3 = 23
val testWinterSolstice3 = winterSolstice 2014 = 22
val testWinterSolstice4 = winterSolstice 2017 = 22
val testWinterSolstice5 = winterSolstice 2018 = 22

(* Задание 12 *)
val testChineseNewYear1 = chineseNewYear 2016 = (8,2,2016)
val testChineseNewYear2 = chineseNewYear 2017 = (27,1,2017)
val testChineseNewYear3 = chineseNewYear 2018 = (15,2,2018)

(* Задание 13 *)
val testChineseYear1 = 
  chineseYear 1980 = ("Geng-Shen","White","Monkey","Metal")
val testChineseYear2 = 
  chineseYear 2015 = ("Yi-Wei","Green","Sheep","Cut timber")
  val testChineseYear3 = 
  chineseYear 2020 = ("Geng-Zi","White","Rat","Metal")
  val testChineseYear4 = 
  chineseYear 1950 = ("Geng-Yin","White","Tiger","Metal")

(* Задание 14 *)
val testDateToChineseYear1 = 
  dateToChineseYear (1,9,1980) = ("Geng-Shen","White","Monkey","Metal")
val testDateToChineseYear2 = 
  dateToChineseYear (1,9,2016) = ("Bing-Shen","Red","Monkey","Natural fire")
val testDateToChineseYear3 = 
  dateToChineseYear (1,9,2020) = ("Geng-Zi","White","Rat","Metal")
val testDateToChineseYear4 = 
  dateToChineseYear (1,9,1950) = ("Geng-Yin","White","Tiger","Metal")

(* Задание 15 *)
val testDateToAnimal1 = 
  dateToAnimal (1,9,1980) = "Monkey"
val testDateToAnimal2 = 
  dateToAnimal (1,9,2016) = "Monkey"
val testDateToAnimal3 = 
  dateToAnimal (1,9,2020) = "Rat"
val testDateToAnimal4 = 
  dateToAnimal (1,9,1950) = "Tiger"

(* Задание 16 *)
val testAnimal1 = 
  animal ("Ivan", (1,9,1980)) = "Monkey"
val testAnimal2 = 
  animal ("Svetlana", (1,9,2016)) = "Monkey"
val testAnimal3 = 
  animal ("Ivan", (1,9,2020)) = "Rat"
val testAnimal4 = 
  animal ("Svetlana", (1,9,1950)) = "Tiger"


