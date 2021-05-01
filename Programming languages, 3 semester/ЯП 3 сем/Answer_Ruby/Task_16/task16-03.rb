class MyConditioner < Conditioner

end

class MyHeater < Heater 

  def set_tact new #изменение значения длительности такта обогревателя
    @tact = n
  end

end


class MyClimateControl < ClimateControl

  def check_heater
    @hometemp = @home.temperature

    if @hometemp < @heater_start # если температура ниже нормы
      if @hometemp < @heater_start - 4.0 # если температура 
                                         # ниже нормы на 4 градуса
         @home.heater2.set_on # перевести в режим работы 2 обогреватель
      end
      @home.heater.set_on     # и перевести в режим работы 1 обогреватель
    else                      # если всё в норме - выключить обогреватели
      @home.heater.set_off                # перевести в режим ожидания
      @home.heater2.set_off                # перевести в режим ожидания
    end

  end

end


class MyReporter < Reporter
  # фиксация статуса первого и второго обогревателя
  def heater_status_s
    "heater: " + bool_to_on_off_s(@home.heater.status) +
    " heater2: " + bool_to_on_off_s(@home.heater2.status)
  end

end


class MyWeather < Weather

  # добавляем свой MyCycLon
  def new_cyclon
    MyCyclon.new_cyclon self 
  end

end

class MyCyclon < Cyclon
  # добавляем 1 дополнительный циклон
  MyCyclons = Cyclons.clone.push([-2.8, -2.1, -1.4, -0.7, 0, 0.7, 1.4, 2.1])

  def self.new_cyclon weather
    # берется случайный представитель списка MyCyclons 
    # и с ним создается новый циклон
    MyCyclon.new(MyCyclons.sample, weather)
  end

end

class MyGlasshouse < Glasshouse

  def set_glasshouse
    @conditioner = Conditioner.new self # прикрепить новый кондиционер
    @heater = MyHeater.new self           # прикрепить новый обогреватель
    @heater2 = MyHeater.new self          # прикрепить новый обогреватель
    @climate_control = MyClimateControl.new(self, 15, 25)
                                        # прикрепить систему климат-контроля
    @reporter = MyReporter.new self       # прикрепить метеостацию

    @heater.set_tact 0.4 # изменяем такт 1 обогревателя
    @heater2.set_tact 0.2 # изменяем такт 2 обогревателя
  end

  # селектор (getter) 1 обогревателя теплицы
  def heater
    @heater
  end

  # селектор (getter) 2 обогревателя теплицы
  def heater2
    @heater2
  end

  def temperature
    super + @heater2.change # учёт нагрева 2 обогревателя
  end

end

