#include <iostream>
#include <cmath>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    double a,b,c,p,S;
    cout << "������� ������� a" << endl;
    cin >>a;
    cout << "������� ������� b" << endl;
    cin >>b;
    cout << "������� ������� c" << endl;
    cin >>c;
    p=(a+b+c)/2;
    S=sqrt(p*(p-a)*(p-b)*(p-c));
    cout <<"������� ������������ = "<<S<< endl;
    return 0;
}
