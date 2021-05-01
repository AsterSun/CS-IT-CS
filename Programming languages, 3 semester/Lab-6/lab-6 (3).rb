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
    map.each_with_index { |el, i| el + b[i]}
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
    @field = Array.new (FieldSize) { Array.new(FieldSize) }
  end
end

  # Задание 3 size (метод класса)
class Field
  def self.size
    FieldSize
  end
end

  # Задание 4 set!(n, x, y, hor, ship)
class Field
  def set!(n, x, y, hor, ship)
    if (hor == false)
    then @field.each_index { |j| if j >= y and j <= y + n - 1
                                 then @field[x][j] = ship
                                 end }
    else @field.each_index { |i| if i >= x and i <= x + n - 1
                                 then @field[i][y] = ship
                                 end}
    end
    return nil
  end
end

  # Задание 5 print_field
class Field
  def print_field
    print "+"
    print "-" * FieldSize
    puts "+"
    @field.each_index { |i| print "|"
                            @field.each_index { |j| if @field[i][j] == nil
                                                    then print " "
                                                    else print @field[i][j]
                                                    end }
                            puts "|" }
    print "+"
    print "-" * FieldSize
    puts "+"
  end
end 

  # Задание 6 free_space?(n, x, y, hor, ship)
class Field
  def free_space?(n, x, y, hor, ship)
    if hor == true
    then if x < 0 or 
            (x + n - 1) > (FieldSize - 1) or
            y < 0 or y > (FieldSize - 1)
         then return false
         end
    else 
         if y < 0 or 
            (y + n - 1) > (FieldSize - 1) or
            x < 0 or x > (FieldSize - 1)
         then return false
         end
    end
    if x == 0 then xi = 0 else xi = 1
    end
    if y == 0 then yi = 0 else yi = 1
    end
    if hor == true
    then
         if x + n - 1 == 9 then xj = 0 else xj = 1
         end
         if y == 9 then yj = 0 else yj = 1
         end
         ((x - xi)..(x + n - 1 + xj)).each { |i| 
                                             ((y - yi)..(y + yj)).each { |j|
                                             if !@field[i][j].nil? and
                                                @field[i][j] != ship
                                             then return false
                                             end }}
    else
         if y + n - 1 == 9 then yj = 0 else yj = 1
         end
         if x == 9 then xj = 0 else xj = 1
         end
         ((x - xi)..(x + xj)).each { |i| 
                                     ((y - yi)..(y + n - 1 + yj)).each { |j|
                                     if !@field[i][j].nil? and
                                        @field[i][j] != ship
                                     then return false
                                     end }}
    end
    return true
  end
end

# конец описания класса Field
################################################################################


################################################################################
# Задания 7-16 
# Класс Ship
################################################################################
class Ship
  def initialize(field, len)
    @len = len
    @myfield = field
    @maxhealth = 100 * @len
    @minhealth = 30 * @len
    @health = @maxhealth
  end
  attr_reader :len
  attr_reader :coord
end

  # Задание 8 to_s
class Ship
  def to_s
    return 'X'
  end
end

  # Задание 9 clear
class Ship
  def clear
    @myfield.set!(@len, @coord[0], @coord[1], @hor, nil)
  end
end

  # Задание 10 set!(x, y, hor)
class Ship
  def set!(x, y, hor)
    if @myfield.free_space?(@len, x, y, hor, self) == false then return false
    else
        if @coord then clear end
    end
    @myfield.set!(@len, x, y, hor, self)
    @coord = []
    @coord.push (x)
    @coord.push (y)
    if (hor == true)
    then @coord.push (x + @len - 1)
         @coord.push (y)
    else @coord.push (x)
         @coord.push (y + @len - 1)
    end
    @hor = hor
    return true
  end
end

  # Задание 11 kill
class Ship
  def kill
    clear
    @coord = nil
  end
end

  # Задание 12 explode
class Ship
  def explode
    @health -= 70
    if @health <= @minhealth
      kill
      @len
    else
      nil
    end
  end
end

  # Задание 13 cure
class Ship
  def cure
    if @health + 30 < @maxhealth
    then @health += 30
    else @health = @maxhealth
    end
  end
end

  # Задание 14 health
