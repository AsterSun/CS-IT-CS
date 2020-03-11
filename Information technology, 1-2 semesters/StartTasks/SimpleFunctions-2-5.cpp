#include <iostream>

using namespace std;

void sortpmn(int *a, int n);

int main()
{
    setlocale(LC_ALL, "russian");

    int n;
    cout << "”кажите количество элементов последовательности - ";
    cin >> n;
    cout << endl;

    int *a = new int[n];
    cout << "¬ведите последовательность ненулевых элементов:" << endl;
    for (int i = 0; i < n; i++)
        cin >> a[i];

    sortpmn(a, n);

    return 0;
}

void sortpmn(int *a, int n){
    for (int i = 0; i < n; i++){
    if (a[i] < 0) cout << a[i] << " ";
    }
    for (int i = 0; i < n; i++){
    if (a[i] > 0) cout << a[i] << " ";
    }
    cout << "0";
}

