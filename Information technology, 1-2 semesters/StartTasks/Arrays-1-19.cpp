#include <iostream> //19

using namespace std;

int main()
{
   setlocale(LC_ALL, "russian");

   int n;
   cout << "������� ������ �������" << endl;
   cin >> n;

    cout << "������� �������� �������" << endl;
    int *arr = new int[n];
    for (int i = 0; i < n; i++) cin >> arr[i];

   bool STATE = 0;

   cout << "������ �������� ���������, �� ������� ��� - ";
   for (int i = 0; i < n; i++){
    if( ((arr[i] % 2) != 0)&&( (arr[i] % 3) != 0) ) {
            STATE = 1;
            cout << i <<" ";
        }
    }

    if (STATE == 0) cout << "����� ��������� ���";

    return 0;
}
