(* Шаблон для выполнения заданий лабораторной работы №1 *)

(* Задание 1 isLeapYear *)
fun isLeapYear (y : int) : bool = 
  if y mod 400 = 0 orelse (y mod 100 <> 0 andalso y mod 4 = 0) then true 
    else false

(* Задание 2 isCorrectDate *)
fun isCorrectDate (date : int * int * int) = 
  let
    val day = #1 date
    val month = #2 date
    val year = #3 date
    val bMonth = if month >= 1 andalso month <= 12 then true else false
    val bDay = if ((( month = 1 orelse month = 3 orelse month = 5 
                      orelse month = 7 orelse month = 8 orelse month = 10 
                      orelse month = 12 ) andalso day <= 31) 
                      orelse (( month = 4 orelse month = 6 orelse month = 9 
                                orelse month = 11 ) andalso day <= 30) 
                      orelse ( isLeapYear(year) = true andalso month = 2
                               andalso day <= 29 )
                      orelse ( isLeapYear(year) = false andalso month = 2
                               andalso day <= 28 ))
                      andalso day >= 1
               then true 
               else false
  in
    if bMonth andalso bDay then true else false
  end

(* Задание 3 newStyleCorrection *)
fun newStyleCorrection (date : int * int * int) = 
  let
    val day = #1 date
    val month = #2 date
    val year = #3 date
    val tempYear = year div 100 - year div 400 - 2
  in
    if year mod 100 = 0 andalso year mod 400 <> 0
       andalso (month = 1 orelse month = 2)
    then tempYear - 1 else tempYear 
  end

(* Задание 4 getNthInt *)
fun getNthInt (lst : int list, n : int) = 
    if n > 0
    then getNthInt (tl lst, n - 1)
    else hd lst

(* Задание 5 getNthStr *)
fun getNthStr (lst : string list, n : int) =
    if n > 0
    then getNthStr (tl lst, n - 1)
    else hd lst

(* Задание 6 lastSmaller *)
fun lastSmaller (amount : int, lst : int list) = 
  let
    fun helpFun (rez : int, l : int list) = 
      if null l orelse hd l >= amount 
      then rez
      else helpFun (hd l, tl l)
  in
    helpFun(0, lst)
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
fun firstNewMoonInt (date : int * int * int) = 
  let
    val day = #1 date
    val month = #2 date
    val year = #3 date 
    val year = 
      if month = 1 orelse month = 2 
      then year - 1 
      else year
    val deltaYliGrig = newStyleCorrection (date) * 100000 
        + getNthInt (thousandCorrection, year div 1000) 
        + getNthInt (hundredCorrection, year div 100 mod 10) 
        + getNthInt (decadeCorrection, year mod 100 div 10) 
        + getNthInt (yearCorrection, year mod 10)
        + getNthInt (monthCorrection, month - 1)
        + getNthInt (calendarCorrection, year mod 4)
    val deltaYliGrig = deltaYliGrig 
        - lastSmaller (deltaYliGrig - 100000, reductions)
  in
    if month = 2 
               andalso (( deltaYliGrig div 100000 > 29 
                          andalso isLeapYear(year) = true )
               orelse  ( deltaYliGrig div 100000 > 28 
                          andalso isLeapYear(year) = false ))
    then NONE
    else SOME deltaYliGrig
  end

(* Задание 8 firstNewMoon *)
fun firstNewMoon (date : int * int * int) = 
  let
    val day = #1 date
    val month = #2 date
    val year = #3 date
    val dat = firstNewMoonInt(date)
  in
    if isSome dat 
    then SOME (valOf dat div 100000, month, year)
    else NONE
  end

(*наименования месяцев*)
val monthName      = [ "January", "February", "March", "April", "May"
                      , "June", "July", "August", "September", "October"
                      , "November", "December" ]

(* Задание 9 dateToString *)
fun dateToString (date : int * int * int) = 
  let
    val day = #1 date
    val month = #2 date
    val year = #3 date
  in
    getNthStr ( monthName, month - 1) ^ " " ^ Int.toString day 
    ^ ", " ^ Int.toString year
  end

(* Задание 10 isOlder *)
fun isOlder (date1 : int * int * int, date2 : int * int * int) = 
  let
    val day1 = #1 date1
    val month1 = #2 date1
    val year1 = #3 date1
    val day2 = #1 date2
    val month2 = #2 date2
    val year2 = #3 date2
  in
    if       ( day1 < day2 andalso month1 <= month2 andalso year1 <= year2 ) 
      orelse ( month1 > month2 andalso year1 < year2 )
      orelse ( year1 < year2 )
    then true
    else false
  end

(* Задание 11 winterSolstice *)
fun winterSolstice (year : int) = 
    ( 2250000 + 24220 * year - 100000 
    * ( year div 400 + year div 4 - year div 100 ) ) div 100000

(* Задание 12 chineseNewYear *)
fun chineseNewYear (year : int) =
  let
    val yearMin = year - 1
    val decDay = valOf (firstNewMoonInt (1, 12, yearMin))
    val decDayMin = decDay - 3100000
    val dayPlus = 
      if decDay <= winterSolstice (yearMin) * 100000
      then ( decDayMin + 5906118 ) div 100000
      else ( decDayMin + 2953059 ) div 100000
  in
    if dayPlus <= 31
    then (dayPlus, 1, year)
    else (dayPlus - 31, 2, year)
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
fun chineseYear (year : int) =
  let
    val chinaYear = ( year + 2396 ) mod 60
    val chinaYearSt = chinaYear mod 10
    val chineseYearColor = chinaYearSt div 2
    val chinaYearEarthSt = chinaYear mod 12
  in
    ( getNthStr (celestialChi, chinaYearSt) ^ "-" ^
      getNthStr (terrestrialChi, chinaYearEarthSt)
    , getNthStr (celestialColor, chineseYearColor)
    , getNthStr (terrestrialEng, chinaYearEarthSt)
    ,  getNthStr (celestialEng, chinaYearSt) )
  end

(* Задание 14 dateToChineseYear *)
fun dateToChineseYear (date : int * int * int) =
  let
    val year = #3 date 
    val chinaYear = ( year + 2396 ) mod 60
    val chinaYearSt = chinaYear mod 10
    val chineseYearColor = chinaYearSt div 2
    val chinaYearEarthSt = chinaYear mod 12
  in
    ( getNthStr (celestialChi, chinaYearSt) ^ "-" ^
      getNthStr (terrestrialChi, chinaYearEarthSt)
    , getNthStr (celestialColor, chineseYearColor)
    , getNthStr (terrestrialEng, chinaYearEarthSt)
    ,  getNthStr (celestialEng, chinaYearSt) )
  end

(* Задание 15 dateToAnimal *)
fun dateToAnimal (date : int * int * int) = 
   #3 ( dateToChineseYear (date) )

(* Задание 16 animal *)
fun animal (name : string, date : int * int * int) = 
  #3 ( dateToChineseYear ( date) )


