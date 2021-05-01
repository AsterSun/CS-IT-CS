## Шаблон для выполнения заданий Лабораторной работы №6 
## ВСЕ КОММЕНТАРИИ ПРИВЕДЕННЫЕ В ДАННОМ ФАЙЛЕ ДОЛЖНЫ ОСТАТЬСЯ НА СВОИХ МЕСТАХ
## НЕЛЬЗЯ ПЕРЕСТАВЛЯТЬ МЕСТАМИ КАКИЕ-ЛИБО БЛОКИ ДАННОГО ФАЙЛА
## решения заданий должны быть вписаны в отведенные для этого позиции 

################################################################################
# Задание 1 
# add b
################################################################################

class Array
  def add b
    a = self
    a = a.zip b
    a = a.map {|x| x.reduce(:+)}
  end
end

# конец описания задания 1
################################################################################

################################################################################
# Задания 2-6 
# Класс Field
################################################################################

class Field

  def initialize
    @field = Array.new(size) {Array.new (size)}
  end

  FieldSize = 10

  # Задание 3 size (метод класса)

  def size 
    FieldSize
  end

  # Задание 4 set!(n, x, y, hor, ship)

  def set!(n, x, y, hor, ship)
    if hor == true
      while n > 0
        @field[x][y] = ship
        n = n - 1
        x = x + 1
      end
    else 
      while n > 0
        @field[x][y] = ship
        n = n - 1
        y = y + 1
      end
    end
  end

  # Задание 5 print_field

  def print_field 

    print("+")
    temp_j = size
    while temp_j > 0 
      print("-")
      temp_j = temp_j - 1
    end
    print("+\n")

    temp_i = 0
    while temp_i < size 
      print("|")
      temp_j = 0
      while temp_j < size 
        if @field[temp_i][temp_j] == nil
          print(" ")
        else
          print(@field[temp_i][temp_j].to_s)
        end
        temp_j = temp_j + 1
      end
      temp_i = temp_i + 1
      print("|\n")
    end

    print("+")
    temp_j = size
    while temp_j > 0 
      print("-")
      temp_j = temp_j - 1
    end
    print("+\n")

  end

  # Задание 6 free_space?(n, x, y, hor, ship)

  def free_space?(n, x, y, hor, ship)

    if (x == 0) 
    then x_top = x
    else x_top = x - 1
    end

    if (y == 0) 
    then y_left = y
    else y_left = y - 1
    end

    if (hor == true and x + n > size) or 
       (hor == false and y + n > size) or
       (x < 0) or (y < 0)
    then return false
    end

    if (hor == true and x + n == size) 
    then x_bottom = x + n
    else x_bottom = x + n + 1
    end

    if (hor == true and y == size - 1) 
    then y_right = y
    else y_right = y + 1
    end
      
    if (hor == false and x == size - 1) 
    then x_bottom = x - 1
    else x_bottom = x 
    end

    if (hor == false and y + n == size ) 
    then y_right = y + n - 1
    else y_right = y + n
    end

    temp_true = 0;
    temp_S = ( y_right - y_left) * (x_bottom - x_top )
    while x_top <= x_bottom
      while y_left <= y_right
        if (@field[x_top][y_left] != nil) and
           (@field[x_top][y_left] != ship)
           temp_true = temp_true + 1
        end
        y_left = y_left + 1
       end
      x_top = x_top + 1
    end

    if (temp_true == temp_S)
    then return true
    else return false 
    end

  end

end

# конец описания класса Field
################################################################################


################################################################################
# Задания 7-16 
# Класс Ship
################################################################################

class Ship

  def initialize (field, len)
    @len = len
    @myfield = field
    @maxhealth = @len * 100
    @minhealth = @len * 30
    @health = @maxhealth
  end

  def len
    @len
  end

  def coord
    @coord
  end

  # Задание 8 to_s

  def to_s
    "X"
  end

  # Задание 9 clear

  def clear
    x_start = @coord[0]
    y_start = @coord[1]
    x_end = @coord[3]
    y_end = @coord[4]
    if @hor == true
      while x_start <= x_end
        @myfield[x_start][y_start] = nil
      x_start = x_start + 1
      end
    end
    if @hor == false
      while y_start <= y_end
        @myfield[x_start][y_start] = nil
      y_start = y_start + 1
      end
    end

  end

  # Задание 10 set!(x, y, hor)

  def set!(x, y, hor)
    if not @myfield.free_space?(@len, x, y, @hor, self)
    then return false
    else 
      clear
      @myfield.set!(@len, x, y, @hor, self)
      @coord[0] = x 
      @coord[1] = y 
      if hor == true
      then
        @coord[2] = x + @len
        @coord[3] = y 
      else
        @coord[2] = x 
        @coord[3] = y + @len
      end
      @hor = hor
      return true
    end
  end

  # Задание 11 kill
  def kill
    clear
    @coord = nil
  end

  # Задание 12 explode

  def explode
    @health = @health - 70
    if (@health <= @minhealth)
    then 
      kill
      return @len
    else return nil
    end
  end

  # Задание 13 cure

  def cure
    if (@health + 30 <= @maxhealth)
    then @health = @health + 30
    else @health = @maxhealth
    end
  end

  # Задание 14 health

  def health
    (@health / @maxhealth * 100).round(2)
  end

  # Задание 15 move(forward)

  def move(forward)

    if (hor == true and forward == true)
    then return @myfield.set!(@len, x + 1, y, @hor, self)
    end

    if (hor == true and forward == false)
    then return @myfield.set!(@len, x - 1, y, @hor, self)
    end

    if (hor == false and forward == true)
    then return @myfield.set!(@len, x, y + 1, @hor, self)
    end

    if (hor == false and forward == false)
    then return @myfield.set!(@len, x, y - 1, @hor, self)
    end

  end

  # Задание 16 rotate(n, k)

  def rotate(n, k)
  end

