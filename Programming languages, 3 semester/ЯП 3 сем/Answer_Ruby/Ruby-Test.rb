class Integer
  def to_ii
    a = self.to_s
    (a + a).to_i
  end
end

class Array
  def add b
    a = self
    a = a.zip b
    a = a.map {|x| x.reduce(:+)}
  end
end

def arr
  a = Array.new(2) {Array.new (2)}
end

