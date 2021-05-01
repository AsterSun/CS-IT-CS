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
fun getNth (l, n) =
  let
    fun get ([], i, n) = raise List.Empty
      | get ([x], 0, 0) = x
      | get ([x], i, n) =
         if n > i orelse n < 0 then raise List.Empty
         else x
      | get (x :: (xs as _ :: _), i, n) =
         if n = i then x 
         else get(xs, i + 1, n)
  in
    get (l, 0, n)
  end

(* Задание 2. reverseAppend *)

(* Задание 3. cardValue *)

(* Задание 4. cardCount *)

(* Задание 5. rankColors *)

(* Задание 6. sumCards *)

(* Задание 7. removeNth *)

(* Задание 8. removeCard *)

(* Задание 9. insertElem *)

(* Задание 10. interchange *)

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