class Ship
  def health
    ((@health * 100.0) / @maxhealth).round(2)
  end
end

  # Задание 15 move(forward)
class Ship
  def move(forward)
    if @hor == true
    then if forward == true
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
end

  # Задание 16 rotate(n, k)
class Ship
  def rotate(n, k)
    if n.between?(1, @len) and k.between?(1, 3)
    then if k == 1
         then if @hor == true
              then x_start = @coord[0] + n - 1
                   y_start = -n + 1 + @coord[1]
                   x_end = @coord[0] + n - 1
                   y_end = @coord[2] - @coord[0] - n + 1 + @coord[1]
                   if x_start >= x_end and y_start >= y_end
                   then set!(x_end, y_end, false)
                   else set!(x_start, y_start, false)
                   end
              else x_start = @coord[0] + n - 1
                   y_start = @coord[1] + n - 1
                   x_end = -coord[3] + @coord[1] + coord[0] + n - 1
                   y_end = @coord[1] + n - 1
                   if x_start >= x_end and y_start >= y_end
                   then set!(x_end, y_end, true)
                   else set!(x_start, y_start, true)
                   end
              end
         elsif k == 2
         then if @hor == true
              then x_start = @coord[0] + 2 * n - 2
                   y_start = @coord[1]
                   x_end = -@coord[2] + 2 * @coord[0] + 2 * n - 2
                   y_end = @coord[1]
                   if x_start >= x_end and y_start >= y_end
                   then set!(x_end, y_end, true)
                   else set!(x_start, y_start, true)
                   end
              else x_start = @coord[0]
                   y_start = coord[1] + 2 * n - 2
                   x_end = @coord[0]
                   y_end = -@coord[3] + 2 * @coord[1] + 2 * n - 2
                   if x_start >= x_end and y_start >= y_end
                   then set!(x_end, y_end, false)
                   else set!(x_start, y_start, false)
                   end
              end
         elsif k == 3
         then if @hor == true
              then x_start = @coord[0] + n - 1
                   y_start = @coord[1] + n - 1
                   x_end = @coord[0] + n - 1
                   y_end = -@coord[2] + @coord[0] + n - 1 + @coord[1]
                   if x_start >= x_end and y_start >= y_end
                   then set!(x_end, y_end, false)
                   else set!(x_start, y_start, false)
                   end
              else x_start = @coord[0] - n + 1
                   y_start = @coord[1] + n - 1
                   x_end = @coord[3] - @coord[1] + @coord[0] - n + 1
                   y_end = @coord[1] + n - 1
                   if x_start >= x_end and y_start >= y_end
                   then set!(x_end, y_end, true)
                   else set!(x_start, y_start, true)
                   end
              end
         end
    else return false
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
  Ships = [4, 3, 3, 2, 2, 2, 1, 1, 1, 1]
  def initialize
    super
    newships
  end
  def newships
    @allships = Ships.map { |i| Ship.new(self, i) }
  end

  # Задание 18 fleet
  def fleet
    @allships.each_with_index.map { |ship, i| [i, ship.len] }
  end

  # Задание 19 place_fleet pos_list
  def place_fleet pos_list
    flag = true
    pos_list.each { |i| if @allships[i[0]].set!(i[1], i[2], i[3]) and flag
                        then flag = true
                        else flag = false
                        end }
    if flag
    then @allships.each { |i| if !i.coord
                              then flag = false
                              end }
    end
    if flag == false
    then @allships.each { |i| if i.coord
                              then i.kill
                              end }
    end
    return flag
  end

  # Задание 20 remains
  def remains
    @allships.map.each_with_index { |el, i| [i, el.coord, el.len, el.health] }
  end

  # Задание 21 refresh
  def refresh
    @allships = @field.reduce(:|).find_all { |el| el }
  end

  # Задание 22 shoot c
  def shoot c
    el = @field[c[0]][c[1]]
    if el
    then 
         n = el.explode
         if n
         then refresh
              "killed " + n.to_s
         else "wounded"
         end
    else "miss"
    end
  end

  # Задание 23 cure
  def cure
    @allships.map { |el| el.cure }
  end

  # Задание 24 game_over?
  def game_over?
    @allships.empty?
  end

  # Задание 25 move l_move
  def move l_move
    if l_move[1].between?(1, 3)
    then @allships[l_move[0]].rotate(l_move[2], l_move[1])
    else
        if l_move[2] == 1
        then @allships[l_move[0]].move(true)
        else @allships[l_move[0]].move(false)
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
    [rand(Field::FieldSize), rand(Field::FieldSize)]
  end

  # Задание 28 place_strategy ship_list
  def place_strategy ship_list
    f = Field.new
    copy_ship_list = ship_list.sort { |el_1, el_2| el_2[1] <=> el_1[1] }
    place = []
    copy_ship_list.each { |i| s = Ship.new(f, i[1])
                              coord = random_point
                              hor = [true, false].sample
                              while !s.set!(coord[0], coord[1], hor)
                                coord = random_point
                                hor = [true, false].sample
                              end
                              place.push([i[0], coord[0], coord[1], hor]) }
    place
  end

  # Задание 29 hit message
  def hit message
    @lastshots.push([@shot, message])
  end
  #            miss
  def miss
    @lastshots.push([@shot, "miss"])
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
        last_size_shot = @lastshots.size - 1
        if @lastshots.empty? or @lastshots[last_size_shot][1] != "wounded"
        then @shot = random_point
        else
            if @lastshots[last_size_shot][1] == "wounded" and
               (last_size_shot == 0 or 
               @lastshots[last_size_shot - 1][1] != "wounded")
            then 
                 @lastsample = [[0, 1], [0, -1], [1, 0], [-1, 0]].sample
                 @shot = @shot.add(@lastsample)
            else
                if @lastshots[last_size_shot][1] == "wounded" and
                   @lastshots[last_size_shot - 1][1] == "wounded"
                then @shot = @shot.add(@lastsample)
                end
            end
            if !@shot[0].between?(0, Field::FieldSize - 1) or
               !@shot[1].between?(0, Field::FieldSize - 1)
            then @lastsample = [-@lastsample[0], -@lastsample[1]]
                 @shot = @lastshots[last_size_shot][0].add(@lastsample)
            end
        end
        if @lastshots.any? { |i| i[0] == @shot }
        then shot_strategy
        else @shot
        end
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
        copy_remains = remains.sort { |el_1, el_2| el_1[3] <=> el_2[3] }
        [copy_remains[0][0], rand(4), rand(copy_remains[0][2]) + 1]
      # конец решения задания 31
    end
  end 

