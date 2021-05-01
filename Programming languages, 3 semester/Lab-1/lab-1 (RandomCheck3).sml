  (* Шаблон для выполнения заданий лабораторной работы №1 *)
(***************************************************************
Задание 1 isLeapYear: 
Опишите функцию isLeapYear ,
получающую в качестве аргумента номер года и возвращающую true,
если год високосный, или false — в противном случае.
****************************************************************)
fun isLeapYear (year : int) : bool =
  if year mod 400 = 0 orelse year mod 4 = 0 andalso year mod 100 <> 0 then true
  else false
(***************************************************************
Задание 2 isCorrectDate:
Опишите функцию isCorrectDate, получающую в качестве аргумента
кортеж из трех целых чисел (d, m, y) и возвращающую true,
если этот кортеж представляет корректную дату,
и false — в противном случае.
****************************************************************)
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

(****************************************************************
Задание 3 newStyleCorrection:
Опишите функцию newStyleCorrection , получающую 
григорианскую дату (d, m, y) в качестве аргумента и возвращающую 
количество дней от нее до даты (d, m, y) по юлианскому календарю.
*****************************************************************)
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
(*******************************************************************
Задание 4 getNthInt:
Опишите функцию getNthInt , получающую список целых чисел и целое n.
Функция должна вернуть n -ый элемент заданного списка
********************************************************************)
fun getNthInt (l : int list, n : int) : int =
  if n = 0 then hd l
  else getNthInt (tl l, n - 1)
(*******************************************************************
Задание 5 getNthStr:
Опишите функцию getNthStr , получающую список строк и целое n .
Функция должна вернуть n - ый элемент заданного списка
********************************************************************)
fun getNthStr (l : string list, n : int) : string =
  if n = 0 then hd l
  else getNthStr (tl l, n - 1)
(*******************************************************************
Задание 6 lastSmaller:
Опишите функцию lastSmaller , получающую целое число amount 
и непустой список положительных целых чисел, 
упорядоченный по возрастанию. Функция должна выдавать 
максимальный элемент заданного писка, 
меньший по величине чем amount .
********************************************************************)
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
(*******************************************************************
Задание 7 firstNewMoonInt:
Опишите функцию firstNewMoonInt , 
получающую дату в качестве аргумента и возвращающую NONE ,
если в месяце заданной даты нет новолуния, и SOME d , 
если d — целочисленное значение ( d > 100000) — номер дня первого новолуния 
в месяце заданной даты в представлении с фиксированной точкой.
********************************************************************)
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

