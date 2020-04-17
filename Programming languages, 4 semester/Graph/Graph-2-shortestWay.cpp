#include <iostream>
#include <list>
#include <map>
#include <queue>

using namespace std;

class Graph
{
public:
    bool isWeighed;                        // Предикат взвешенности
    bool isOriented;                       // Предикат ориентированности
    int N;                                 // Количество вершин
    int M;                                 // Количество рёбер
    map<int, list<pair<int, double>>> Adj; // Пары ключ/значение через map, то есть список смежности

    Graph()
    { // Конструктор по умолчанию - 0 вершин, 0 рёбер, неориентированный, невзвешенный
        N = 0;
        M = 0;
        isWeighed = false;
        isOriented = false;
    }

    Graph(int n, int m, bool w, bool o)
    { // Конструктор
        N = n;
        M = m;
        isWeighed = w;
        isOriented = o;
    }

    void createAdjList()
    {
        int x, y; // x и y - вершины, w - вес ребра
        double w;
        for (int i = 0; i < M; i++)
        {                            // Считываем каждое ребро
            cin >> x >> y >> w;      // Считываем тройку значений
            if (!isWeighed)          // Если граф невзвешенный
                w = 1.0;             // Присваиваем единицу весу
            auto it_x = Adj.find(x); // Ищем вершину x
            bool fl = true;
            if (it_x != Adj.end())
            { // Если вершина x существует
                for (auto it_y = it_x->second.begin(); it_y != it_x->second.end(); it_y++)
                    if (it_y->first == y)
                    {               // Проверяем, существует ли ребро  x->y
                        fl = false; // Если уже существует
                        break;
                    }
            }
            if (isOriented)
            { // Если граф ориентированный
                if (fl)
                {                                      // Добавляем ребро x->y
                    Adj[x].push_back(make_pair(y, w)); // Добавляем y в список смежности для x
                    if (Adj.find(y) == Adj.end())
                    {                                         // Если вершины y нет, добавляем мнимое ребро y->0
                        Adj[y].push_back(make_pair(0, 0));    // Добавляем 0 в список смежности для y
                        auto it = Adj.find(y);                // Находим y
                        it->second.erase(it->second.begin()); // Удаляем мнимое ребро
                    }
                }
            }
            else if (fl)
            {                                      // Если граф неориентированный
                Adj[x].push_back(make_pair(y, w)); // Добавляем y в список смежности для x
                Adj[y].push_back(make_pair(x, w)); // Добавляем x в список смежности для y
            }
        }
    }

    void printAdj()
    {
        for (auto it = Adj.begin(); it != Adj.end(); it++)
        {
            cout << it->first << " : "; // Вершина, откуда выходит ребро
            if (isWeighed)
            {                                                                          // Если граф взвешенный
                for (auto it_1 = it->second.begin(); it_1 != it->second.end(); it_1++) // Перебираем список смежных вершин
                    cout << "{" << it_1->first << ", " << it_1->second << "};";
            }
            else
            { // Если граф невзвешенный
                for (auto it_1 = it->second.begin(); it_1 != it->second.end(); it_1++)
                    cout << it_1->first << "; ";
            }
            cout << endl;
        }
    }

    // Функция обхода в ширину. На вход подаётся x (вершина, с которой начинать обходы),
    // used (список пар вершина - предикат использования), path (список пути обхода),
    // buf (очередь для работы алгоритма обхода в ширину).
    void breadthFirstSearch(int x, map<int, bool> &used, list<int> &path, queue<int> &buf)
    {
        used[x] = true;    // Отмечаем, что вершина посещена
        path.push_back(x); // Добавляем вершину в список пройденных
        buf.push(x);       // Добавляем вершину в воспомогательную очередь
        while (!buf.empty())
        {                             // Пока очередь не пуста
            int head = buf.front();   // Считываем голову
            buf.pop();                // Удаляем голову
            auto it = Adj.find(head); // Ставим итератор на вершину head
            // Обходим все вершины, смежные с head
            for (auto it_1 = it->second.begin(); it_1 != it->second.end(); it_1++)
                if (!used[it_1->first])
                {                                // Если вершина не посещена
                    used[it_1->first] = true;    // Отмечаем её как посещённую
                    path.push_back(it_1->first); // Добавляем вершину в список пройденных
                    buf.push(it_1->first);       // Добавляем вершину в очередь
                }
        }
    }

