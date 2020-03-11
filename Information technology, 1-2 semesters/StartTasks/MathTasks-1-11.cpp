#include <iostream>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    cout << "Введите номер элемента:" << endl;
    unsigned int n;
    cin >> n;
    double y1 = 1, y2 = -1, y;
    switch (n){
    case (1): y = y1; break;
    case (2): y = y2; break;
    default:  {
        y = y2;
        int i = 3;
        while (i <= n){
            y = y1 * y1 + y2 + 1 / i;
            y1 = y2;
            y2 = y;
            i++;}
    break;}
    }
     cout << "Значение " << n << " элемента последовательности равно " << y << endl;
    return 0;
}
