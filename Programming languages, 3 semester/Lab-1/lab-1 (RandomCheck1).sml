(* Шаблон для выполнения заданий лабораторной работы №1 *)

(* Задание 1 isLeapYear *)
fun isLeapYear (y : int) : bool =
  if y mod 400 = 0 
    then true 
  else if y mod 100 > 0 andalso y mod 4 = 0 
    then true
  else 
    false

(* Задание 2 isCorrectDate *)
fun isCorrectDate (date : int * int * int) : bool =
  let
    val d = #1 date
    val m = #2 date
    val y = #3 date 
  in
    if d > 31 orelse d < 1 orelse 
       m > 12 orelse m < 1 orelse
       y > 6999 orelse y < 1 then
       false
    else if m = 2 andalso isLeapYear y andalso d < 30 then
      true
    else if m = 2 andalso not (isLeapYear y) andalso d < 29 then
      true
    else if m = 4 orelse m = 6 orelse m = 9 orelse m = 11 then
      if d = 31 then 
        false else true
      else if m = 1 orelse m = 3 orelse m = 5 orelse m = 7 orelse
              m = 8 orelse m = 10 orelse m = 12 
           then
        true
    else 
      false
  end

(* Задание 3 newStyleCorrection *)
fun newStyleCorrection (date : int * int * int) : int =
  let
    val d = #1 date
    val m = #2 date
    val y = #3 date 
    fun grigCal (y : int, i : int, s : int) : int = 
      if i < y + 1 then 
        if isLeapYear i then grigCal (y, i + 1, s + 1)
        else grigCal (y, i + 1, s)
      else s
    fun julCal (y : int, j : int, k : int) : int = 
      if j < y + 1 then 
        if j mod 4 = 0 then julCal (y, j + 1, k + 1)
        else julCal (y, j + 1, k)
      else k
  in
    if m < 2 orelse m = 2 andalso d < 29 then 
      julCal (y - 1, 200, 0) - grigCal (y - 1, 200, 0) - 1
    else if m > 2 orelse m = 2 andalso d = 29
      then julCal (y, 200, 0) - grigCal (y, 200, 0) - 1
    else 0
  end

 
(* Задание 4 getNthInt *)
fun getNthInt (l : int list, n : int) : int =
  let
    fun f (l : int list, i : int) : int =
      if i >= n then hd l
      else f (tl l, i + 1)
  in
    f (l, 0)
end

(* Задание 5 getNthStr *)
fun getNthStr (l : string list, n : int) : string =
  let
    fun f (l : string list, i : int) : string =
      if i >= n then hd l
      else f (tl l, i + 1)
  in
    f (l, 0)
end

(* Задание 6 lastSmaller *)
fun lastSmaller (amount : int, l : int list) : int =
  let
    fun recursion (l : int list, res : int) : int =
      if l = nil orelse hd l >= amount then res
      else recursion (tl l, hd l)
    val recn = recursion (l, amount)
  in
    if recn >= amount then 0
    else recn
  end

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

(* Задание 7 firstNewMoonInt *)
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

