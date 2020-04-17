#include <iostream>
#include <list>
#include <map>
#include <vector>

using namespace std;

vector<list<int>> globalPaths; // Глобальный вектор списков компонент связности

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
    // Функция обхода в глубину. На вход подаётся x (вершина, с которой начинать обход),
    // used (список пар вершина - предикат использования), path (список пути обхода).
    void depthFirstSearch(int x, map<int, bool> &used, list<int> &path)
    {
        used[x] = true;        // Отмечаем, что вершина использована
        path.push_back(x);     // Добавляем вершину в список пройденных
        auto it = Adj.find(x); // Ставим итератор на вершину x
        // Обходим все вершины, смежные с x
        for (auto it_1 = it->second.begin(); it_1 != it->second.end(); it_1++)
            if (!used[it_1->first])                        // Если вершина не использованная
                depthFirstSearch(it_1->first, used, path); // Вызываем обход от этой вершины
    }

    // Оболочка функции обхода в глубину. Введена для объявления
    // списков для работы функции и для работы со с глобальным списком
    // использованных вершин. Значения сохраняются в глобальный вектор
    // компонент связности.
    void depthFirstSearchFull(int x, map<int, bool> &globalUsed)
    {
        map<int, bool> used;             // Список пар использованных вершин
        list<int> path;                  // Список состава конкретной компоненты связности
        depthFirstSearch(x, used, path); // Вызываем фунцию обхода в глубину
        globalPaths.push_back(path);     // Добавляем компоненту связности в вектор
        // Проходим локальный список использованных вершин.
        // Если вершина использована локально, то в глобальном списке
        // также отмечаем, что она использована.
        for (auto it = used.begin(); it != used.end(); ++it)
        {
            if (used[it->first])
                globalUsed[it->first] = true;
        }
        // Проходим глобальный список использованных вершин.
        // Если вершина не использована, вызываем обход в глубину
        // от этой вершины.
        for (auto it = globalUsed.begin(); it != globalUsed.end(); ++it)
        {
            if (!(globalUsed[it->first]))
                depthFirstSearchFull(it->first, globalUsed);
        }
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

    // Инициализация и ввод точки входа
    int dfs;
    cout << "Enter DFS starter point:" << endl;
    cin >> dfs;

    // Объявляем глобальный список использованных вершин.
    // Берём список всех вершин из списка смежности и
    // присваем каждому значению ноль.
    map<int, bool> globalUsed;
    for (auto it = gr.Adj.begin(); it != gr.Adj.end(); ++it)
    {
        globalUsed[it->first] = false;
    }

    // Вызываем функцию обхода в глубину
    gr.depthFirstSearchFull(dfs, globalUsed);

    // Вывод компонент связности
    cout << "Connected components:";
    int nmb = 0; // Счётчик количества компонент связности
    for (list<int> itrList : globalPaths)
    {
        cout << endl;
        nmb++;
        for (list<int>::iterator it = itrList.begin(); it != itrList.end(); ++it)
            cout << *it << " ";
    }

    if (nmb == 1) // Если компонента связности одна
        cout << endl
             << "Graph connected"; // Граф связный
    else                           // Иначе
        cout << endl
             << "Graph disconnected"; // Граф не связный

    return 0;
}