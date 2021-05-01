## Шаблон для выполнения заданий Лабораторной работы №6 
## ВСЕ КОММЕНТАРИИ ПРИВЕДЕННЫЕ В ДАННОМ ФАЙЛЕ ДОЛЖНЫ ОСТАТЬСЯ НА СВОИХ МЕСТАХ
## НЕЛЬЗЯ ПЕРЕСТАВЛЯТЬ МЕСТАМИ КАКИЕ-ЛИБО БЛОКИ ДАННОГО ФАЙЛА
## решения заданий должны быть вписаны в отведенные для этого позиции 

################################################################################
# Задание 1 
# add b
class Array
  def add b
    self.zip(b).map { |e| e.reduce(:+) }
  end
end
################################################################################

# конец описания задания 1
################################################################################

################################################################################
# Задания 2-6 
# Класс Field
################################################################################
class Field 
  FieldSize = 10
  def initialize
    @field = Array.new(FieldSize) { Array.new(FieldSize) }
  end

  # Задание 3 size (метод класса)
  def self.size
    FieldSize
  end

  # Задание 4 set!(n, x, y, hor, ship)
  def set!(n, x, y, hor, ship)
    if hor == true then
      n.times {
        @field[x][y] = ship
        x += 1
      }
    else
      n.times {
        @field[x][y] = ship
        y += 1
      }
    end
  end

  # Задание 5 print_field
  def print_field
    print "+"
    FieldSize.times { print "-" }
    print "+\n"
    j = 0
    FieldSize.times {
      print "|"
      i = 0
      FieldSize.times { 
        if @field[j][i] == nil then
           print " "
        else 
          print (@field[j][i].to_s)
        end
        i += 1
      }
      j += 1
      print "|\n"
    }
    print "+"
    FieldSize.times { print "-" }
    print "+\n"
    nil
  end

  # Задание 6 free_space?(n, x, y, hor, ship)
  def free_space?(n, x, y, hor, ship)
    if (hor == true and (x + n > FieldSize or y >= FieldSize)) or 
       (hor == false and (y + n > FieldSize or x >= FieldSize)) or 
       y < 0 or x < 0 or y >= FieldSize or x >= FieldSize
    then return false
    end

    if (hor == true and x + n == FieldSize) 
    then down = x + n - 1
    elsif (hor == true and x + n != FieldSize) 
    then down = x + n
    elsif (hor == false and x + 1 == FieldSize) 
    then down = x
    else down = x + 1
    end

    if (x == 0) 
    then up = x
    else up = x - 1
    end

    if (hor == false and y + n == FieldSize) 
    then right = y + n - 1
    elsif (hor == false and y + n != FieldSize) 
    then right = y + n
    elsif (hor == true and y + 1 == FieldSize) 
    then right = y
    else right = y + 1
    end

    if (y == 0) 
    then left = y
    else left = y - 1
    end

    l = left
    n1 = down - up + 1
    n2 = right - left + 1
    flag = true
    n1.times {
      n2.times {
        if @field[up][left] != nil and @field[up][left] != ship
        then flag = false
        end
        left += 1
      }
      up += 1
      left = l
    }
    return flag
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
    @maxhealth = 100 * len
    @minhealth = 30 * len
    @health = @maxhealth
  end

  attr_reader :len, :coord

  # Задание 8 to_s
  def to_s
    "X"
  end

  # Задание 9 clear
  def clear
    @myfield.set!(@len, @coord[0], @coord[1], @hor, nil)
  end

  # Задание 10 set!(x, y, hor)
  def set!(x, y, hor)
    if @myfield.free_space?(@len, x, y, hor, self)
    then
      if @coord
      then
        clear
      end
      @myfield.set!(@len, x, y, hor, self)
      @coord = [x, y]
      if hor == true
      then
        x2 = x + @len - 1
        y2 = y
      else 
        x2 = x
        y2 = y + @len - 1
      end
      @coord[2] = x2
      @coord[3] = y2
      @hor = hor
      true
    else
      false
    end
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
    then 
      kill
      @len
    else 
      nil
    end
  end

  # Задание 13 cure
  def cure
    if @health + 30 >= @maxhealth
    then @health = @maxhealth
    else @health += 30
    end
  end

  # Задание 14 health
  def health 
    (@health.to_f / @maxhealth.to_f * 100).round(2)
  end

  # Задание 15 move(forward)
  def move(forward)
    if @hor == true
    then
      if forward == true
      then set!(@coord[0] + 1, @coord[1], @hor)
      else set!(@coord[0] - 1, @coord[1], @hor)
      end
    else
      if forward == true
      then set!(@coord[0], @coord[1] + 1, @hor)
      else set!(@coord[0], @coord[1] - 1, @hor)
      end
    end
  end

  # Задание 16 rotate(n, k)
  def rotate(n, k)
    h = !@hor
    if n < 1 or n > @len
    then false
    else 
      if k == 1
      then
        if @hor
        then 
          newx = @coord[0] + n - 1
          newy = @coord[1] - n + 1
        else
          newx = @coord[2] + n - @len
          newy = @coord[3] + n - @len
        end
        set!(newx, newy, h)
      elsif k == 2
      then
        if @hor
        then 
          newx = @coord[2] + n * 2 - @len * 2
          newy = @coord[3]
        else
          newx = @coord[2]
          newy = @coord[3] + n * 2 - @len * 2
        end
        set!(newx, newy, @hor)
      elsif k == 3
      then
        if @hor
        then 
          newx = @coord[2] + n - @len
          newy = @coord[3] + n - @len
        else
          newx = @coord[0] - n + 1
          newy = @coord[1] + n - 1
        end
        set!(newx, newy, h)
      else false
      end
    end
  end
