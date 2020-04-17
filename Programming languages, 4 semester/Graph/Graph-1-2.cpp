#include <iostream>
#include <list>
#include <map>

using namespace std;

class Graph
{
public:
    bool isWeighed;                        // Предикат взвешенности
    bool isOriented;                       // Предикат ориентированности
    int N;                                 //Количество вершин
    int M;                                 //Количество рёбер
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

    void semiDegreeOfOutcome()
    { // Полустепень исхода
        for (auto it = Adj.begin(); it != Adj.end(); it++)
        {
            int result = 0; // Инициализиуруем переменную для результата
            for (auto it_1 = it->second.begin(); it_1 != it->second.end(); it_1++)
                result++;                                        // Пока есть рёбра вида x->y - увеличиваем результат
            cout << it->first << " - " << result << ";" << endl; // Выводим результат для вершины
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

    // Подсчёт полустепени исхода
    cout << "Semi-degree of outcome: " << endl;
    gr.semiDegreeOfOutcome();
    cout << endl;

    return 0;
}