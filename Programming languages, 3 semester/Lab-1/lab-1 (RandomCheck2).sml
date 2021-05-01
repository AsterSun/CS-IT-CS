(* Шаблон для выполнения заданий лабораторной работы №1 *)

(* Задание 1 isLeapYear *)
fun isLeapYear (year : int) : bool = 
  if year mod 400 = 0 orelse year mod 100 <> 0 andalso year mod 4 = 0
  then true
  else false

(* Задание 2 isCorrectDate *)
fun isCorrectDate (date : int * int * int) =
  let
    val d = #1 date
    val m = #2 date
    val y = #3 date
  in
    if y > 0
    then
      if m > 0 andalso m < 13 
      then
        if d > 0
        then
          if m = 1 orelse m = 3 orelse m = 5 orelse m = 7
            orelse m = 8 orelse m = 10 orelse m = 12
          then
            if d < 32 then true else false
          else
            if m = 4 orelse m = 6 orelse m = 9 orelse m = 11
            then
              if d < 31 then true else false
            else
              if isLeapYear y = true
              then
                if d < 30 then true else false
              else
                if d < 29 then true else false
        else false
      else false
    else false
  end

(* Задание 3 *)
fun newStyleCorrection (date : int * int * int) : int =
  let
    val d = #1 date
    val m = #2 date
    val y = #3 date
  in
    if m = 1 orelse d < 29 andalso m = 2
    then
      let
        val py = y - 1 
      in
          py div 100 - py div 400 - 2 
      end
    else y div 100 - y div 400 - 2
  end

(* Задание 4 *)
fun getNthInt (listOfNumbers : int list, N : int) : int = 
  if N > 0
  then getNthInt (tl listOfNumbers, N - 1)
  else hd listOfNumbers

(* Задание 5 *)
fun getNthStr (listOfLines : string list, N : int) : string =
    if N > 0
    then getNthStr (tl listOfLines, N - 1)
    else hd listOfLines

(* Задание 6 *)
fun lastSmaller (amount : int, a : int list) : int= 
  if tl a <> nil
  then if hd (tl a) >= amount
       then if hd a < amount 
            then hd a
            else 0
       else lastSmaller (amount, tl a)
  else hd a


(* Списки для выполнения задания 8 (списки поправок) *)
(* поправка на тысячи года *)
val thousandCorrection = [ 0, 1390000, 2770000, 1210000, 2590000
                          , 1030000, 2420000 ]
(* поправка на сотни года *)
val hundredCorrection  = [ 0, 430000, 870000, 1300000, 1740000
                          , 2170000, 2600000, 80000, 520000, 950000 ]
(* поправка на десятки года *)
val decadeCorrection   = [ 0, 930000, 1860000, 2790000, 760000
                          , 1690000, 2620000, 600000, 1530000, 2460000 ]
(* поправка на единицы года *)
val yearCorrection     = [ 0, 1860000, 780000, 2640000, 1550000
                          , 460000, 2330000, 1240000, 150000, 2020000 ]
(* поправка на месяц *)
val monthCorrection    = [ 1340000, 1190000, 2420000, 2260000, 2200000
                          , 2060000, 2000000, 1840000, 1700000, 1660000
                          , 1510000, 1480000 ]
(* календарная поправка *)
val calendarCorrection = [0, 20000, 50000, 80000]
(* поправка для нормализации дня месяца *)
val reductions = [2953059, 5906118, 8859177, 11812236, 14765295, 17718354] 

(* Задание 7 *)
fun firstNewMoonInt (date : int * int * int) : int option =
  let
    val m = #2 date
    val y = #3 date
    val yN = if m < 3 then y - 1 else y 
    val sumCorrection = newStyleCorrection date * 100000
                        + getNthInt (thousandCorrection, yN div 1000)
                        + getNthInt (hundredCorrection, yN mod 1000 div 100)
                        + getNthInt (decadeCorrection, yN mod 100 div 10)
                        + getNthInt (yearCorrection, yN mod 10)
                        + getNthInt (monthCorrection, m - 1)
                        + getNthInt (calendarCorrection, yN mod 4)
    val result = sumCorrection 
                 - lastSmaller (sumCorrection - 100000, reductions)
  in
    if m <> 2
    then SOME result
    else
      if isLeapYear y
      then if result < 3000000 then SOME result else NONE
      else if result < 2900000 then SOME result else NONE
  end


