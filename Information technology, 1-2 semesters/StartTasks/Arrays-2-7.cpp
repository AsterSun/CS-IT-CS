#include <iostream>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");

    int n;
    cout << "Введите количество элементов массива: " << endl;
    cin >> n;

    int *arr = new int[n];
    cout << "Введите элементы массива:" << endl;
    for (int i = 0; i < n; i++)
        cin >> arr[i];

    int k = 0, min = arr[0];
    for (int i = 0; i < n; i++){
      if (min >= arr[i]){
         min = arr[i];
         k = i;
         }
    }

    cout << "Номер последнего минимального элемента - " << k << endl;
    return 0;
}
