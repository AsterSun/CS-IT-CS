#include <iostream>
#include <cmath>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    long double a,b,c,S;
    cout << "������� a(�����)" << endl;
    cin >>a;
    cout << "������� �(����������)" << endl;
    cin >>c;
    b=sqrt(c*c - a*a);
    S=(a*b)/2;
    cout <<"������� ������������ = "<<S<< endl;
    return 0;
}