end
# конец описания класса Ship
################################################################################

################################################################################
# Задания 17-25
# Класс BattleField
################################################################################
class BattleField < Field
  Ships = [4,3,3,2,2,2,1,1,1,1]

  def newships
    @allships = []
    Ships.each_with_index { |e, i| @allships[i] = Ship.new(self, e) }
    @allships
  end

  def initialize
    super
    newships
  end

  # Задание 18 fleet
  def fleet
    @allships.each_with_index.map { |e, i| [i, e.len] }
  end

  # Задание 19 place_fleet pos_list
  def place_fleet pos_list
    flag = true
    pos_list.each { |e| 
      i = e[0]
      x = e[1]
      y = e[2]
      h = e[3]
      if @allships[i].set!(x, y, h) == false
      then flag = false
      end
    }
    if flag
    then
      @allships.each { |e| 
        if !e.coord
        then flag = false
        end
      }
    end
    if !flag
    then 
      @allships.each { |s| if s.coord then s.kill end }
      return false
    else return true
    end
  end

  # Задание 20 remains
  def remains
    @allships.each_with_index.map { |e, i| [i, e.coord, e.len, e.health] }
  end

  # Задание 21 refresh
  def refresh
    @allships = @field.reduce(:|).find_all { |e| e}
  end

  # Задание 22 shoot c
  def shoot c
    if !@field[c[0]][c[1]]
    then "miss"
    else
      n = @field[c[0]][c[1]].explode
      if n != nil
      then
        refresh
        "killed " + n.to_s
      else "wounded"
      end
    end
  end

  # Задание 23 cure
  def cure
    @allships.each { |e| e.cure}
  end

  # Задание 24 game_over?
  def game_over?
    @allships.empty?
  end

  # Задание 25 move l_move
  def move l_move
    i = l_move[0]
    move_t = l_move[1]
    dir = l_move[2]
    if move_t >= 1 and move_t <= 3
    then @allships[i].rotate(dir, move_t)
    else
      if dir == 1
      then @allships[i].move(true)
      else @allships[i].move(false)
      end
    end
  end

end
# конец описания класса BattleField
################################################################################


