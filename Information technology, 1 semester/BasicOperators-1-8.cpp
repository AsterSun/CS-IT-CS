#include <iostream>

using namespace std;

int main()
{
  setlocale(LC_ALL, "russian");
    float A1,A2,B1,B2;
    cout<<"Введите A1 И B1"<<endl;
    cin>>A1>>B1;
    cout<<"Введите A2 И B2"<<endl;
    cin>>A2>>B2;
    if ((A1/B1)==(A2/B2))
        cout<<"Прямые параллельны"<<endl;
            else
                cout<<"Прямые не являются параллельными"<<endl;
    return 0;
}
