(* Шаблон для выполнения заданий лабораторной работы №2 
 * НЕ СЛЕДУЕТ УДАЛЯТЬ ИЛИ ПЕРЕСТАВЛЯТЬ МЕСТАМИ ЭЛЕМЕНТЫ, 
 * ПРЕДСТАВЛЕННЫЕ В ШАБЛОНЕ (ВКЛЮЧАЯ КОММЕНТАРИИ). 
 * ЭЛЕМЕНТЫ РЕШЕНИЯ СЛЕДУЕТ ВПИСЫВАТЬ В ПРОМЕЖУТКИ,
 * ОПРЕДЕЛЕННЫЕ КОММЕНТАРИЯМИ.
 * Можно (а иногда и нужно) вставлять пустые строки в промежутки, 
 * предназначенные для решения. *)

(****************************************************************************** 
                    Вспомогательные функции и определения
 ******************************************************************************)
(* Выдает "случайное" целое число, на основе текущего времени *)
fun seed () = 
  IntInf.toInt (Time.toMilliseconds (Time.now ()) mod 1000) + 100

(* Превращает некаррированную функцию двух аргументов в каррированную *)
fun curry_2 f x y = f (x, y)

(* Тип данных color для цвета (масти) карт *)
datatype color = RED | GREEN | BLUE | YELLOW | BLACK

(* Тип данных rank для значения карт *)
datatype rank = SKIP 
              | DRAW_TWO 
              | REVERSE 
              | WILD 
              | WILD_DRAW_FOUR 
              | NUM of int 

(* Тип данных card для карты *)
type card = color * rank

(* Тип данных move для состояния очередного хода *)
datatype move = PROCEED | EXECUTE | GIVE of color 

(* Тип strategy для функции, определяющей стратегию игрока *)
type strategy = move * card list * card * int list -> card * color

(* Тип данных player для игрока *)
type player = {name : string, cards : card list, strat : strategy}

(* Тип данных desk для конфигурации игры *)
type desk = { players : player list
            , pile    : card list
            , deck    : card list
            , state   : move
            }

(* Исключение "Недозволенная игра" *)
exception IllegalGame
(* Исключение "Недозволенный ход". Аргумент - имя игрока, сделавшего ход *)
exception IllegalMove of string 

(* Функции сравнения на равенство значений карт, мастей карт и карт *)
fun isSameRank  (r1 : rank, r2 : rank) = r1 = r2
fun isSameColor (col1 : color, col2 : color) = col1 = col2
fun isSameCard  (c1 : card, c2 : card) = c1 = c2

(* Список всевозможных значений карт *)
val ranks = [ NUM 0, NUM 1, NUM 2, NUM 3, NUM 4
            , NUM 5, NUM 6, NUM 7, NUM 8, NUM 9
            , SKIP, DRAW_TWO, REVERSE, WILD, WILD_DRAW_FOUR 
            ]

(* Конструктор значения типа player (игрок) 
 * аргументы имя, список карт и функция стратегии *)
fun makePlayer (n, cs, f) : player = {name= n, cards = cs, strat = f}

(* Селекторы для игрока *)
fun getPlayerName ({name = n, ...} : player) = n
fun getPlayerCards ({cards = cs, ...} : player) = cs
fun getPlayerStrategy ({strat = f, ...} : player) = f 

(* Функция замены набора карт игрока *)
fun setPlayerCards (p, newCs) =
  makePlayer (getPlayerName p, newCs, getPlayerStrategy p)

(* Конструктор конфигурации игры *)
fun makeDesk (ps, cs, ds, st) : desk = 
  {players = ps, pile = cs, deck = ds, state = st}

(* Селекторы для конфигурации игры *)
fun getDeskPlayers ({players = ps, ...} : desk) = ps
fun getDeskPile ({pile = cs, ...} : desk) = cs
fun getDeskDeck ({deck = ds, ...} : desk) = ds
fun getDeskState ({state = st, ...} : desk) = st

(* Функция замены списка игроков в конфигурации игры *)
fun setDeskPlayers (dsk, newPlayers) =
  makeDesk ( newPlayers
           , getDeskPile dsk
           , getDeskDeck dsk
           , getDeskState dsk
           )

(* Функция замены состояния очередного хода в конфигурации игры *)
fun setDeskState (dsk, newState) =
  makeDesk ( getDeskPlayers dsk
           , getDeskPile dsk
           , getDeskDeck dsk
           , newState
           )

(* Функция - фальшивая стратегия игрока: какой бы не был ход, всегда 
 * выкладывается первая карта из списка карт игрока и заказывается 
 * зеленый цвет.
 * Это вспомогательная функция для отладки и тестирования *)
fun falseStrategy (_ : move, (c :: _) : card list, _ : card, _ : int list) = 
      (c, GREEN)
  | falseStrategy _ = raise IllegalGame
(******************************************************************************
 ******************************************************************************)

(* Задание 1. getNth *)
fun getNth (x :: _, 0) = x
  | getNth (x :: xs, n) = getNth (xs, n - 1)
  | getNth (_, _) = raise List.Empty

(* Задание 2. reverseAppend *)
fun reverseAppend (nil, ys) = ys
  | reverseAppend (x :: xs, ys) = reverseAppend (xs, x :: ys)

