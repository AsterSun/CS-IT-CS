fun f (x : int) : real list =
  let
    val rA = real (x + 1)
    val rB = real (x + 2)
    val rC = real (x + 3)
    val rD = real (x + 4)
  in
    [rA * rB / rC, rB * rC / rD, rD * rD / rA]
  end