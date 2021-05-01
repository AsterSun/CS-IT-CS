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
fun getNth (el :: t, 0) = el
  | getNth ([], n) = raise List.Empty
  | getNth (el :: t, n) = if n < 0 then raise List.Empty else
  if n = 0 then el else getNth (t, n - 1)



(* Задание 2. reverseAppend *)
  fun reverseAppend (l1, l2) = 
    let
      fun reverse (l3, [], l2) = l3 @ l2
        | reverse (l3, l1h :: l1t, l2) = 
        reverse (l1h :: l3, l1t, l2 ) 
    in
      reverse ([], l1, l2)
    end

(* Задание 3. cardValue *)
fun cardValue (BLACK, _) = 50
  | cardValue (_, SKIP) = 20
  | cardValue (_, DRAW_TWO) = 20
  | cardValue (_, REVERSE) = 20
  | cardValue (_, NUM a) = a
  | cardValue (_, _) = ~1
(* Задание 4. cardCount *)
fun cardCount (_ , NUM 0) = 1
  |cardCount (_, NUM _) = 2
  | cardCount (BLACK, _) = 4
  | cardCount (_, _) = 2

(* Задание 5. rankColors *)
fun rankColors (NUM _) = [RED, GREEN, BLUE, YELLOW]
  | rankColors SKIP = [RED, GREEN, BLUE, YELLOW]
  |rankColors DRAW_TWO = [RED, GREEN, BLUE, YELLOW]
  |rankColors REVERSE = [RED, GREEN, BLUE, YELLOW]
  | rankColors _ = [BLACK]
(* Задание 6. sumCards *)
  fun sumCards (cards) = 
    let
      fun sum ([], s) = s
        | sum (ch :: ct, s) =
        sum (ct, s + cardValue ch)
    in
      sum (cards, 0)
    end

(* Задание 7. removeNth *)
  fun removeNth (lh :: lt, 0) = lt
    | removeNth (l, n) = 
    let
      fun removeIter (l2, [], n2) = if n >= n2 then raise List.Empty 
      else l2
        | removeIter (l2, lh :: lt, n2) = 
        if n2 <> n then removeIter (lh :: l2, lt, n2 + 1) 
        else if n2 > n then raise List.Empty else reverseAppend (l2, lt) 
    in
     removeIter ([], l, 0)
    end

(* Задание 8. removeCard *)
fun removeCard ([], c, e) = raise e
    |removeCard (cs, c, e) = 
    let
      fun f (cs2, [], c, false) = raise e
        | f (cs2, [], c, true) = cs2
        | f (cs2, csh :: cst, c, flag) = 
        if not (isSameCard (c, csh)) then f (csh :: cs2, cst, c, false)
        else reverseAppend (cs2, cst)
    in
      f ([], cs, c, true)
    end


(* Задание 9. insertElem *)
fun insertElem (cs, c, 0) = c :: cs
    | insertElem ([], c, n) = raise List.Empty
    | insertElem (cs, c, n) = 
    let
      fun insert (l2, [], n2) = if n > n2 then raise List.Empty  
      else reverseAppend (c :: l2, [])
      |insert (l2, lh :: lt, n2) = 
      if n2 <> n then insert (lh :: l2, lt, n2 + 1) 
      else if n > n2 then raise List.Empty 
      else reverseAppend (c :: l2, lh :: lt)  
    in
     if n < 0 then raise List.Empty else insert ([], cs, 0)
    end



(* Задание 10. interchange *)
fun interchange (cs, i, j) = 
  let
    val eli = getNth (cs, i)
    val elj = getNth (cs, j)
    val ldj = removeNth (cs, j)
    val lini = insertElem (ldj, eli, j)
    val ldi = removeNth (lini, i)
  in
    insertElem (ldi, elj, i)
  end
    


(* Задание 11. shuffleList *)
      fun shuffleList [] = []
        | shuffleList l =
        let
          val n = length l
          val rnd = Random.rand (seed(), seed() mod 67)
          fun fi i= i
           fun j(i) = Random.randRange (i, n - 1) rnd
            fun shuffle (i, lshuf) = if i <= n - 2 
             then shuffle (i + 1, interchange (l, i, j(i))) else lshuf
        in
          shuffle(0, l)
        end


    

(* Задание 12. allRankColors *)
fun allRankColors (r) = 
  let
    val m = rankColors r
    fun f c = (c, r)
  in
    map f m
  end
  


(* Задание 13. copyCardNTimes *)
fun copyCardNTimes (c) = 
  let
    val n = cardCount c
    fun f (c, 1, l) = c :: l
      | f (c, n, l) = if n <> 0 then f (c, n - 1, c :: l) else l
  in
    f (c, cardCount c, [])
  end
(* Задание 14. deck *)
val deck = 
  let
    val a = map allRankColors ranks
    val b = foldr (fn (x, y) => x @ y) [] a 
    val c = map copyCardNTimes b
    val c1 = foldr (fn (x, y) => x @ y) [] c
  in
     c1
  end  

  

  
(* Задание 15. getSameRank *)
fun getSameRank (r, cs) = 
  List.filter (fn (c, r1) => isSameRank(r1,r) ) cs
(* Задание 16. getSameColor *)
fun getSameColor (c, cs) = 
  List.filter (fn (c1, r) => isSameColor(c1,c)) cs
(* Задание 17. hasRank *)
fun hasRank (r, cs) = 
  isSome (List.find (fn (c, r1) => isSameRank(r1,r)) cs)
 
