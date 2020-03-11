#include <iostream>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");

    int n;
    cout << "Введите количество элементов массива:" << endl;
    cin >> n;

    int *arr = new int[n];
    cout << "Введите элементы массива:" << endl;
    for (int i = 0; i < n; i++) cin >> arr[i];

    int max = arr[0], Nmax = -1;
    for (int i = 0; i < n; i++){
            if (((max < arr[i]) && (arr[i]  % 2 == 0)) || ((arr[i] % 2 == 0) && (Nmax == -1))){
               max = arr[i];
               Nmax = i;
            }
    }

    int min = arr[0], Nmin = -1;
    for (int i = 0; i < n; i++){
            if (((min > arr[i]) && (arr[i] % 2 == 1)) || ((arr[i] % 2 == 1) && (Nmin == -1))){
               min = arr[i];
               Nmin = i;
            }
    }

    if((Nmin != -1) && (Nmax != - 1)){
        int memory = arr[Nmin];
        arr[Nmin] = arr[Nmax];
        arr[Nmax] = memory;
        cout << "Получившийся массив:" << endl;
        for (int i = 0; i < n; i++) cout << arr[i] << " ";
    }
    else cout << "Подходящих элементов нет" << endl;

    return 0;
}