(* Задание 8 *)
fun firstNewMoon (dat : int * int * int) : (int * int * int) option =
  let
    val datMoon = firstNewMoonInt (dat)
  in
    if isSome datMoon
    then SOME (valOf datMoon div 100000, #2 dat, #3 dat)
    else NONE
  end

val nameMonth = ["January", "February", "March", "April", "May",
                  "June", "July", "August", "September", "October",
                  "November", "December"]


(* Задание 9 *)
fun dateToString (dat : int * int * int) : string =
  getNthStr (nameMonth, #2 dat - 1) ^ " " ^ Int.toString (#1 dat) ^ ", " ^ 
  Int.toString (#3 dat)

(* Задание 10 *)
fun isOlder (date1 : int * int * int, date2 : int * int * int) : bool =
  let
    val d1 = #1 date1
    val m1 = #2 date1
    val y1 = #3 date1
    val d2 = #1 date2
    val m2 = #2 date2
    val y2 = #3 date2
  in
    if y1 < y2 then true
    else if y1 > y2 then false
         else if m1 < m2 then true
              else if m1 > m2 then false
                   else if d1 < d2 then true
                        else if d1 >= d2 then false else true
  end

(* Задание 11 *)
fun winterSolstice (y : int) : int =
  (24220 * y - 100000 * (y div 400 + y div 4 - y div 100) + 2250000) div 100000


(* Списки для выполнения задания 13 *)
(* список небесных стихий (по-китайски) *)
val celestialChi   = [ "Jia", "Yi", "Bing", "Ding", "Wu"
                      , "Ji", "Geng", "Xin", "Ren", "Gui" ] 
(* список небесных стихий (по-английски) *)
val celestialEng   = [ "Growing wood", "Cut timber", "Natural fire"
                      , "Artificial fire", "Earth", "Earthenware"
                      , "Metal", "Wrought metal", "Running water"
                      , "Standing water" ]
(* цвета, соответствующие небесным стихиям *)
val celestialColor = ["Green", "Red", "Brown", "White", "Black"] 
(* список земных стихий (по-китайски) *)
val terrestrialChi = [ "Zi", "Chou", "Yin", "Mao"
                      , "Chen", "Si", "Wu", "Wei"
                      , "Shen", "You", "Xu", "Hai" ]
(* список земных стихий (по-английски) *)
val terrestrialEng = [ "Rat", "Cow", "Tiger", "Rabbit"
                      , "Dragon", "Snake", "Horse", "Sheep"
                      , "Monkey", "Chicken", "Dog", "Pig" ]

(* Задание 12 chineseNewYear *)
fun chineseNewYear (y : int) : (int * int * int) =
  let
    val yN = y - 1
    val dec = valOf (firstNewMoonInt (1, 12, yN))
    val decn = dec - 3100000
    val dd =
      if dec div 100000 <= winterSolstice (yN)
      then (decn + 5906118) div 100000
      else (decn + 2953059) div 100000
  in
    if dd < 32  then (dd, 1, y) else (dd - 31, 2, y)
  end

(* Задание 13 chineseYear *)
fun chineseYear (year : int) : string * string * string * string = 
  let
    val cycleYear = (year + 2396) mod 60
    val heavenlyElements = cycleYear mod 10
    val animalName = cycleYear mod 12
  in
    (getNthStr (celestialChi, heavenlyElements) ^ "-" ^
     getNthStr (terrestrialChi, animalName),
     getNthStr (celestialColor, heavenlyElements div 2),
     getNthStr (terrestrialEng, animalName),
     getNthStr (celestialEng, heavenlyElements))
  end

(* Задание 14 *)
fun dateToChineseYear (dat : int * int * int) 
                      : string * string * string * string =
  let 
    val year = #3 dat
  in
    if isOlder (dat, chineseNewYear year) = false
    then chineseYear year
    else chineseYear (year - 1)
  end

(* Задание 15 *)
fun dateToAnimal (dat : int * int * int) : string 
                = #3 (dateToChineseYear (dat))

(* Задание 16 *)
fun animal (nameOfStudent : string * (int * int * int)) : string= 
    dateToAnimal (#2 nameOfStudent)

