#include <iostream>
#include <vector>

using namespace std;

double INF = 10000.0; // Бесконечность
double EPS = 1.0;     // Погрешность при проверке на бесконечность

// Неориентированный взвешенный граф
class Graph
{
public:
    int N;                      // Количество вершин
    int M;                      // Количество рёбер
    vector<vector<double>> Adj; // Матрица смежности, где в ячейке Adj[x][y] хранится вес ребра x->y

    Graph(int n, int m)
    { // Конструктор
        N = n;
        M = m;
    }

    void createAdjList()
    {                  // Создание матрицы смежности
        int x, y;      // Инициализация вершин
        double w;      // Инициализация веса
        Adj.resize(N); // Устанавливаем размер внешнего вектора на количество вершин
        for (int i = 0; i < N; i++)
        {
            Adj[i].resize(N); // Устанавливаем размер внутреннего вектора на количество вершин
            for (int j = 0; j < N; j++)
                Adj[i][j] = INF; // Для каждой ячейки устанавливаем значение бесконечности, то есть отсутвие пути
        }
        cout << "Enter edges:" << endl;
        for (int i = 0; i < M; i++)
        {
            cin >> x >> y >> w; // Считываем каждое ребро
            Adj[x][y] = w;      // и устанавливаем значение ячейки, равное весу
            Adj[y][x] = w;
        }
    }

    void printAdj()
    { // Вывод списка смежности
        for (int i = 0; i < N; i++)
        {
            cout << i << " : "; // Вершина, откуда выходит ребро
            for (int j = 0; j < N; j++)
            {                                                     // Перебираем список смежных вершин
                if (Adj[i][j] < INF - EPS)                        // Если значение не бесконечность
                    cout << " " << j << "(" << Adj[i][j] << ");"; // Выводим
            }
            cout << endl;
        }
    }

    // Алгоритм Прима. Стартовая точка подаётся на вход функции,
    // однако если граф связный и неориентированный, то остовное
    // дерево может быть корректно построено из любой точки.
    // Точка входа подаётся лишь для наглядности.
    void algorithmPrims(int start)
    {
        // Вектор вершин, которые на текущий момент входят в остовное дерево
        vector<int> spanning;
        spanning.resize(N);
        spanning[start] = 1; // Добавляем стартовую вершину в остовное дерево
        // Вектор результата. Значения - пары из веса и пары вершин, то есть (w, (x, y))
        vector<pair<double, pair<int, int>>> out;
        // Повторяем цикл N раз, чтобы добавить каждую вершину
        // в остовное дерево. На последней итерации функция должна
        // выйти из цикла, так как не будет изменено w
        for (int k = 0; k < N; k++)
        {
            double MIN = INF;                     // Минимальный вес
            pair<int, int> w = make_pair(-1, -1); // w - пара вершин (x, y)
            for (int i = 0; i < N; i++)
            {                                   // Для каждой вершины
                if (spanning[i])                // которая уже в остовном дереве
                    for (int j = 0; j < N; j++) // Для каждой вершины
                        if (!spanning[j])       // которая ещё не в остовном дереве
                            // i - вершины из остовного дерева, j - не из остовного
                            if (Adj[i][j] < MIN)
                            {                        // Если значение ребра меньше минимума
                                MIN = Adj[i][j];     // Присваиваем новый минимум
                                w = make_pair(i, j); // И запоминаем пару вершин
                            }
            }
            // Если w не было изменено ни разу - выходим из функции
            if (w == make_pair(-1, -1))
                break;

            // Добавляем вторую вершину, то есть вершину j в остовное дерево
            spanning[w.second] = 1;
            // Добавляем ребро в резултат
            out.push_back(make_pair(MIN, w));
        }

        // Выводим результат из вектора out
        cout << "Minimum spanning tree edges:" << endl;
        for (int i = 0; i < N - 1; i++)
            cout << "(" << out[i].second.first << ","
                 << out[i].second.second << ") = " << out[i].first << endl;
    }
};

int main()
{
    // Чтение количества вершин и рёбер
    cout << "Enter number of vertexes and edges: " << endl;
    int nV, nE;
    cin >> nV >> nE;

    // Чтение рёбер графа и создание матрицы смежности
    Graph gr(nV, nE);
    gr.createAdjList();

    // Вывод матрицы смежности
    cout << endl;
    gr.printAdj();

    // Чтение стартовой точки
    cout << "Enter start point:" << endl;
    int start;
    cin >> start;

    // Вывод рёбер минимального остовного дерева
    gr.algorithmPrims(start);

    return 0;
}