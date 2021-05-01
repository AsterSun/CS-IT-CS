(* Шаблон для выполнения заданий лабораторной работы №1 *)
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
                      
(******************** Задание 1 isLeapYear ********************)
fun isLeapYear (year : int) : bool =
  if year mod 400 = 0 
    orelse year mod 100 <> 0 
           andalso year mod 4 = 0 
  then true
  else false
(******************** Задание 2 isCorrectDate ********************)
fun isCorrectDate (day : int, month : int, year : int) : bool =
  if year > 0 
    andalso day <= 31 
    andalso day > 0 
    andalso ( month < 8 
              andalso month > 0
              andalso month mod 2 = 1 
       orelse month >= 8 
              andalso month < 13
              andalso month mod 2 = 0 )
  then true
  else if year > 0 
         andalso day <= 30 
         andalso day > 0 
         andalso ( month < 8 
                   andalso month > 0
                   andalso month mod 2 = 0 
                   andalso month <> 2
            orelse month >= 8 
                   andalso month < 13
                   andalso month mod 2 = 1 )
       then true
       else if year > 0 
               andalso month = 2 
               andalso ( day <= 28 
                         andalso not (isLeapYear year)
                         andalso day > 0
                  orelse day <= 29 
                         andalso isLeapYear year 
                         andalso day > 0 )
            then true
            else false
(******************** Задание 3 newStyleCorrection **************)
fun newStyleCorrection (d : int, m : int, y : int) : int =
  if m = 1 
    andalso not (isLeapYear y)
    andalso y mod 4 = 0
    orelse d < 29 
           andalso m = 2
           andalso not (isLeapYear y)
           andalso y mod 4 = 0
  then 
    let val lY = y - 1 in lY div 100 - lY div 400 - 2 end
  else y div 100 - y div 400 - 2
(******************** Задание 4 getNthInt ********************)
fun getNthInt (a : int list, n : int) : int =
  if n = 0 then hd a
  else getNthInt (tl a, n - 1)
(******************** Задание 5 getNthStr ********************)
fun getNthStr (a : string list, n : int) : string = 
  if n = 0 then hd a
  else getNthStr (tl a, n - 1)
(******************** Задание 6 lastSmaller ********************)
fun lastSmaller (amount : int, a : int list) : int= 
  if tl a <> nil
  then if hd (tl a) >= amount
       then if hd a < amount 
            then hd a
            else 0
       else lastSmaller (amount, tl a)
  else hd a

(******************** Задание 7 firstNewMoonInt ********************)
fun firstNewMoonInt (d : int, m : int, y : int) : int option = 
  let
    val dateInterval = newStyleCorrection (d, m, y) * 100000
    val newY = 
      if m = 1 
         orelse m = 2 
      then y - 1
      else y
    val date1 = dateInterval 
      + getNthInt (thousandCorrection, newY div 1000)
      + getNthInt (hundredCorrection, newY mod 1000 div 100)
      + getNthInt (decadeCorrection, newY mod 100 div 10)
      + getNthInt (yearCorrection, newY mod 10)
      + getNthInt (monthCorrection, m - 1)
      + getNthInt (calendarCorrection, newY mod 4)
    val date2 = date1 
      - lastSmaller (date1 - 100000, reductions)
    val res =
      if date2 > 3000000
        andalso m = 2 
        andalso isLeapYear y
        orelse date2 > 2900000
        andalso m = 2 
        andalso not (isLeapYear y)
      then NONE
      else SOME date2
  in
    if date2 > 3000000
        andalso m = 2 
        andalso isLeapYear y
        orelse date2 > 2900000
        andalso m = 2 
        andalso not (isLeapYear y)
      then NONE
      else SOME date2
  end
(******************** Задание 8 firstNewMoon ********************)
fun firstNewMoon (d : int, m : int, y : int) : (int * int * int) option =
  let
    val dateMoon = firstNewMoonInt(d, m, y)
    val res =
      if isSome dateMoon 
      then SOME (valOf dateMoon div 100000, m, y)
      else NONE
  in
    res
  end
(******************** Задание 9 dateToString ********************)
fun dateToString (d : int, m : int, y : int) : string =
  let
    val months = ["January", "February", "March"
                 , "April", "May", "June"
                 , "July", "August", "September"
                 , "October", "November", "December"
                 ]
    val month = getNthStr (months, m - 1)
    val result = month ^ " " ^ Int.toString d 
                 ^ ", " ^ Int.toString y
  in
    result
  end
(******************** Задание 10 isOlder ********************)
fun isOlder ((d1 : int, m1 : int, y1 : int)
            , (d2 : int, m2 : int, y2 : int)) : bool =
  let
    val res = 
      if y1 > y2 
      then false
      else if y1 < y2 
           then true
           else if m2 < m1 
                then false
                else if m1 < m2 
                     then true
                     else if d1 < d2 
                          then true
                          else false
  in
    res
  end
