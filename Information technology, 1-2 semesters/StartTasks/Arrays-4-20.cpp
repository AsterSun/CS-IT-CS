#include <iostream>

using namespace std;

int main()
{
    setlocale (LC_ALL, "russian");
    cout << "¬ведите размер квадратной матрицы n:" << endl;
    int n;
    cin >> n;

    int **a = new int*[n];
    for (int i = 0; i < n; i++)
        a[i] = new int[n];

    cout << "¬ведите элементы массива:" << endl;
    int x = 0;
    while (x < n - 1){
            for (int i = 0; i < n; i++){
                cin >> a[i][x];
            }
            x++;
            for (int i = n - 1; i >= 0; i--){
                cin >> a[i][x];
            }
            x++;
    }

    if (n % 2 != 0){
            for (int i = 0; i < n; i++){
                cin >> a[i][x];
            }
    }

    cout << "¬вЄденна€ матрица:" << endl;
    for (int i = 0; i < n; i++){
        for (int j = 0; j < n; j++)
            cout << a[i][j] << " ";
    cout << endl;
    }

    return 0;
}
