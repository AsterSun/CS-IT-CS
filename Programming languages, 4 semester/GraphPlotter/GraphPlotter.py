# ПРОГРАММА ДЛЯ ПОСТРОЕНИЯ ГРАФИКОВ
# У программы 3 режима работы:
# 1) Построение графика по введённой функции (кнопка Plot)
# 2) Построение графика по точкам из файла (Plot from file)
# 3) Построение графика по функции из выпадающего списка (Plot from optionmenu)
# Для первого и третьего режима работы необходимо указать диапазон значений x,
# по которому будет построен график функции. (from startX to endX)
# Для второго режима работы необходим определённый формат файла - файл с
# форматом txt, точки передаются внутри файла по 1 точке в строке, на первом месте
# x, на втором - y. Например, график по точкам (1, 2), (2, 5) нужно передавать так:
# 1.0 2.0
# 2.0 5.0
# Все виджеты привязаны к центру окна (anchor="c") и указано их не абсолютное, 
# а относительное местоположение, которое будет меняться в зависимости
# от размеров окна, которое можно менять.
import matplotlib                    # Импортируем необходимые библиотеки
import matplotlib.pyplot as plt      # matplotlib - для построения графиков
import tkinter as tk                 # tkinter - для работы с GUI
from tkinter import filedialog as fd # numpy - для построения списков
import numpy as np                   # numexpr - для преобразования введённых выражений
import numexpr as ne                 # из строк в сами выражения

class GraphPlotter(tk.Frame): # Главный класс приложения
    def __init__(self, master=None): # Функция инициализации
        tk.Frame.__init__(self, master)
        self.createWidgets()

    def createWidgets(self): # Функция создания виджетов
        fig = plt.figure() # Создаём главную область графика
        ax = fig.add_subplot(111) # Добавляем график
        ax.set_xlabel('XAxis') # Подписываем ось x
        ax.set_ylabel('YAxis') # Подписываем ось y
        canvas = FigureCanvasTkAgg(fig, master=root) # Добавляем график в окно
        canvas.get_tk_widget().place(relx=.5, rely=.3, anchor="c") # Размещаем график
        canvas.draw() # Отрисовываем график
        
        # message box + label для выражений
        mExp = StringVar()
        message_entry = Entry(textvariable=mExp)
        message_entry.place(relx=.2, rely=.7, anchor="c")
        lExp = Label(text="Expression", font="Arial 12")
        lExp.place(relx=.2, rely=.65, anchor="c")

        # message box + label для начального x
        mStartX = StringVar()
        message_entry = Entry(textvariable=mStartX)
        message_entry.place(relx=.5, rely=.7, anchor="c")
        lStartX = Label(text="X from", font="Arial 12")
        lStartX.place(relx=.5, rely=.65, anchor="c")

        # message box + label для конечного x
        mEndX = StringVar()
        message_entry = Entry(textvariable=mEndX)
        message_entry.place(relx=.5, rely=.8, anchor="c")
        lEndX = Label(text="to", font="Arial 12")
        lEndX.place(relx=.5, rely=.75, anchor="c")

        # Список функций для выпадающего списка
        FUNCTIONS = [
            "sin(x)",
            "x**2",
            "sqrt(x)",
            "x**3"
        ]

        # Выпадающий список
        selected = StringVar(value='sin(x)') # Начальное значение списка
        self.op = OptionMenu(root, selected, *FUNCTIONS)
        self.op.place(relx=.8, rely=.7, anchor="c")

        # Кнопка построения графика по функции из выпадающего списка
        self.plotFromOptionButton = tk.Button(
            master=root, text="Plot from optionmenu", command=lambda: self.plot(canvas, ax, selected, mStartX, mEndX))
        self.plotFromOptionButton.place(relx=.8, rely=.9, anchor="c")

        # Кнопка построения графика по введённой функции
        self.plotButton = tk.Button(master=root, text="Plot", command=lambda: self.plot(
            canvas, ax, mExp, mStartX, mEndX))
        self.plotButton.place(relx=.2, rely=.9, anchor="c")

        # Кнопка построения графика по точкам из файла
        self.plotFromFileButton = tk.Button(
            master=root, text="Plot from file", command=lambda: self.plotFromFile(canvas, ax))
        self.plotFromFileButton.place(relx=.5, rely=.9, anchor="c")

    # Функция построения графика
    def plot(self, canvas, ax, mExp, mStartX, mEndX):
        # Переменная lag - это "шаг" графика, то есть расстояние между
        # двумя ближайшими подсчитанными и построенными точками
        # Сделан так, чтобы на графике было ровно 100 таких точек
        lag = (int(str(mEndX.get())) - int(str(mStartX.get())))/100
        # Список значений x. От стартового значения x до конечного
        # c шагом lag
        x = np.arange(int(str(mStartX.get())), int(str(mEndX.get())), lag)
        # Список значений y. Считается при помощи извлечённой формулы для
        # каждого значения x
        y = ne.evaluate(str(mExp.get()))
        ax.set_title(mExp.get())  # Даём графику название введённой функции
        ax.set_xlabel('XAxis')    # Подписываем ось x
        ax.set_ylabel('YAxis')    # Подписываем ось y
        ax.plot(x, y)             # Считаем график
        canvas.draw()             # Отрисовываем график
        # Очищаем график, но так как он уже отрисован, то он не исчезнет с экрана
        ax.clear()

    # Функция построения графика по точкам
    def plotFromFile(self, canvas, ax):
        x = [] # Пустой список x
        y = [] # Пустой список y
        # Вызываем диалоговое окно открытия файла
        fileName = fd.askopenfilename()
        # Считываем файл и разделяем его на список строк, в каждой
        # из которых лежат значения только одной точки
        with open(fileName, 'r') as f:
            points = f.read().splitlines()
        # Для каждой строки, содержащей координаты точки
        for point in points:
            buf = point.split()     # Делим строку на 2 по пробелу
            x.append(float(buf[0])) # К списку x добавляем абсциссу
            y.append(float(buf[1])) # К списку y добавляем ординату
        ax.set_xlabel('XAxis') # Подписываем ось x
        ax.set_ylabel('YAxis') # Подписываем ось y
        ax.plot(x, y)          # Считаем график
        canvas.draw()          # Отрисовываем график
        # Очищаем график, но так как он уже отрисован, то он не исчезнет с экрана
        ax.clear()

root = tk.Tk() # Создаём окно программы
root.title("Graph plotter") # Меняем название окна
root.geometry("500x500")    # Меняем размеры окна
app = GraphPlotter(master=root) # Запускаем главный класс
app.mainloop() # "Зацикливаем" приложение