(******************** Задание 11 winterSolstice ********************)
fun winterSolstice (year : int) : int = 
  let
    val lNum = year div 400 
      + year div 100 * 24 
      + year mod 100 div 4
    val hNum = year - lNum
    val res = 2250000 + hNum * 24220 - lNum * 75780
  in
    res div 100000
  end
(******************** Задание 12 chineseNewYear ********************)
fun chineseNewYear (year : int) : int * int * int =
  let
    val dateSolstice = winterSolstice (year - 1)
    val dateNewMoon = firstNewMoonInt (1, 12, year - 1)
    val vDNM = valOf dateNewMoon
    val vDNMH = vDNM + 5906118
    val res =
      if dateSolstice >= vDNM div 100000
      then if vDNMH div 100000 > 62
           then ((vDNMH - 6200000) div 100000, 2, year)
           else if vDNMH div 100000 = 62
                then (31, 1, year)
                else (vDNMH mod 3100000 div 100000, 1, year)
      else ((vDNM + 2953059) mod 3100000 div 100000, 1, year)
  in
    res
  end
(******************** Задание 13 chineseYear ********************)
fun chineseYear (year : int) : string * string * string * string = 
  let
    val chineYear = (year + 2396) mod 60
    val indexAir = chineYear mod 10
    val indexColor = indexAir div 2
    val indexEarth = chineYear mod 12
  in
    (getNthStr (celestialChi, indexAir) 
    ^ "-" ^ getNthStr (terrestrialChi, indexEarth)
    , getNthStr (celestialColor, indexColor)
    , getNthStr (terrestrialEng, indexEarth)
    , getNthStr (celestialEng, indexAir))
  end
(******************** Задание 14 dateToChineseYear ********************)
fun dateToChineseYear (d : int, m : int, y : int)
                      : string * string * string * string =
  let
    val res = 
      if isOlder ((d, m, y), chineseNewYear y)
      then chineseYear (y - 1)
      else chineseYear y
  in
    res
  end
(******************** Задание 15 dateToAnimal ********************)
fun dateToAnimal (d : int, m : int, y : int) : string = 
  let
    val res = dateToChineseYear (d, m, y)
  in
    #3 res
  end
(******************** Задание 16 animal ********************)
fun animal (name : string, (d : int, m : int, y : int)) : string = 
  dateToAnimal (d, m, y)

(******************** Задание 17 extractAnimal ********************)
fun extractAnimal (a : (string * (int * int * int)) list
                  , an : string) : (string * (int * int * int)) list =
  let
    fun recur (a1 : (string * (int * int * int)) list
              , s : (string * (int * int * int)) list
              , anim : string) : (string * (int * int * int)) list =
      if a1 <> nil
      then if animal (hd a1) = anim
           then recur (tl a1, hd a1 :: s, anim)
           else recur (tl a1, s, anim)
      else s
    val res = recur (a, [], an)
  in
    res
  end
(******************** Задание 18 extractAnimals ********************)
fun extractAnimals (a : (string * (int * int * int)) list
                   , an : string list) : (string * (int * int * int)) list =
  let
    fun isTrue (a2 : string * (int * int * int), an1 : string list) 
               : bool = 
    if an1 <> nil
    then if animal a2 = hd an1 
         then true
         else isTrue (a2, tl an1 )
    else false
    fun recur (a1 : (string * (int * int * int)) list
              , s : (string * (int * int * int)) list
              , anim : string list) : (string * (int * int * int)) list =
      if a1 <> nil
      then if isTrue (hd a1, anim)
           then recur (tl a1, hd a1 :: s, anim)
           else recur (tl a1, s, anim)
      else s
    val res = recur (a, [], an)
  in
    res
  end
(******************** Задание 19 oldest ********************)
fun oldest (a : (string * (int * int * int)) list) : string option = 
  let
    fun getOldest ((s1 : string, (d1 : int, m1 : int, y1 : int))
                  , (s2 : string, (d2 : int, m2 : int, y2 : int))) : bool = 
    isOlder ((d1, m1, y1), (d2, m2, y2))
    fun recur (a1 : (string * (int * int * int)) list
              , b : string * (int * int * int)) : string * (int * int * int)= 
    if tl a1 <> nil
    then if getOldest (hd a1, b)
         then recur (tl a1, hd a1)
         else recur (tl a1, b)
    else if getOldest (hd a1, b)
         then hd a1
         else b
    fun getName (sn : string, (sd : int, sm : int, sy : int)) : string = 
      sn
    val res = if a <> nil 
              then getName (recur (a, hd a))
              else ""
    val result = if res <> ""  then SOME res else NONE
  in
    result
  end
(******************** Задание 20 oldestFromAnimals ********************)
fun oldestFromAnimals (a : (string * (int * int * int)) list
                      , an : string list) : string option = 
  oldest (extractAnimals (a, an))
