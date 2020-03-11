#include <iostream>

using namespace std;

void WriteNumbers(int state, int* mas, int n, int k);

int main()
{
    setlocale(LC_ALL, "russian");
    int n;
    cout << "¬ведите размер массива: "<< endl;
    cin >> n;
    int *mas = new int[n];
    cout << "¬ведите элементы массива: "<< endl;
    for (int i = 0; i < n; i++)
    {
        cin >> mas[i];
    }
    int k = -1;
    WriteNumbers(-1, mas, n, k);
    k = -1;
    WriteNumbers(1, mas, n, k);
    cout << "0" << endl;
    return 0;
}

void WriteNumbers(int state, int* mas, int n, int k)
{
    if(state == -1)
    {
        k++;
        if(k < n)
        {
            if(mas[k]<0)
            {
                cout << mas[k] << " ";
            }
            WriteNumbers(-1, mas, n, k);
        }
    }
    if(state == 1)
    {
        k++;
        if(k < n)
        {
            if(mas[k]>0)
            {
                cout << mas[k] << " ";
            }
            WriteNumbers(1, mas, n, k);
        }
    }
}