(* Задание 8 firstNewMoon *)
fun firstNewMoon (date : int * int * int) : (int * int * int) option = 
  let
    val moonDay = firstNewMoonInt (date)
  in
    if moonDay = NONE
    then NONE
    else SOME (valOf moonDay div 100000, #2 date, #3 date)
  end


(* Задание 9 dateToString *)
fun dateToString (date : int * int * int) : string =
  let
    val calendar = [ "January", "February", "March", "April", "May"
                    , "June", "July", "August", "September", "October"
                    , "November", "December" ]
  in
    getNthStr (calendar, #2 date - 1) ^ " " 
    ^ Int.toString (#1 date) ^ ", " ^ Int.toString (#3 date)
  end

(* Задание 10 isOlder *)
fun isOlder (dateA : int * int * int, dateB : int * int * int) : bool =
  let
    val m1 = #2 dateA
    val y1 = #3 dateA
    val m2 = #2 dateB
    val y2 = #3 dateB
  in
    if y1 < y2 then true
    else if y1 > y2 then false
    else if m1 < m2 then true
    else if m1 > m2 then false
    else if #1 dateA < #1 dateB then true
    else false
  end

(* Задание 11 winterSolstice *)
fun winterSolstice (y : int) : int =
  let
    fun vis (y : int, i : int, s : int) : int = 
      if i <= y then 
        if isLeapYear i then vis (y, i + 1, s + 1)
        else vis (y, i + 1, s)
      else s
    val count = vis (y, 1, 0)
  in
    (2250000 + (y - count) * 24220 - count * 75780) div 100000
  end

(* Задание 12 chineseNewYear *)
fun chineseNewYear (y : int) : (int * int * int) =
  let
    val predY = y - 1
    val newMoon = valOf (firstNewMoonInt (1, 12, predY))
    val days = if newMoon div 100000 <= winterSolstice (y - 1) then 
      (newMoon + 5906118) div 100000
    else 
      (newMoon + 2953059) div 100000
    fun letsday (d: int, m : int, y : int) : int * int * int =
      if d > 31 then 
        letsday (d - 31, m + 1, y)
      else
        (d, m, y)
  in
    letsday (days, 0, y)
  end

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

(* Задание 13 chineseYear *)
fun chineseYear (y : int) : (string * string * string * string) =
  let
    val numCycle = (y + 2396) mod 60
    val numElem = numCycle mod 10
    val numColor = numElem div 2
    val numAnim = numCycle mod 12
  in
    ( getNthStr (celestialChi, numElem) ^ "-" ^
      getNthStr (terrestrialChi, numAnim)
     , getNthStr (celestialColor, numColor)
     , getNthStr (terrestrialEng, numAnim)
     , getNthStr (celestialEng, numElem))
  end

(* Задание 14 dateToChineseYear *)
fun dateToChineseYear ( date : int * int * int) 
                      : (string * string * string * string) =
  let
    val y = #3 date
    val (d1, m1, y1) = chineseNewYear y
  in
    if isOlder (date, (d1, m1, y1)) then
      chineseYear (y - 1)
    else if date = (d1, m1, y1) then
      chineseYear y
    else
      chineseYear y
  end

(* Задание 15 dateToAnimal *)
fun dateToAnimal (date : int * int * int) : string =
  #3 (dateToChineseYear (date))

(* Задание 16 animal *)
fun animal (student : string * (int * int * int)) : string =
  #3 (dateToChineseYear (#2 student))

(* Задание 17 extractAnimal *)
fun extractAnimal ( students : (string * (int * int * int)) list, a : string)
                  : (string * (int * int * int)) list =
  let
    val res = [] : (string * (int * int * int)) list
    fun letstudents ( students : (string * (int * int * int)) list, a : string
                    , res : (string * (int * int * int)) list) 
                    : (string * (int * int * int)) list =
        if students = nil then 
          res
        else if animal (hd students) = a then 
          letstudents (tl students, a, hd students :: res) 
        else
          letstudents (tl students, a, res)
  in
    letstudents (students, a, res)
end

(* Задание 18 extractAnimals *)
fun extractAnimals ( students : (string * (int * int * int)) list
                   , ani : string list ) : (string * (int * int * int)) list =
if not (ani = nil) then 
  extractAnimal (students, hd ani) @ extractAnimals (students, tl ani)
else
  []

(* Задание 19 oldest *)
fun oldest (students : (string * (int * int * int)) list) : string option =
  let
     fun studentIter ( students : (string * (int * int * int)) list
                     , student : string * (int * int * int)) : string option =
      let
        val student = if isOlder (#2 (hd students), #2 student)
        then 
          hd students
        else
          student
      in
        if tl students = nil then 
          SOME (#1 student)
        else 
          studentIter (tl students, student)
      end
    in
      if students = nil then NONE
      else if tl students = nil then SOME (#1 (hd students))
      else studentIter (tl students, hd students)
  end

(* Задание 20 oldestFromAnimals *)
fun oldestFromAnimals ( students : (string * (int * int * int)) list
                      , animals : string list) : string option =
let
  val res = oldest (extractAnimals (students, animals))
in
  if not (isSome res) then 
    NONE
  else res
end