end
# конец описания класса Ship
################################################################################

################################################################################
# Задания 17-25
# Класс BattleField
################################################################################

class BattleField < Field

  def initialize 
    @field = Array.new(size) {Array.new (size)}
    newships
  end

  Ships = [4,3,3,2,2,2,1,1,1,1]

  def newships
    @allships = map.Ships {|x| x = Ship.new(BattleField.new, len)}
  end

  # Задание 18 fleet

  def fleet
    @allships.each_with_index.map {|i, len|}
  end

  # Задание 19 place_fleet pos_list

  # Задание 20 remains

  # Задание 21 refresh

  # Задание 22 shoot c

  # Задание 23 cure

  # Задание 24 game_over?

  # Задание 25 move l_move

end

# конец описания класса BattleField
################################################################################


################################################################################
# Задания 26-31
# Класс Player
################################################################################

  # Задание 27 random_point

  # Задание 28 place_strategy ship_list

  # Задание 29 hit message
  #            miss

  # Задание 30 shot_strategy
  def shot_strategy
    if @manual
      @lastshots.each {|x| print(x, "\n")}
      puts "Make a shot. To switch off the manual mode enter -1 for any coordinate"
      while true
        print "x = "; x = gets.to_i; print x
        print " y = "; y = gets.to_i; puts y
        shot = [x,y]
        if shot.all? {|a| a.between?(-1, Field.size - 1)}
          break
        else
          puts "Incorrect input"
        end
      end
      if shot.any? {|a| a == -1}
        @manual = false
        shot_strategy
      else
        @shot = shot
      end
    else
      # Здесь необходимо разместить решение задания 30

      # конец решения задания 30
    end
  end

  # Задание 31 ship_move_strategy remains
  def ship_move_strategy remains
    if @manual
      puts "Ship health"
      tmp_field = Field.new
      names = ("0".."9").to_a + ("A".."Z").to_a + ("a".."z").to_a
      ship_hash = {}
      remains.each do |ship|
        name = names[ship[0]]
        x = ship[1][0]; y = ship[1][1]
        hor = (ship[1][1] == ship[1][3])
        ship_hash[name] = [ship[0], ship[2]]
        tmp_field.set!(ship[2], x, y, hor, name)
        print(name, " - ", ship[3], "%\n") 
      end
      puts "Your ships"
      tmp_field.print_field
      puts "Make a move. To switch off the manual mode enter an incorrect ship name"
      while true
        print "Choose ship: "; 
        name = gets.strip; puts name
        if !ship_hash[name] then break end
        move = 0
        begin
          print "Enter 0 to move, 1-3 to rotate: " 
          move = gets.to_i; puts move
        end until move.between?(0,3)
        if move == 0
          print "1 - forward/any - backward): "; dir = gets.to_i
          puts dir
        else
          dir = 0
          begin
            print "Choose a center point: (1..#{ship_hash[name][1]}): "
            dir = gets.to_i; puts dir
          end until dir.between?(1,ship_hash[name][1])
        end
        break
      end
      if !ship_hash[name]
        @manual = false
        ship_move_strategy remains
      else
        [ship_hash[name][0], move, dir]
      end
    else
      # Здесь необходимо разместить решение задания 31
      
      # конец решения задания 31
    end
  end 


# конец описания класса Player
################################################################################

################################################################################
# Задания 32-33 
# Класс Game
################################################################################

  # Задание 33 start

# конец описания класса Game
################################################################################

################################################################################
# Переустановка датчика случайных чисел
################################################################################
srand
################################################################################

#№ Пример запуска
# p1 = Player.new("Ivan",true)
# p2 = Player.new("Feodor")
# g = Game.new(p1,p2)
# g.start

