(* Задание 1. getNth *)
val testGetNth1 = getNth ([0, 1, 2, 3, 4], 2) = 2
val testGetNth2 = getNth (["0", "1", "2", "3", "4"], 2) = "2"
val testGetNth3 = getNth ([0, 1, 2, 3, 4], 5) = 5
                        handle List.Empty => true
val testGetNth4 = getNth ([0, 1, 2, 3, 4], 0) = 0
val testGetNth5 = getNth ([0, 1, 2, 3, 4, 13], 5) = 13

(* Задание 2. REVERSEAppend *)
val testReverseAppend1 = reverseAppend ([0, 1, 2, 3], [4, 5, 6]) 
                            = [3, 2, 1, 0, 4, 5, 6]
val testReverseAppend2 = reverseAppend ([0, 1, 2], [5, 6]) 
                            = [2, 1, 0, 5, 6]
val testReverseAppend3 = reverseAppend ([0, 1], [5, 6]) 
                            = [1, 0, 5, 6]

(* Задание 3. cardValue *)
val testCardValue1 = cardValue (RED, NUM 9) = 9
val testCardValue2 = cardValue (BLACK, WILD) = 50
val testCardValue3 = cardValue (BLACK, WILD_DRAW_FOUR) = 50
val testCardValue4 = cardValue (GREEN, REVERSE) = 20

(* Задание 4. cardCount *)
val testCardCount1 = cardCount (RED, NUM 0) = 1
val testCardCount2 = cardCount (GREEN, NUM 2) = 2
val testCardCount3 = cardCount (BLACK, WILD) = 4

(* Задание 5. rankColors *)
val testRankColors1 = rankColors WILD = [BLACK]
val testRankColors2 = rankColors REVERSE = [RED, GREEN, BLUE, YELLOW]
val testRankColors3 = rankColors SKIP = [RED, GREEN, BLUE, YELLOW]

(* Задание 6. sumCards *)
val testSumCards1 = sumCards [(BLACK, WILD), (RED, NUM 0)] = 50
val testSumCards2 = sumCards [(BLACK, WILD), (RED, NUM 9)] = 59
val testSumCards3 = sumCards [(BLACK, WILD), (RED, SKIP)] = 70

(* Задание 7. removeNth *)
val testRemoveNth1 = removeNth ([0, 1, 2, 3, 4], 2) = [0, 1, 3, 4]
val testRemoveNth2 = removeNth (["0", "1", "2", "3", "4"], 2) 
                     = ["0", "1", "3", "4"]
val testRemoveNth3 = removeNth ([0, 1, 2, 3, 4], 5) = []
                          handle List.Empty => true
val testRemoveNth4 = removeNth ([0, 1, 2, 3, 4], 0) = [1, 2, 3, 4]
val testRemoveNth5 = removeNth ([0, 1, 2, 3, 4], 4) = [0, 1, 2, 3]

(* Задание 8. removeCard *)
val testRemoveCard1 = removeCard ([], (BLUE, NUM 2), List.Empty) = []
                            handle List.Empty => true
val testRemoveCard2 = 
    removeCard ([(BLUE, NUM 2)], (BLUE, NUM 2), List.Empty) = []
val testRemoveCard3 = 
    removeCard ([(BLUE, NUM 2), (BLACK, WILD)], (BLUE, NUM 2), List.Empty) = [(BLACK, WILD)]
val testRemoveCard4 = 
    removeCard ([(BLUE, NUM 2), (BLACK, WILD)], (BLACK, WILD), List.Empty) = [(BLUE, NUM 2)]

(* Задание 9. insertElem *)
val testInsertElem1 = insertElem ([], 2, 0) = [2]
val testInsertElem2 = insertElem ([], 2, 1) = [2]
                            handle List.Empty => true
val testInsertElem3 = insertElem ([2], 2, 0) = [2, 2]
val testInsertElem4 = insertElem ([1, 3], 2, 0) = [2, 1, 3]

(* Задание 10. interchange *)
val testInterchange1 = interchange ([0, 1, 2, 3], 1, 3) = [0, 3, 2, 1]
val testInterchange2 = interchange ([0, 1, 2, 3], 3, 1) = [0, 3, 2, 1]
val testInterchange3 = interchange ([2, 4], 0, 1) = [4, 2]
val testInterchange4 = interchange ([0, 1], 0, 1) = [1, 0]

