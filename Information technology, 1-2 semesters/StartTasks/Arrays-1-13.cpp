#include <iostream> //13

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");

    cout << "������� ������ �������" << endl;
    int n;
    cin >> n;

    cout << "������� �������� �������" << endl;
    int *arr = new int[n];
    for (int i = 0; i < n; i++) cin >> arr[i];

    int s = 0;


    for (int i = 1; i < n; i++){
    if(((i % 2) != 0) && ((arr[i] % 2) == 0)){
    s += arr[i];
    }
    }

    cout <<"����� ������ ��������� � ��������� �������� = " << s << endl;
    return 0;
}
