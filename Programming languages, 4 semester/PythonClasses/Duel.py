# ДУЭЛЬ
# Для начала боя необходимо выбрать двух персонажей и нажать на
# кнопку "Choose heroes". Будут отображены характеристики персонажей.
# Затем для проведения боя нужно нажать на кнопку "Fight". За бой каждый
# персонаж бьёт 1 раз. Таким образом, чтобы выявить победителя, нужно нажимать
# на эту кнопку до тех пор, пока статус одного из героев не станет "DEAD".

import tkinter as tk
from tkinter import *

# Основной класс - окно игры
class Game(tk.Frame):

    # Инициализация игры
    def __init__(self, master=None):
        tk.Frame.__init__(self, master)
        self.createWidgets()

    # Функция отрисовки виджетов
    def createWidgets(self):

        # Кнопка выбора героя
        self.chooseButton = tk.Button(
            master=root, text="Choose heroes", command=lambda: choose_heroes(self))
        self.chooseButton.place(relx=.5, rely=.1, anchor="c")

        # Кнопка сражения
        self.AttackButton = tk.Button(
            master=root, text="Fight", command=lambda: fight(self))
        self.AttackButton.place(relx=.5, rely=.85, anchor="c")

        # Список классов
        SPECS = [
            "warrior",
            "thief",
            "wizard"
        ]

        # Список рас
        RACES = [
            "orc",
            "human",
            "elf"
        ]

        # Инициализация выпадающих списков класса и расы героев
        selSpec1 = StringVar(value='warrior')
        self.opSpec1 = OptionMenu(root, selSpec1, *SPECS)
        self.opSpec1.place(relx=.2, rely=.1, anchor="c")

        selSpec2 = StringVar(value='wizard')
        self.opSpec2 = OptionMenu(root, selSpec2, *SPECS)
        self.opSpec2.place(relx=.8, rely=.1, anchor="c")

        selRace1 = StringVar(value='orc')
        self.opRace1 = OptionMenu(root, selRace1, *RACES)
        self.opRace1.place(relx=.2, rely=.3, anchor="c")

        selRace2 = StringVar(value='human')
        self.opSpec2 = OptionMenu(root, selRace2, *RACES)
        self.opSpec2.place(relx=.8, rely=.3, anchor="c")

        # Значения левого и правого героев по умлочанию
        heroleft = Hero("warrior", "orc")
        heroright = Hero("wizard", "human")

        # Инициализация характеристик героев
        labelStrength = Label(text="STRENGTH", font="Arial 12")
        labelStrength.place(relx=.5, rely=.5, anchor="c")
        labelStrengthl = Label(text="0", font="Arial 12")
        labelStrengthl.place(relx=.3, rely=.5, anchor="c")
        labelStrengthr = Label(text="0", font="Arial 12")
        labelStrengthr.place(relx=.7, rely=.5, anchor="c")

        labelAgility = Label(text="AGILITY", font="Arial 12")
        labelAgility.place(relx=.5, rely=.55, anchor="c")
        labelAgilityl = Label(text="0", font="Arial 12")
        labelAgilityl.place(relx=.3, rely=.55, anchor="c")
        labelAgilityr = Label(text="0", font="Arial 12")
        labelAgilityr.place(relx=.7, rely=.55, anchor="c")

        labelMagic = Label(text="MAGIC", font="Arial 12")
        labelMagic.place(relx=.5, rely=.6, anchor="c")
        labelMagicl = Label(text="0", font="Arial 12")
        labelMagicl.place(relx=.3, rely=.6, anchor="c")
        labelMagicr = Label(text="0", font="Arial 12")
        labelMagicr.place(relx=.7, rely=.6, anchor="c")

        labelAttack = Label(text="ATTACK", font="Arial 12")
        labelAttack.place(relx=.5, rely=.65, anchor="c")
        labelAttackl = Label(text="0", font="Arial 12")
        labelAttackl.place(relx=.3, rely=.65, anchor="c")
        labelAttackr = Label(text="0", font="Arial 12")
        labelAttackr.place(relx=.7, rely=.65, anchor="c")

        labelHealth = Label(text="HEALTH", font="Arial 12")
        labelHealth.place(relx=.5, rely=.7, anchor="c")
        labelHealthl = Label(text="0", font="Arial 12")
        labelHealthl.place(relx=.3, rely=.7, anchor="c")
        labelHealthr = Label(text="0", font="Arial 12")
        labelHealthr.place(relx=.7, rely=.7, anchor="c")

        labelArmor = Label(text="ARMOR", font="Arial 12")
        labelArmor.place(relx=.5, rely=.75, anchor="c")
        labelArmorl = Label(text="0", font="Arial 12")
        labelArmorl.place(relx=.3, rely=.75, anchor="c")
        labelArmorr = Label(text="0", font="Arial 12")
        labelArmorr.place(relx=.7, rely=.75, anchor="c")

        labelStatel = Label(text="ALIVE", font="Arial 12")
        labelStatel.place(relx=.3, rely=.85, anchor="c")
        labelStater = Label(text="ALIVE", font="Arial 12")
        labelStater.place(relx=.7, rely=.85, anchor="c")

        # Функция выбора героев
        def choose_heroes(self):
            # Переназначение характеристик героев в соответсвии с выбранными классами/расами
            heroleft.reset(str(selSpec1.get()), str(selRace1.get()))
            heroright.reset(str(selSpec2.get()), str(selRace2.get()))
            # Отрисовка новых характеристик
            labelStrengthl.config(text=heroleft.strength)
            labelStrengthr.config(text=heroright.strength)
            labelAgilityl.config(text=heroleft.agility)
            labelAgilityr.config(text=heroright.agility)
            labelMagicl.config(text=heroleft.magic)
            labelMagicr.config(text=heroright.magic)
            labelAttackl.config(text=heroleft.attack)
            labelAttackr.config(text=heroright.attack)
            labelHealthl.config(text=heroleft.health)
            labelHealthr.config(text=heroright.health)
            labelArmorl.config(text=heroleft.armor)
            labelArmorr.config(text=heroright.armor)
            labelStatel.config(text="ALIVE")
            labelStater.config(text="ALIVE")

        # Функция боя
        def fight(self):
            # Если левый жив, то он атакует правого
            if heroleft.health >= 0:
                heroleft.hit(heroright)
            # Если здоровье правого было больше 0 до удара, то атакует левого
            if heroright.health >= -heroleft.attack:
                heroright.hit(heroleft)
            # Обновление здоровья в окне
            labelHealthl.config(text=heroleft.health)
            labelHealthr.config(text=heroright.health)
            # Обновление состояний в окне
            if heroleft.health < 0:
                labelStatel.config(text="DEAD")
            if heroright.health < 0:
                labelStater.config(text="DEAD")

