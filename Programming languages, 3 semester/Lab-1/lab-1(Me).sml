(* Шаблон для выполнения заданий лабораторной работы №1 *)

(* Задание 1 isLeapYear *)
fun isLeapYear (y : int) : bool =
    if y mod 4 = 0 andalso y mod 100 <> 0 orelse y mod 400 = 0
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

(* Задание 3 newStyleCorrection *)
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

(* Задание 4 getNthInt *)
fun getNthInt (inList : int list, n : int) : int =
  if n = 0 then hd inList
  else getNthInt (tl inList, n - 1)

(* Задание 5 getNthStr *)
fun getNthStr (inList : string list, n : int) : string = 
  if n = 0 then hd inList
  else getNthStr (tl inList, n - 1)

(* Задание 6 lastSmaller *)
fun lastSmaller (amount : int, inList : int list) : int= 
  if tl inList <> nil
  then if hd (tl inList) >= amount
       then if hd inList < amount then hd inList else 0
       else lastSmaller (amount, tl inList)
  else hd inList

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
    val newMoonDate = firstNewMoonInt date
  in
    if isSome newMoonDate
    then SOME (valOf newMoonDate div 100000, #2 date, #3 date)
    else NONE
  end

(* Задание 9 dateToString *)
fun dateToString (date : int * int * int) : string =
  let
    val monthList = ["January", "February", "March", "April",
                     "May", "June", "July", "August", "September", 
                     "October", "November", "December"]
  in
    getNthStr (monthList, #2 date - 1)
    ^ " " ^ Int.toString (#1 date)
    ^ ", " ^ Int.toString (#3 date)
  end

(* Задание 10 isOlder *)
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

(* Задание 11 winterSolstice *)
fun winterSolstice (y : int) : int =
  (24220 * y - 100000 * (y div 400 + y div 4 - y div 100) + 2250000) div 100000

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
    val chYear = (y + 2396) mod 60 
    val chYearn = chYear mod 10
    val chYeart = chYear mod 12
  in
    (getNthStr (celestialChi, chYearn) ^ "-" ^ 
    getNthStr (terrestrialChi, chYeart),
    getNthStr (celestialColor, chYearn div 2),
    getNthStr (terrestrialEng, chYeart),
    getNthStr (celestialEng, chYearn))
  end

(* Задание 14 dateToChineseYear *)
fun dateToChineseYear (date : int * int * int) 
                      : string * string * string * string =
  let
    val y = #3 date
  in
    if isOlder(date, chineseNewYear y)
    then chineseYear (y - 1)
    else chineseYear y
  end

(* Задание 15 dateToAnimal *)
fun dateToAnimal (date : int * int * int) : string =
  #3 (dateToChineseYear date)

(* Задание 16 animal *)
fun animal (studentInfo : string * (int * int * int)) : string =
  dateToAnimal (#2 studentInfo)

(* Задание 17 extractAnimal *)
fun extractAnimal (studentInfoList : (string * (int * int * int)) list,
                   anim : string) : (string * (int * int * int)) list =
    if studentInfoList = nil
    then nil
    else
      if animal (hd studentInfoList) = anim
      then hd studentInfoList :: extractAnimal (tl studentInfoList, anim)
      else extractAnimal (tl studentInfoList, anim)

(* Задание 18 extractAnimals *)
fun extractAnimals (studentInfoList : (string * (int * int * int)) list,
                    anims : string list) : (string * (int * int * int)) list =
  if anims = nil
  then nil
  else extractAnimal (studentInfoList, hd anims) 
       @ extractAnimals (studentInfoList, tl anims)

(* Задание 19 oldest *)
fun oldest (studentInfoList : (string * (int * int * int)) list)
           : string option =
  let
    fun isOldest ((stdInfList1 : string * (int * int * int)),
                  (stdInfList2 : string * (int * int * int))) : bool =
      isOlder (#2 stdInfList1, #2 stdInfList2)
    fun recOldest (studentInfoListN : (string * (int * int * int)) list,
                  oldst : string * (int * int * int)) : 
                  string * (int * int * int) = 
      if tl studentInfoListN = nil
      then
        if isOldest (hd studentInfoListN, oldst)
        then hd studentInfoListN
        else oldst
      else
        if isOldest (hd studentInfoListN, oldst)
        then recOldest (tl studentInfoListN, hd studentInfoListN)
        else recOldest (tl studentInfoListN, oldst)
  in
    if null studentInfoList
    then NONE
    else SOME (#1 (recOldest (studentInfoList, hd studentInfoList)))
  end

(* Задание 20 oldestFromAnimals *)
fun oldestFromAnimals (studentInfoList : (string * (int * int * int)) list, 
                       anims : string list) : string option = 
  oldest (extractAnimals (studentInfoList, anims))
