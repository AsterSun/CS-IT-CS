#include <iostream> //7

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");

    cout << "Введите кол-во элементов массива" << endl;
    int n;
    cin >> n;

    int *arr = new int[n];
    for (int i = 0; i < n; i++) arr[i] = i;

    float a, b;
    cout << "Введите интервал" <<endl;
    cin >> a >> b;

    int S = 0, t = 0;

    for (int i = 1; i < a; i++){
        if (arr[i] % 2 != 0){
        S += arr[i];
        t++;
        }
    }

    for (int i = b + 1; i < n; i++){
        if (arr[i] % 2 != 0){
        S += arr[i];
        t++;
        }
    }

    if (t == 0) cout << "Таких элементов нет" << endl;
    else cout << "Среднее арифметическое нечетных элементов = " << S * 1.0 / t << endl;

    return 0;
}
