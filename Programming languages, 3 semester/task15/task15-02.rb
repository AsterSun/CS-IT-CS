class CashMachine
  def initialize (n)  # инициализация банкомата
    @cassete_in = {}  # объявление кассет для приёма
    @cassete_out = {} # объявление кассет для выдачи
    @max_out = n      # установка максимальной суммы выдачи
    # добавление кассет для приёма
    Banknotes.each { |rate| @cassete_in[rate] = 0 }
    # добавление кассет для выдачи
    Banknotes.each { |rate| @cassete_out[rate] = 0 }
  end

  CasseteCapacity = 10                 # объём кассет
  # Доступные номиналы банкнот. Для корректной работы
  # withdraw необходимо либо передавать их в порядке
  # убывания, либо применять сортировку в withdraw
  # перед использованием
  Banknotes = [5000, 2000, 1000, 500, 100, 50]

  def load # заполнение банкомата
    # Для каждого номинала банкнот заполняем кассету для выдачи на
    # максимальный объём, то есть заполняем до CasseteCapacity.
    # Возвращаем заполненный банкомат.
    Banknotes.each { |i| @cassete_out[i] = CasseteCapacity } 
    self
  end

  def empty # опустошение банкомата
    # Для каждого номинала банкнот опустошаем кассету для приёма,
    # то есть приравниваемзначение к нулю.
    # Возвращаем опустошённый банкомат.
    Banknotes.each { |i| @cassete_in[i] = 0 }
    self
  end

  def new_max n  # максимально возможная сумма для снятия
    @max_out = n # устанавливаем новую максимальную сумму
    self         # возвращаем банкомат
  end

  def deposit hs      # внесение наличных
    not_accepted = {} # хэш непринятых купюр (номинал => кол-во непринятых)
    cash_accepted = 0 # сумма внесённых купюр
    # Для каждого номинала повторяем:
    hs.keys.each do |rate|
    # Если при внесении банкомат не переполняется, то просто
    # присваиваем новое значение количества купюр и увеличиваем
    # сумму внесённых денег
      if @cassete_in[rate]
        if  hs[rate] + @cassete_in[rate] <= CasseteCapacity
          @cassete_in[rate] += hs[rate]
          cash_accepted += hs[rate] * rate
    # Если же банкомат переполняется, то вычисляем и сохраняем количество 
    # непринятых купюр, устанавливаем максимально возможное количество
    # купюр в кассете, а к принятой сумме прибавляем сумму тех купюр,
    # которые банкомат принял
        else
          not_accepted[rate] = hs[rate] + @cassete_in[rate] - CasseteCapacity
          @cassete_in[rate] = CasseteCapacity
          cash_accepted += (hs[rate] - not_accepted[rate]) * rate
        end
      else
        not_accepted[rate] = hs[rate]
      end
    end
    # Выводим массив - сумма принятых купюр и хэш непринятых
    [cash_accepted, not_accepted]
  end

  def withdrawgreedy s # выдача наличных
    # Сортируем на случай некорректной передачи банкнот
    sort_banknotes = Banknotes.sort.reverse
    sres = s     # переменная для временного хранения суммы
    divint = 0   # целый делитель
    mhash = {}   # хэш выдаваемых купюр
    # В первую очередь проверяем, не превышает ли
    # сумма максимально заданную
    if s <= @max_out then
      # Далее для каждого номинала запускаем цикл.
      # Так как массив номиналов отсортирован по убыванию,
      # то цикл начинается с наибольших купюр, то есть
      # сначала вычитает наибольшие номиналы до тех пор,
      # пока сумма остатка не станет меньше номинала купюры
      # либо купюры данного номинала в банкомате закончатся.
      sort_banknotes.each do |rate|
        # Вычисляем наибольший целый делитель sres
        divint = (sres / rate).round
        # Если он не равен нулю, то есть как минимум
        # 1 купюру возможно выдать, то
        if (divint != 0) then
          # Если целый делитель меньше либо равен
          # количеству купюр в банкомате, то
          # вычитаем из нужной суммы выданную сумму
          if divint <= @cassete_out[rate] then
            sres -= rate * divint
            mhash[rate] = divint
          # В противном случае вычитаем из нужной суммы
          # сумму всех купюр банкомата заданного номинала
          else
            sres -= rate * @cassete_out[rate]
            mhash[rate] = @cassete_out[rate]
          end
        end
      end
      # Если вся необходимая сумма может быть выдана
      if sres == 0 then
        # то вычитаем из банкомата выданные купюры,
        # использую ранее сохранённый хэш.
        # В противном случае деньги не вычитаем,
        # в результат выдаём nil
        mhash.each_key { |key|
        @cassete_out[key] -= mhash[key] }
        mhash
      else nil
      end
    else nil
    end
  end

  def withdraw s
    mhash = {}
    num_of_nom = Banknotes.length - 1
    num_of_banks = num_of_nom * CasseteCapacity
    hmb = [0]
    sum = s
    for i in 1..sum do
      hmb[i] = num_of_banks
      for j in 0..num_of_nom do
        if (i >= Banknotes[j] && hmb[i - Banknotes[j]] + 1 < hmb[i])
          hmb[i] = hmb[i - Banknotes[j]] + 1
        end
      end
    end
    if (hmb[sum] ==  num_of_banks)
      nil
    else
      while sum > 0 do
        for i in 1..num_of_nom do
          if (hmb[sum - Banknotes[i]] == hmb[sum] - 1)
            if (mhash[i] == nil)
              mhash[i] = Banknotes[i]
              sum = sum - Banknotes[i]
            else
               mhash[i] = mhash[i] + Banknotes[i]
               sum = sum - Banknotes[i]
            end
          end
        end
      end
    end
  end

  def status  # определение состояния банкомата
    cash_to_out = 0 # сумма для выдачи
    cash_input = 0  # сумма для снятия
    # Для каждого номинала купюр вычисляем сумму денег как в кассете
    # для выдачи, так и в кассете для приёма.
    Banknotes.each do |rate|
      cash_to_out += @cassete_out[rate] * rate
      cash_input += @cassete_in[rate] * rate
    end
    # Выводим результат. Хэш купюр хранится в переменных cassete_in и
    # cassete_out, которые мы задали ещё при инициализации.
    [cash_to_out, @cassete_out, cash_input, @cassete_in]
  end

end

##
## ПРИМЕР ВЫЗОВА
##
# Создаём новый банкомат с лимитом выдачи 10000
