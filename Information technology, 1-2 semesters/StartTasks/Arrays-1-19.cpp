#include <iostream> //19

using namespace std;

int main()
{
   setlocale(LC_ALL, "russian");

   int n;
   cout << "Введите размер массива" << endl;
   cin >> n;

    cout << "Введите элементы массива" << endl;
    int *arr = new int[n];
    for (int i = 0; i < n; i++) cin >> arr[i];

   bool STATE = 0;

   cout << "Номера нечётных элементов, не кратных трём - ";
   for (int i = 0; i < n; i++){
    if( ((arr[i] % 2) != 0)&&( (arr[i] % 3) != 0) ) {
            STATE = 1;
            cout << i <<" ";
        }
    }

    if (STATE == 0) cout << "таких элементов нет";

    return 0;
}
