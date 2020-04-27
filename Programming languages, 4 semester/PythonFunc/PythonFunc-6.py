# Функция подсчёта суммы цифр
def sumOfDigits(x):
    sum = 0 # Сумма цифр
    while x > 0: # Пока больше нуля
        sum += x % 10 # Добавляем последнюю цифру к сумме
        x //= 10 # Отсекаем последнюю цифру от числа
    return sum # Возвращаем сумму

input = 121 # Входное число
sumOfInput = sumOfDigits(input) # Сумма цифр входного числа
iterator = input + 1 # Ставим итератор на следующее число
status = 0 # Флаг статуса
while status == 0: # Пока флаг не менялся
    if sumOfDigits(iterator) == sumOfInput: # Если суммы цифр входного и текущего числа равны
        status = 1 # Меняем флаг
        print('Next number with the same sum of digits - ', iterator) # Выводим число
    iterator += 1 # Увеличиваем итератор