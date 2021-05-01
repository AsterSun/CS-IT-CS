class MyConditioner < Conditioner

end


class MyHeater < Heater

  # Добавляем метод, меняющий длительность такта
  def my_set_tact(inp)
    @tact = inp
  end

end


class MyClimateControl < ClimateControl

  def check_heater

    if @home.temperature < @heater_start # Если температура ниже нормы
      @home.heater.set_on     # включаем первый обогреватель
      # Если же температура ниже нормы на 5 и более градусов,
      if @home.temperature < (@heater_start - 5.0)
        @home.heater2.set_on # то включаем второй обогреватель
      end
    else                    # Если температура выше порога -
      @home.heater.set_off  # выключаем первый обогреватель
      @home.heater2.set_off # выключаем второй обогреватель
    end
  end
end


class MyReporter < Reporter

# Формирование строки с текущим статусом обогревателей
  def heater_status_s
    "heater: " + bool_to_on_off_s(@home.heater.status) +
    " heater2: " + bool_to_on_off_s(@home.heater2.status)
  end

end


class MyWeather < Weather

  def new_cyclon
    MyCyclon.new_cyclon self # запустить метод класса Cyclon для создания циклона,
                             # self передается как параметр 
  end

end

class MyCyclon < Cyclon

  # Добавляем к массиву циклонов два дополнительных
  MyCyclons = Cyclons.clone.push([-2.1, -1.4, -0.7, 0, 0.7, 1.4, 2.1],
                                 [-3.9, -2.6, -1.3, 0, 1.3, 2.6])

  # Создание нового циклона для weather          
  def self.new_cyclon weather
    # Берётся случайный циклон из MyCyclons
    # и на его основе создаётся новый
    MyCyclon.new(MyCyclons.sample, weather)
  end

end

class MyGlasshouse < Glasshouse

  def set_glasshouse
    @conditioner = Conditioner.new self # Прикрепить новый кондиционер
    @heater  = MyHeater.new self        # Прикрепить первый обогреватель
    @heater2 = MyHeater.new self        # Прикрепить второй обогреватель
    @climate_control = MyClimateControl.new(self, 15, 25)
                                        # Прикрепить систему климат-контроля
    @reporter = MyReporter.new self       # Прикрепить метеостацию
    @heater.my_set_tact 0.4             # Изменяем длину такта 1 обогревателя
    @heater2.my_set_tact 0.2            # Изменяем длину такта 2 обогревателя
  end

  # Селектор (getter) второго обогревателя теплицы
  def heater2
    @heater
  end

  def temperature
    super + @heater2.change
  end

end

