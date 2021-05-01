class MusicMachine
  def initialize(hs = {})
    @track_count = 0  # количество треков в машине
    @tracks = {}      # хеш треков
    @play_queue = []  # очередь наименований треков для проигрывания
    # инициализация множества треков
    hs.keys.each { |key| add_track(key, hs[key]) } 
  end

  MaxTrackCount = 15

  def play names
    names.each do |name| 
      if @tracks[name]          # если есть в базе трек с наименованием
        @play_queue.push(name)  # то его можно проиграть
      end 
    end
    self
  end

  def pass
    @play_queue.shift
    self
  end

  def count_time_to_play
    # суммируем в аккумулятор все длительности треков в очереди 
    @play_queue.inject(0) { |acc, name| acc + @tracks[name] }
  end

  def add_track(name, time)
    # если максимальное количество треков не превышено
    # и трек с таким названием отсутствует в базе
    if @track_count < MaxTrackCount and not @tracks[name] 
        @tracks[name] = time   # добавляем трек в хеш
        @track_count += 1
    end
    self
  end

  def empty
    @track_count = 0
    @tracks = {}
    @play_queue = []
    self
  end
end

##
##    ПРИМЕР ВЫЗОВА
##
# Создаем новый автомат с тремя треками
a = MusicMachine.new({"my 1" => 17.6, "my 2" => 13, "my 3" => 25})
# Добавляем еще два трека, после чего заказываем проиграть два 
a.add_track("new 1", 11).add_track("new 2", 7).play(["new 2", "my 1"])
# Заказываем еще один
a.play(["new 1"])
# Просим показать, сколько времени осталось до конца проигрывания
puts a.count_time_to_play
# Заказываем еще три (из которых два не существуют)
a.play(["new 3", "new 4", "my 1", "my 3"])
# Просим показать, сколько времени осталось до конца проигрывания
puts a.count_time_to_play
# Пропустим один трек
a.pass
puts a.count_time_to_play
a.pass
puts a.count_time_to_play
# Очистим автомат, после чего загрузим в него два трека
# и попросим проиграть два
a.empty.add_track("new 1", 11).add_track("new 2", 7).play(["new 2", "my 1"])
puts a.count_time_to_play




class CashMachine
  def initialize(n)
    @case_give = {} #кассета для выдачи
    @case_take = {} #кассета для приёма
    @max_give_cash = n
    Banknotes.each { |i| @case_give[i] = 0 } 
    Banknotes.each { |i| @case_take[i] = 0 }
  end

  Banknotes = [50, 100, 200, 
               500, 1000, 2000, 5000]
  MaxCount = 15

  def load
    Banknotes.each { |i| @case_give[i] = @max_give_cash }
    self
  end

  def empty
    Banknotes.each { |i| @case_take[i] = 0 }
    self
  end

  def new_max n
    @max_give_cash = n
    self
  end

  def deposit hs
    negate = {}
    sum = 0
    hs.keys.each do |name|
      if @case_take [name]
        if hs[name] + @case_take[name] <= MaxCount
          @case_take[name] += hs[name]
          sum += hs[name] * name
        else 
          negate[name] = hs[name] + @case_take[name] - MaxCount
          @case_take[name] = MaxCount
          sum += (hs[name] - negate[name]) * name
        end
        negate[name] = hs[name]
      end
    end
    write = [sum, negate]
  end



end