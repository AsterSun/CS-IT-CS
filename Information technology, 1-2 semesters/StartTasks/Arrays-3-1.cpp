#include <iostream> // 5-3-1

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");

    int n;
    cout << "”кажите размер n массива n x n:" << endl;
    cin >> n;

    int **arr = new int*[n];
    for (int i = 0; i < n; i++)
        arr[i] = new int[n];

    cout << "¬ведите элементы массива:" << endl;
    for (int i = 0; i < n; i++)
        for(int j = 0; j < n; j++)
            cin >> arr[i][j];

    cout << endl;
    for (int i = 0; i < n; i++){
        for (int j = 0; j < n; j++)
            cout << arr[n - i - 1][j] << " ";
        cout << endl;
    }

    return 0;
}
