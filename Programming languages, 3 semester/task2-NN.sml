fun f (x : int) : real * real * int * int =
  let
  (* Для того, чтобы не повторять вычисления,
   * сохраняем промежуточные величины.
   * Каждая из них потребуется в дальнейшем
   * не менее двух раз. *)
    val A = x + 4
    val B = x - 4
    val rA = real A
    val rB = real B
  in
    (rA / rB, rA * rB / (rA + 1.0), A, B)
  end
