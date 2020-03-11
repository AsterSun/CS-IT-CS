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

    int Nmax = 0, max = arr[0];
    for (int i = 0; i < n; i++){
      if (max <= arr[i]){
         max = arr[i];
         Nmax = i;
         }
    }

    int Nmin = 0, min = arr[0];
    for (int i = 0; i < n; i++){
      if (min > arr[i]){
         min = arr[i];
         Nmin = i;
         }
    }

    int S = 0, p = Nmax - Nmin - 1;
    if (Nmax > Nmin){
    for (int i = Nmin + 1; i < Nmax; i++)
        S+= arr[i];
    cout << "Среднее арифметическое нужных чисел - " << S * 1.0 / p << endl;
    }
    else {cout << "Последний максимальный элемент расположен раньше первого" << endl;
          cout << "минимального или значение всех элементов массива одинаково" << endl;}

    return 0;
}