################################################################################
# Задания 26-31
# Класс Player
################################################################################
class Player
  attr_reader :name
  attr_accessor :manual

  def reset
    @allshots = []
    @lastshots = []
  end

  def initialize(name, manual = true)
    @name = name
    @manual = manual
    @lastsample = [1, 0]
    reset
  end

  # Задание 27 random_point
  def random_point
    [rand(Field.size), rand(Field.size)]
  end

  # Задание 28 place_strategy ship_list
  def place_strategy ship_list
    sit = []
    helpF = Field.new
    ship_list = ship_list.sort { |a, b| b[1] <=> a[1] }
    rotates = [true, false]
    ship_list.each { |e|
      i = e[0]
      len = e[1]
      c = random_point
      hor = rotates[rand(2)]
      while !helpF.free_space?(len, c[0], c[1], hor, i) 
        c = random_point
        hor = rotates[rand(2)]
      end
      helpF.set!(len, c[0], c[1], hor, i)
      sit.push [i, c[0], c[1], hor]
    }
    sit
  end

  # Задание 29 hit message
  def hit message
    @lastshots.push [@shot, message]
  end

  #            miss
  def miss
    @lastshots.push [@shot, "miss"]
    @allshots.push(@lastshots)
    @lastshots = []
  end

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
      if @lastshots.empty? || @lastshots[-1][1][0,4] == "kill"
      then 
        @shot = random_point()
      else
        if @lastshots.length == 1 || @lastshots[-2][1][0,4] == "kill"
        then
          sh = @lastshots[-1][0]
          temp = [[sh[0] + 1, sh[1]], [sh[0] - 1, sh[1]], 
                  [sh[0], sh[1] + 1], [sh[0], sh[1] - 1]]
          @shot = temp.sample
          @lastsample = [@shot[0] - @lastshots[-1][0][0], 
                         @shot[1] - @lastshots[-1][0][1]]
        end

        if @lastshots.length >= 2 && @lastshots[-2][1][0,7] == "wounded" && 
           @lastshots[-1][1][0,7] == "wounded"
        then
          @shot = [@shot[0] + @lastsample[0], @shot[1] + @lastsample[1]]
        end

        if @shot[0] < 0 || @shot[0] >= Field.size || 
           @shot[1] < 0 || @shot[1] >= Field.size
        then
          @lastsample = [-@lastsample[0], -@lastsample[1]]
          @shot = [@lastshots[-1][0][0] + @lastsample[0], 
                   @lastshots[-1][0][1] + @lastsample[1]]
        end
      end

      flag = false
      @lastshots.each { |e|
        if e[0] == @shot then flag = true end
      }
      if flag then shot_strategy else @shot end
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
      minim = remains[0]
      remains.each { |e| if e[3] < minim[3] then minim = e end }
      [minim[0], [0,1,2,3].sample, (1..minim[2]).to_a.sample] 
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
  def initialize (player_1, player_2)
    @game_over = false
    @players = [[player_1, BattleField.new, 0], 
                [player_2, BattleField.new, 0]]
    @players.each { |p| reset p }
    @players.shuffle!
  end

  def reset p
    player = p[0]
    puts player.name + " game setup"
    player.reset
    bfield = p[1]
    s = bfield.fleet
    if bfield.place_fleet (player.place_strategy s)
    then puts "Ships placed"
    else raise "Illegal ship placement"
    end
  end

  # Задание 33 start
  def start
    lastshots = []
    while @game_over != true
      pl1 = @players[0]
      pl2 = @players[1]
      pl1[2] += 1
      puts "Step " + pl1[2].to_s + " of player " + pl1[0].name
      pl1[1].cure
      rem = pl1[1].remains
      pl1[1].move(pl1[0].ship_move_strategy rem)
      cord = pl1[0].shot_strategy
      if lastshots.include? cord
      then 
        puts "Illegal shot"
        res = "miss"
      else
        lastshots.push cord
        res = pl2[1].shoot cord
      end
      puts "[" + cord[0].to_s + " , " + cord[1].to_s + "] " + res
      if res == "miss"
      then 
        pl1[0].miss
        @players = [pl2, pl1]
        lastshots = []
      else
        pl1[0].hit res
        @game_over = pl2[1].game_over?
        if @game_over then puts "Player " + pl1[0].name + " wins!" end
      end
    end
  end

end
# конец описания класса Game
################################################################################

################################################################################
# Переустановка датчика случайных чисел
################################################################################
srand
################################################################################

#№ Пример запуска
# p1 = Player.new("Ivan", true)
# p2 = Player.new("Feodor")
# g = Game.new(p1,p2)
# g.start

