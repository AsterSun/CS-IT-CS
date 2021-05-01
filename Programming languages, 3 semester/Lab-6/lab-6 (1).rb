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
    self.each_with_index.map {|a, i| a + b[i]}
  end

end

# конец описания задания 1
################################################################################

################################################################################
# Задания 2-6 
# Класс Field
################################################################################
class Field

  FieldSize = 10

  def initialize
    @field = Array.new(FieldSize) {Array.new(FieldSize)}
  end

  # Задание 3 size (метод класса)
  def self.size
    FieldSize
  end

  # Задание 4 set!(n, x, y, hor, ship)
  def set!(n, x, y, hor, ship)
    if 
      hor
    then
      n.times {@field[x][y] = ship
               x += 1}
    else
      n.times {@field[x][y] = ship
               y += 1}
    end
  end
  
  # Задание 5 print_field
  def print_field
    print "+"
    Field.size.times {print "-"}
    print "+\n"
    @field.each do |i|
      print "|"
      i.each {|j| print (!j ? " " : j.to_s)}
      print "|\n"
    end
    print "+"
    Field.size.times {print "-"}
    print "+\n"
    nil
  end
  
  # Задание 6 free_space?(n, x, y, hor, ship)
  def free_space? (n, x, y, hor, ship)
  end
end
# конец описания класса Field
################################################################################


################################################################################
# Задания 7-16 
# Класс Ship
################################################################################
class Ship
  attr_reader :coord, :len

  def initialize(field, len)
    @len = len
    @myfield = field
    @maxhealth = 100 * len
    @minhealth = 30 * len
    @health = @maxhealth
  end

  # Задание 8 to_s
  def to_s
    "X"
  end

  # Задание 9 clear
  def clear
    @myfield.set!(@len, @coord[0], @coord[1], @hor, nil)
  end

  # Задание 10 set!(x, y, hor)
  def set! (x, y, hor)
  end

  # Задание 11 kill
  def kill
    clear
    @coord = nil
  end

  # Задание 12 explode
  def explode
    @health -= 70
    if @health <= @minhealth 
    then kill 
      return @len
    end
    nil
  end

  # Задание 13 cure
  def cure
    @health += 30
    if @health > @maxhealth then @health = @maxhealth end
  end

  # Задание 14 health
  def health
    (100 * @health.to_f / @maxhealth).round(2)
  end

  # Задание 15 move(forward)
  def move forward
  end

  # Задание 16 rotate(n, k)
  def rotate (n, k)
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
    super
    newships
  end

  Ships = [4,3,3,2,2,2,1,1,1,1]

  def newships
    @allships = Ships.map {|i| Ship.new(self, i)}
  end

  # Задание 18 fleet
  def fleet
    @allships.each_with_index.map {|x, i| [i, x.len]}
  end

  # Задание 19 place_fleet pos_list
  def place_fleet pos_list
  end

  # Задание 20 remains
  def remains
    @allships.each_with_index.map {|x, i| [i, x.coord, x.len, x.health]}
  end

  # Задание 21 refresh

  # Задание 22 shoot c

  # Задание 23 cure
  def cure
    @allships.each {|ship| ship.cure}
  end

  # Задание 24 game_over?
  def game_over?
    @allships.empty?
  end

  # Задание 25 move l_move
end
# конец описания класса BattleField
################################################################################


################################################################################
# Задания 26-31
# Класс Player
################################################################################
class Player

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

end
# конец описания класса Player
################################################################################

################################################################################
# Задания 32-33 
# Класс Game
################################################################################
class Game
  # Задание 33 start
end
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

