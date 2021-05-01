fun f (x : int) : int list * int list list * int list list =
  let
    val A = [x + 3, x + 5]
    val bA = A :: A :: []
  in
    (A, bA, A :: bA)
  end