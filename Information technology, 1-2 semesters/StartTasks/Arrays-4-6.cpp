#include <iostream>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");

    int n;
    cout << "������� ������ n ���������� �������:" << endl;
    cin >> n;

    int **a = new int*[n];
    for (int i = 0; i < n; i++)
        a[i] = new int[n];

    cout << "��������� ������� �������� �������:" << endl;
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            cin >> a[i][j];

    int max = a[0][0];
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            if(((j <= i) && (j <- n - 1 - i)) || ((j >= i)&&(j >= n - i - 1)))
                if(((a[i][j] % 2) == 0) && (max <= a[i][j]))
                    max = a[i][j];

    if (max % 2 == 0)
        cout << "������������ ������ ������� � ��������� ������� ������� - " << max << endl;
    else
        cout << "� ��������� ������� ������� ��� ������ ���������" << endl;

    return 0;
}
