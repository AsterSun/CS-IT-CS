#include <iostream> //5-3-9

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

    cout << "¬ведите строку X из n элементов:" << endl;
    int *X = new int[n];
    for (int i = 0; i < n; i++)
        cin >> X[i];

    int min = arr[0][0];
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            if (min > arr[i][j]) min = arr[i][j];

    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++){
                if(min == arr[i][j])
                    for (int k = 0; k < n; k++)
                        arr[i][k] = X[k];
        }

    for (int i = 0; i < n; i++){
        for (int j = 0; j < n; j++)
            cout << arr[i][j] << " ";
        cout << endl;
    }

    return 0;
}
