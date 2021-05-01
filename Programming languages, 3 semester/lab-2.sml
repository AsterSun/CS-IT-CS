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
  | getNth (_ :: xs, n) = getNth (xs, n - 1)
  | getNth _ = raise List.Empty

(* Задание 2. reverseAppend *)
fun reverseAppend ([], res) = res
  | reverseAppend (x :: xs, res) = reverseAppend (xs, x :: res)

(* Задание 3. cardValue *)
fun cardValue card =
  case card
    of (_, NUM x) => x
     | (BLACK, _) => 50
     | _          => 20

(* Задание 4. cardCount *)
fun cardCount card =
  case card
    of (_, NUM 0) => 1
     | (BLACK, _) => 4
     | _          => 2

(* Задание 5. rankColors *)
fun rankColors rank =
  case rank
    of WILD_DRAW_FOUR => [BLACK]
     | WILD           => [BLACK]
     | _              => [RED, GREEN, BLUE, YELLOW]

(* Задание 6. sumCards *)
fun sumCards cards =
  let
    fun sumCardsIter ([], sum) = sum
      | sumCardsIter (x :: xs, sum) = sumCardsIter (xs, cardValue x + sum)
  in
    sumCardsIter (cards, 0)
  end

(* Задание 7. removeNth *)
fun removeNth (cards, n) =
  let
    fun removeNthIter (sum, x :: xs, 0) = reverseAppend (sum, xs)
      | removeNthIter (sum, x :: xs, n) = removeNthIter (x :: sum, xs, n - 1)
      | removeNthIter _ = raise List.Empty
  in
    removeNthIter ([], cards, n)
  end

(* Задание 8. removeCard *)
fun removeCard (cs, c, e) =
  let
    fun removeCardIter (_, []) = raise e
      | removeCardIter (checked, x :: xs) =
          if isSameCard (x, c)
          then reverseAppend (checked, xs)
          else removeCardIter (x :: checked, xs)
  in
    removeCardIter ([], cs)
  end

(* Задание 9. insertElem *)
fun insertElem (cs, c, n) =
  let
    fun insertElemIter (sum, xs, 0, c) = reverseAppend (sum, c :: xs)
      | insertElemIter (sum, x :: xs, n, c) = 
          insertElemIter (x :: sum, xs, n - 1, c)
      | insertElemIter _ = raise List.Empty
  in
    insertElemIter ([], cs, n, c)
  end

(* Задание 10. interchange *)
fun interchange (cs, i, j) =
  insertElem (removeNth (insertElem (removeNth (cs, i), getNth (cs, j), i), j)
              , getNth (cs, i)
              , j)

(* Задание 11. shuffleList *)

(* Задание 12. allRankColors *)

(* Задание 13. copyCardNTimes *)

(* Задание 14. deck *)

(* Задание 15. getSameRank *)

(* Задание 16. getSameColor *)

(* Задание 17. hasRank *)

(* Задание 18. hasColor *)

(* Задание 19. hasCard *)

(* Задание 20. countColor *)

(* Задание 21. maxColor *)

(* Задание 22. deal *)

(* Задание 23. getPlayersFirst *)

(* Задание 24. getPileTop *)

(* Задание 25. nextPlayer *)

(* Задание 26. changeDirection *)

(* Задание 27. start *)

(* Задание 28. takeOne *)

(* Задание 29. takeTwo *)

(* Задание 30. takeFour *)

(* Задание 31. pass *)

(* Задание 32. requiredColor *)

(* Задание 33. playableCards *)

(* Задание 34. countCards *)

(* Задание 35. hasNoCards *)

(* Задание 36. countLoss *)

(* Задание 37. naiveStrategy *)

(* Задание 38. play *)

(* Задание 39. gameStep *)

(* Задание 40. game *)