(* Задание 18. hasColor *)
fun hasColor (c, cs) =
  isSome (List.find (fn (c1, r) => isSameColor(c1, c)) cs)
  
(* Задание 19. hasCard *)
fun hasCard (c, cs) = 
  isSome (List.find (fn c1 => isSameCard(c1, c)) cs)


(* Задание 20. countColor *)
fun countColor (col, cs) = 
  length (getSameColor (col, cs))
(* Задание 21. maxColor *)
fun maxColor cs = 
  let
    val r = getSameColor (RED, cs)
    val g = getSameColor (GREEN, cs)
    val b = getSameColor (BLUE, cs)
    val y = getSameColor (YELLOW, cs)
    val black = getSameColor (BLACK, cs)
    fun f ([], count) = count
      | f (lh :: lt, count) = f (lt, count + 1)
      val cr = f (r, 0)
      val cg = f (g, 0)
      val cb = f (b, 0)
      val cy = f (y, 0)
      val cblack = f(black, 0)
  in
    if cr >= cg andalso cr >= cb andalso cr >= cy andalso cr >= cblack 
    then RED
    else if cr < cg andalso cg >= cb andalso cg >= cy andalso cg >= cblack 
    then GREEN
    else if cr < cb andalso cg < cb andalso cb >= cy andalso cb >= cblack 
    then BLUE 
     else if cr < cy andalso cg < cy andalso cb < cy andalso cy >= cblack 
     then YELLOW else BLACK

  end
(* Задание 22. deal *)
  fun deal l =
    let
      val allcards = shuffleList deck
     fun getn (el) =
        case el 
          of (n, s) => n 
       fun gets (el) =
        case el 
          of (n, s) => s         
      fun p ([], players, dh :: dt ) = 
        makeDesk(players, List. take(dh::dt, 1), dt, PROCEED)
        | p(lh :: lt, players, d) = p(lt, makePlayer(getn(lh), 
          List.take(d, 7), gets(lh)) :: players, List.drop (d, 7))
        | p (_, _, _) = makeDesk([], [], [], PROCEED)
    in
     p(l, [], allcards) 
    end

(* Задание 23. getPlayersFirst *)
    fun getPlayersFirst (dsk) = 
     let
       val ph::pt = getDeskPlayers (dsk)
     in
       ph
     end



(* Задание 24. getPileTop *)
fun getPileTop (dsk) =
  let
    val pi::pt = getDeskPile (dsk)
  in
    pi
  end
(* Задание 25. nextPlayer *)
fun nextPlayer (dsk) = 
  let
    val ph::pt = getDeskPlayers(dsk)
    val l = ph::[]
    val res = pt @ l
  in
    setDeskPlayers(dsk, res)
  end
(* Задание 26. changeDirection *)
fun changeDirection (dsk) = 
  let
    val ph :: pt = getDeskPlayers(dsk)
    val ptrev = reverseAppend(pt, []) 
    val res = ph :: ptrev
  in
    setDeskPlayers(dsk, res)
  end
(* Задание 27. start *)
  fun start dsk = 
    let
      val d = shuffleList deck 
      val pi = getPileTop dsk
      val newd = shuffleList (pi :: d)
      val newpi = getPileTop dsk
      fun checkpi (_, REVERSE) = changeDirection dsk
        | checkpi (_, SKIP) = nextPlayer (setDeskState (dsk, EXECUTE ))
        | checkpi (_, DRAW_TWO) = nextPlayer (setDeskState (dsk, EXECUTE ))
        | checkpi (_, _) = nextPlayer dsk
      fun iswild (_, WILD) = true
        | iswild (_, _) = false
    in
      if iswild pi then checkpi newpi else checkpi pi
    end

(* Задание 28. takeOne *)
      fun takeOne dsk = 
        let  
          val pfirst = getPlayersFirst dsk
          val ph :: pt = getDeskPlayers dsk
          val pih :: pit = getDeskPile dsk
          val dh :: dt = getDeskDeck dsk
          fun f () =
          case  (getDeskDeck dsk) 
          of (d :: []) => true
            | _ => false
          fun newpl() = 
            setPlayerCards (pfirst, dh :: getPlayerCards pfirst )
        in
          if f() then makeDesk 
            (newpl() :: pt, pih :: [], shuffleList pit, getDeskState dsk)
          else makeDesk (newpl() :: pt, getDeskPile dsk, dt, getDeskState dsk)
        end

(* Задание 29. takeTwo *)
val takeTwo = takeOne o takeOne 
(* Задание 30. takeFour *)
val takeFour = takeTwo o takeTwo
(* Задание 31. pass *)

(* Задание 32. requiredColor *)
fun requiredColor dsk = 
  let
    val st = getDeskState dsk
    val pi = getPileTop dsk 
    fun f (el) = 
      case (el) 
        of (c, r) => c
    fun f1 (st) =
       case (st)
        of (GIVE c) => c
        | (_) => f (pi) 
  in
    f1 st
  end

(* Задание 33. playableCards *)

(* Задание 34. countCards *)
fun countCards dsk = 
  map (length o getPlayerCards) (getDeskPlayers dsk) 
(* Задание 35. hasNoCards *)
 val hasNoCards = null o getPlayerCards
(* Задание 36. countLoss *)

(* Задание 37. naiveStrategy *)

(* Задание 38. play *)

(* Задание 39. gameStep *)

(* Задание 40. game *)
