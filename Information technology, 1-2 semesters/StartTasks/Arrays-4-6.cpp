#include <iostream>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");

    int n;
    cout << "Укажите размер n квадратной матрицы:" << endl;
    cin >> n;

    int **a = new int*[n];
    for (int i = 0; i < n; i++)
        a[i] = new int[n];

    cout << "Построчно введите элементы матрицы:" << endl;
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            cin >> a[i][j];

    int max = a[0][0];
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            if(((j <= i) && (j <- n - 1 - i)) || ((j >= i)&&(j >= n - i - 1)))
                if(((a[i][j] % 2) == 0) && (max <= a[i][j]))
                    max = a[i][j];

    if (max % 2 == 0)
        cout << "Максимальный чётный элемент в указанной области матрицы - " << max << endl;
    else
        cout << "В указанной области матрицы нет чётных элементов" << endl;

    return 0;
}
