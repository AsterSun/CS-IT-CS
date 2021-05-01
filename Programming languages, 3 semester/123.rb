class Array
  def set!(n, x, ship)
    n.times {self[x] = ship 
             x += 1 }
  end
end

@vasd = Array.new