(*******************************************************************
Задание 8 firstNewMoon:
Опишите функцию firstNewMoon , 
получающую дату в качестве аргумента и возвращающую значение
типа (int * int * int) option . 
Результат функции — SOME d , если d — дата первого новолуния в
месяце заданной даты, или NONE , 
если в заданном месяце новолуния нет.
********************************************************************)
fun firstNewMoon (date : int * int * int) : (int * int * int) option =
  let
    val rez = firstNewMoonInt date
  in
    if rez <> NONE then SOME (valOf rez div 100000, #2 date, #3 date)
    else NONE
  end
(*******************************************************************
Задание 9 dateToString:
Опишите функцию dateToString , выдающую для заданной даты 
строку в виде "Month Day, Year" ,
где Month английское наименование месяца 
(строчными символами с заглавной буквы), Day — номер
дня в месяце, Year — номер года.
********************************************************************)
fun dateToString (date : int * int * int) : string =
  getNthStr([ "January", "February", "March"
            , "April", "May", "June", "July"
            , "August", "September", "October"
            , "November", "December" ], (#2 date) - 1)
  ^ " " ^ Int.toString (#1 date) ^ ", " ^ Int.toString (#3 date)

(*******************************************************************
Задание 10 isOlder:
Опишите функцию isOlder , получающую в качестве аргументов две даты
и возвращающую true , если
первая дата предшествует второй, или false — в противном случае.
********************************************************************)
fun isOlder (date1: int * int * int, date2 : int * int * int) : bool =
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
    else false
  end
(*******************************************************************
Задание 11 winterSolstice:
Напишите функцию winterSolstice , 
получающую номер года в качестве аргумента и выдающую целое
число — номер дня в декабре заданного года, 
на который приходится день зимнего солнцестояния.
Все операции c дробными значениями следует 
проводить над числами с фиксированной точкой. 
Результат функции — целая часть результата вычислений.
********************************************************************)
fun winterSolstice (n : int) : int =
  (2250000 + 24220 * n - (n div 4 + n div 400 - n div 100) * 100000) div 100000
(*******************************************************************
Задание 12 chineseNewYear:
Опишите функцию chineseNewYear , 
получающую номер года и возвращающую дату китайского нового
года в заданном году.
********************************************************************)
fun chineseNewYear (n : int) : int * int * int =
  let
    val lastY = n - 1
    val r = valOf (firstNewMoonInt (1, 12, lastY))
    val day = 
      if r div 100000 <= winterSolstice lastY 
      then 
        (r + 5906118) div 100000 
      else 
        (r + 2953059) div 100000
  in 
    if day > 62 then (day - 62, 2, n)
    else (day - 31, 1, n)
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
(*******************************************************************
Задание 13 chineseYear:
Опишите функцию chineseYear , получающую в качестве аргумента 
целое число — номер года по григорианскому календарю,
и возвращающую наименование китайского года, 
начинающегося в заданном году
********************************************************************)
fun chineseYear (n : int) : string * string * string * string =
  let
    val numOfYear  = (n + 2396) mod 60
    val numOfAir   = numOfYear mod 10
    val s1         = getNthStr (celestialChi, numOfAir)
    val s5         = getNthStr (celestialEng, numOfAir)
    val numOfColor = numOfAir div 2
    val s3         = getNthStr (celestialColor, numOfColor)
    val numOfEarth = numOfYear mod 12
    val s2         = getNthStr (terrestrialChi, numOfEarth)
    val s4         = getNthStr (terrestrialEng, numOfEarth)
  in
    (s1 ^ "-" ^ s2, s3, s4, s5)
  end
(*******************************************************************
Задание 14 dateToChineseYear:
Опишите функцию dateToChineseYear , 
получающую дату в качестве аргумента и возвращающую, как
и в предыдущим задании, четверку строк наименований 
для года китайского календаря, соответствующего заданной дате.
********************************************************************)
fun dateToChineseYear ( date : int * int * int ) 
                      : string * string * string * string =
let
  val year = #3 date
in
  if isOlder (date,chineseNewYear year) then chineseYear (year - 1)
  else chineseYear year
end
(*******************************************************************
Задание 15 dateToAnimal:
Опишите функцию dateToAnimal , получающую дату 
в качестве аргумента и возвращающую строку —
английский аналог наименования года по китайскому календарю, 
состоящий только из наименования животного
********************************************************************)
fun dateToAnimal (date : int * int * int) : string =
  #3 (dateToChineseYear date)
(*******************************************************************
Задание 16 animal:
Опишите функцию animal , аргумент которой — 
пара string * (int * int * int) . Первый элемент
пары — имя студента (строка), второй — дата его рождения.
 Функция должна возвращать строку — наименование животного,
  соответствующее по китайскому календарю дате рождения студента.
********************************************************************)
fun animal (pair : string * (int * int * int)) : string =
  dateToAnimal (#2 pair)
(*******************************************************************
Задание 17 extractAnimal:
Опишите функцию extractAnimal , получающую два аргумента: первый — 
список пар string * (int * int * int) — 
список имен студентов с датами рождения,
 второй — наименование животного из китайского календаря (строка). 
 Функция должна возвращать список имен студентов с датами
их рождения, которым по китайскому календарю 
соответствует указанное животное.
********************************************************************)
fun extractAnimal ( l : (string * (int * int * int)) list
                  , str : string
                  )
                  : (string * (int * int * int)) list =
let
  fun choose ( l : (string * (int * int * int)) list 
             , lNew : (string * (int * int * int)) list
             )
             : (string * (int * int * int)) list =
  if null l then lNew
  else if animal (hd l) = str then choose (tl l, hd l :: lNew)
  else choose (tl l, lNew)
in
  choose (l, [])
end
(*******************************************************************
Задание 18 extractAnimals:
Опишите функцию extractAnimals , получающую два аргумента: первый — 
список имен студентов с
датами рождения, второй — список строк — 
наименований животных из китайского календаря. 
Функция должна возвращать список имен студентов 
с датами их рождения для тех студентов, которым по китайскому
календарю соответствует какое-либо из животных заданного списка
********************************************************************)
fun extractAnimals ( l : (string * (int * int * int)) list
                   , ls : string list 
                   )
                   : (string * (int * int * int)) list =
let
  fun choose ( l : (string * (int * int * int)) list
             , ls : string list
             , lNew : (string * (int * int * int)) list
             )
             : (string * (int * int * int)) list =
  if null ls then lNew
  else choose (l, tl ls, extractAnimal(l, hd ls) @ lNew)
in
  choose (l, ls, [])
end
(* Задание 19 oldest *)
(* Задание 20 oldestFromAnimals *)



