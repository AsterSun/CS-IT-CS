#include <iostream>

using namespace std;

int main()
{
  setlocale(LC_ALL, "russian");
    float A1,A2,B1,B2;
    cout<<"������� A1 � B1"<<endl;
    cin>>A1>>B1;
    cout<<"������� A2 � B2"<<endl;
    cin>>A2>>B2;
    if ((A1/B1)==(A2/B2))
        cout<<"������ �����������"<<endl;
            else
                cout<<"������ �� �������� �������������"<<endl;
    return 0;
}