(* Задание 3. cardValue *)
fun cardValue card = case card
                       of (_, NUM x) => x
                        | (BLACK, _) => 50
                        | _ => 20
(* Задание 4. cardCount *)
fun cardCount card = case card 
                       of (BLACK, _) => 4
                        | (_, NUM 0) => 1
                        | _ => 2
(* Задание 5. rankColors *)
fun rankColors rank = case rank 
                        of WILD => [BLACK]
                         | WILD_DRAW_FOUR => [BLACK]
                         | _ => [RED, GREEN, BLUE, YELLOW]

(* Задание 6. sumCards *)
fun sumCards x =
  let
    fun sumCardsHelp (x :: xs, rez) = sumCardsHelp (xs, rez + cardValue x)
      | sumCardsHelp (nil, rez) = rez
  in
    sumCardsHelp (x, 0)
  end

(* Задание 7. removeNth *)
fun removeNth (lst, n) =
  let
    fun removeNthHelp (x :: xs, accum, 0) = reverseAppend (accum, xs)
      | removeNthHelp (x :: xs, accum, tempN) = removeNthHelp (xs, x :: accum, tempN - 1) 
      | removeNthHelp _ = raise List.Empty 
  in
    removeNthHelp (lst, nil, n)
  end

(* Задание 8. removeCard *)
fun removeCard (cs, c, e) =
  let
    fun removeCardHelp (x :: xs, accum) = 
      if isSameCard (x, c)
      then reverseAppend (accum, xs)
      else removeCardHelp (xs, x :: accum)
      | removeCardHelp (nil, _) = raise e 
  in
    removeCardHelp (cs, nil)
  end

(* Задание 9. insertElem *)
fun insertElem (cs, c, n) =
  let
    fun insertElemHelp (nil, accum, 0) = reverseAppend (accum, c :: nil)
      | insertElemHelp (x :: xs, accum, tempN) = 
        if tempN > 0 
        then insertElemHelp (xs, x :: accum, tempN - 1) 
        else reverseAppend (accum, c :: x :: xs)
      | insertElemHelp _ = raise List.Empty 
  in
    insertElemHelp (cs, nil, n)
  end

(* Задание 10. interchange *)
fun interchange (cs, i, j) = 
  let
    val cs = insertElem (cs, getNth (cs, j), i)
    val cs = insertElem (cs, getNth (cs, i + 1), j + 1)
    val cs = removeNth (cs, i + 1)
    val cs = removeNth (cs, j + 1)
  in
    cs
  end

(* Задание 11. shuffleList *)
fun shuffleList cs = 
  let
    val n = length cs
    val some_num = seed()
    val rnd = Random.rand (some_num, some_num mod 67)

    fun shuffleListHelp (cs, i) =
      let
        val get_num = Random.randRange (i, n - 1)
      in
        if i = n - 1 
        then cs
        else shuffleListHelp (interchange (cs, i, get_num rnd), i + 1)
      end
  in
    shuffleListHelp (cs, 0)
  end

(* Задание 12. allRankColors *)
fun allRankColors r =
  map (fn x => (x, r)) (rankColors r)

(* Задание 13. copyCardNTimes *)
fun copyCardNTimes c = 
  let
    fun copyCardNTimesHelp (0, rez) = rez
      | copyCardNTimesHelp (n, rez) = copyCardNTimesHelp (n - 1, c :: rez)
  in
    copyCardNTimesHelp (cardCount c, nil)
  end

(* Задание 14. deck *)
val deck = foldr (op @) nil (map copyCardNTimes (
  foldr (op @) nil (map allRankColors (foldr (op @) ranks nil))))

(* Задание 15. getSameRank *)
fun getSameRank (r, cs) = 
  List.filter (fn (x, y) => isSameRank (y, r)) cs

(* Задание 16. getSameColor *)
fun getSameColor (col, cs) =
  List.filter (fn (x, y) => isSameColor(x, col)) cs

(* Задание 17. hasRank *)
fun hasRank (r, cs) = 
  isSome (List.find (fn (x, y) => isSameRank (y, r)) cs)

(* Задание 18. hasColor *)
fun hasColor (col, cs) =
  isSome (List.find (fn (x, y) => isSameColor(x, col)) cs)

(* Задание 19. hasCard *)
fun hasCard (c, cs) = 
  isSome (List.find (fn (x, y) => isSameCard((x, y), c)) cs)

(* Задание 20. countColor *)
fun countColor (col, cs) = 
  length (getSameColor (col, cs))

(* Задание 21. maxColor *)
fun maxColor cs = 
  let
    val redCard = countColor (RED, cs)
    val greenCard = countColor (GREEN, cs)
    val blueCard = countColor (BLUE, cs)
    val yellowCard = countColor (YELLOW, cs)

    val maxCount = 
      if redCard >= greenCard then redCard else greenCard
    val maxCount = 
      if maxCount >= blueCard then maxCount else blueCard
    val maxCount = 
      if maxCount >= yellowCard then maxCount else yellowCard
  in
    if maxCount = redCard then RED 
      else if maxCount = greenCard then GREEN
           else if maxCount = blueCard then BLUE 
                else YELLOW
  end