end
# конец описания класса Player
################################################################################

################################################################################
# Задания 32-33 
# Класс Game
class Game
  def initialize(player_1, player_2)
    @game_over = false
    @players = [[player_1, BattleField.new, 0], [player_2, BattleField.new, 0]]
    @players = @players.each { |el| reset el }
    @players = @players.shuffle
  end
  def reset p
    puts p[0].name + " game setup"
    p[0].reset
    battle_ships = p[1].fleet
    place_str = p[0].place_strategy(battle_ships)
    bfield = p[1].place_fleet(place_str)
    if bfield
    then puts "Ships placed"
    else raise "Illegal ship placement"
    end
  end

################################################################################

  # Задание 33 start
  def start
    lastshots = []
    while !@game_over
      @players[0][2] += 1
      puts "Step " + @players[0][2].to_s + " of player " + @players[0][0].name
      @players[0][1].cure
      remain = @players[0][1].remains
      place = @players[0][0].ship_move_strategy(remain)
      @players[0][1].move place
      shot_str = @players[0][0].shot_strategy
      res = "miss"
      if lastshots.any? { |i| i[0] == shot_str }
      then puts "Illegal shot"
      else res = @players[1][1].shoot shot_str
      end
      lastshots.push shot_str
      puts "[" + shot_str[0].to_s + ", " + shot_str[1].to_s + "] " + res
      if res == "miss"
      then @players[0][0].miss
           @players = @players.reverse
           lastshots = []
      else @players[0][0].hit res
           @game_over = @players[1][1].game_over?
           if @game_over == true
           then puts "Player " + @players[0][0].name + " wins"
           end
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
 p1 = Player.new("Ivan",false)
 p2 = Player.new("Feodor", false)
 g = Game.new(p1,p2)
 g.start

