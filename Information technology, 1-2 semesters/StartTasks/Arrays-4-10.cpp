#include <iostream>

using namespace std;

int main()
{
    setlocale (LC_ALL, "russian");

    int n;
    cout << "Введите размерность квадратной матрицы:" << endl;
    cin >> n;

    int **a = new int*[n];
    for (int i = 0; i < n; i++)
        a[i] = new int[n];

    cout << "Построчно введите элементы матрицы:" << endl;
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            cin >> a[i][j];

    int iEven = -1, jEven = -1, iOdd = -1, jOdd = -1, minEven = 0, maxOdd = 0;
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++){
            if (j <= i){
                if (((a[i][j] % 2) == 0) && ((minEven > a[i][j]) || (iEven == -1))){
                    minEven = a[i][j];
                    iEven = i;
                    jEven = j;
                }
            }
            else
                if (((a[i][j] % 2) != 0) && ((maxOdd < a[i][j]) || (iOdd == -1))){
                    maxOdd = a[i][j];
                    iOdd = i;
                    jOdd = j;
                }
        }

    int aBuff;
    if ((iEven != -1) && (iOdd != -1)){
            cout << endl << "Получившаяся матрица:" << endl;
            aBuff = a[iEven][jEven];
            a[iEven][jEven] = a[iOdd][jOdd];
            a[iOdd][jOdd] = aBuff;
            for (int i = 0; i < n; i++){
                for (int j = 0; j < n; j++)
                    cout << a[i][j] << " ";
                cout << endl;
            }
            cout << endl;
    }
    if (iEven == -1)
        cout << "В указанной области отсутсвуют чётные элементы" << endl;
    if (iOdd == -1)
        cout << "В указанной области отсутствуют нечётные элементы" << endl;

    return 0;
}
