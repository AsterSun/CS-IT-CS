#include <iostream>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    double a,r,S;
    cout << "������� a(������� ������������)" << endl;
    cin >>a;
    r=a*1.732/6;
    S=3.142*r*r;
    cout <<"������� ��������� ���������� = "<<S<< endl;
    return 0;
}