    // Оболочка функции обхода в ширину. Введена для объявления
    // списков и очереди для работы функции. Возвращает
    // список порядка обхода вершин. На вход подаётся
    // вершина x, с которой нужно начинать обход.
    list<int> breadthFirstSearchFull(int x)
    {
        map<int, bool> used;                    // Список пар пройденных вершин
        list<int> path;                         // Список порядка обхода вершин
        queue<int> buf;                         // Воспомогательная очередь
        breadthFirstSearch(x, used, path, buf); // Вызываем обход в ширину
        return path;                            // Возвращаем список порядка обхода
    }

    // Модифицированная функция обхода в ширину. Аналогична стандартной функции
    // обхода в ширину, но функция оптимизирована для поиска кратчайшего пути.
    // На вход дополнительно подаётся вершина b - конечная вершина.
    list<int> breadthFirstSearchModifed(int x, map<int, bool> &used, list<int> &path, queue<int> &buf, int b)
    {
        used[x] = true;
        path.push_back(x);
        buf.push(x);
        // Список пар ключ/значение, где на месте ключа - вершина, а значение - её предыдущий  элемент
        map<int, int> previous;
        list<int> way; // Инициализация пути
        while (!buf.empty())
        {
            int head = buf.front();
            buf.pop();
            auto it = Adj.find(head);
            for (auto it_1 = it->second.begin(); it_1 != it->second.end(); it_1++)
                if (!used[it_1->first])
                {
                    used[it_1->first] = true;
                    path.push_back(it_1->first);
                    buf.push(it_1->first);
                    previous[it_1->first] = it->first; // Добавляем вершине предыдущий элемент
                    if (it_1->first == b)
                    {                // Если вершина равна конечной
                        int itb = b; // Инициализируем буферную вершину прохода по пути назад
                        while (!(previous[itb] == NULL))
                        {                        // Пока предыдущая вершина существует
                            way.push_back(itb);  // Добавляем вершину к списку пути
                            itb = previous[itb]; // Переходим к предыдущей вершине
                        }
                        way.push_back(itb); // Добавляем конечную вершину
                    }
                }
        }
        return way; // Возвращаем путь
    }

    // Функция поиска кратчайшего пути. Аналогична оболочке функции обхода в ширину,
    // но используется для поиска кратчайшего пути. На вход подаётся дополнительная
    // переменная b, обозначающая конечную вершину.
    list<int> shortestWaySearch(int a, int b)
    {
        map<int, bool> used;
        list<int> path;
        queue<int> buf;
        // Вызываем модифицированную функцию обхода в ширину
        list<int> way = breadthFirstSearchModifed(a, used, path, buf, b);
        list<int> wayReverse; // Инициализация обратного списка
        // Вносим значения в обратный список
        for (list<int>::iterator it = way.begin(); it != way.end(); ++it)
            wayReverse.push_front(*it);
        // ВАЖНО! Стартовая точка не учитывается для удобства последующего вывода,
        // поэтому её необходимо выводить отдельно
        return wayReverse; // Возвращаем обратный список
    }
};

int main()
{ // Ввод базовых параметров графа
    cout << "Enter number of vertexes and edges: " << endl;
    int nV, nE;
    cin >> nV >> nE;
    cout << "Graph is oriented? (1 = true, 0 = false)" << endl;
    bool oG, wG;
    cin >> oG;
    cout << "Graph is weighed? (1 = true, 0 = false)" << endl;
    cin >> wG;

    // Инициализация графа и ввод вершин
    // ВАЖНО: формат вноса ребёр - x y w для ребра x->y с весом w.
    // Если граф невзвешенный, вес также необходимо указывать, однако
    // в самой программе он учитываться не будет и будет присваиваться
    // значение w = 1.0.
    Graph gr(nV, nE, wG, oG);
    cout << "Enter edges:" << endl;
    gr.createAdjList();

    // Вывод графа
    cout << endl;
    gr.printAdj();

    // Инициализация и ввод вершин
    int a, b;
    cout << "A and B(from A to B):" << endl;
    cin >> a >> b;

    // Вывод кратчайшего пути
    cout << endl
         << "Shortest way:" << endl;
    list<int> way = gr.shortestWaySearch(a, b);
    cout << a; // Выводим начальную точку
    for (list<int>::iterator it = way.begin(); it != way.end(); ++it)
        cout << " -> " << *it;

    return 0;
}