# Класс героя
class Hero(object):

    # Инициализация
    def __init__(self, spec, race):

        # Базовые показатели характеристик
        self.strength = 10
        self.agility = 10
        self.magic = 10
        self.attack = 100
        self.health = 1000
        self.armor = 10

        # Увеличение характеристик в зависимости от класса
        if spec == "warrior":
            self.strength += 10
        elif spec == "thief":
            self.agility += 10
        elif spec == "wizard":
            self.magic += 10

        # Увеличение характеристик в зависиости от показателей
        self.attack += self.magic * 10
        self.health += self.strength * 100
        self.armor += self.agility

        # Увеличение характеристик в зависимости от расы
        if race == "orc":
            self.health = self.health * 2
        elif race == "elf":
            self.armor = self.armor * 2
        elif race == "human":
            self.attack = self.attack * 2

    # Функция атаки
    def hit(self, opponent):
        # Здоровье оппонента уменьшается на размер показателя атаки атакующего минус броня защищающегося
        opponent.health -= self.attack - opponent.armor

    # Функция реинициализации. Аналогична __init__, однако
    # вызывается в любой момент времени, а не только при 
    # создании экземпляра класса
    def reset(self, spec, race):
        self.strength = 10
        self.agility = 10
        self.magic = 10
        self.attack = 100
        self.health = 1000
        self.armor = 10

        if spec == "warrior":
            self.strength += 10
        elif spec == "thief":
            self.agility += 10
        elif spec == "wizard":
            self.magic += 10

        self.attack += self.magic * 10
        self.health += self.strength * 100
        self.armor += self.agility

        if race == "orc":
            self.health = self.health * 2
        elif race == "elf":
            self.armor = self.armor * 2
        elif race == "human":
            self.attack = self.attack * 2

# Запуск приложения с заданными именем и размерами окна
root = tk.Tk()
app = Game(master=root)
root.geometry("500x500")
root.title("Duel")
app.mainloop()
