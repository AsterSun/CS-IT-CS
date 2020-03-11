#include <iostream> //5-3-14
#include <algorithm>

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

    if(n % 2 == 0)
        swap(arr[n / 2], arr[(n / 2) - 1]);

    for (int i = 0; i < n; i++){
        for (int j = 0; j < n; j++)
            cout << arr[i][j] << " ";
        cout << endl;
    }

    return 0;
}
