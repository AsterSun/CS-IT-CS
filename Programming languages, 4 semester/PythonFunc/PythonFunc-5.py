# Функция, определяющая число делителей у числа
def numOfDividers(x):
    countOfDividers = 0 # Счётчик числа делителей
    iterator = 0 # Итератор
    while iterator < x / 2: # Для чисел от 1 до x/2
        iterator += 1
        if x % iterator == 0: # Если x делится на это число
            countOfDividers += 1 # Увеличиваем счётчик
    if x > 1: # Если число больше 1 - увеличиваем счётчик на 1
        # Делаем это потому, что мы проходим только первую половину чисел,
        # а делителем самого числа всегда является ещё и само число
        countOfDividers += 1
    return countOfDividers # Возвращаем число делителей

A = 1  # Начало диапазона
B = 15 # Конец диапазона

maximum = 0 # Максимальное число делителей
i = A # Ставим итератор на начало диапазона
while i < B + 1: # Для всех чисел диапазона
    if numOfDividers(i) > maximum: # Если число делителей больше максимального
        maximum = numOfDividers(i) # Сохраняем новое максимальное число делителей
    i += 1 # Увеличиваем итератор
sumOfMax = 0 # Сумма чисел с максимальным числом делителей
i = A  # Ставим итератор на начало диапазона
while i < B + 1:  # Для всех чисел диапазона
    if numOfDividers(i) == maximum: # Если число делителей равно максимальному
        sumOfMax += i # Добавляем число к сумме
    i += 1 # Увеличиваем итератор
print('Sum of numbers having the maximum number of divisors - ', sumOfMax) # Вывод
