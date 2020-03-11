#include <iostream>
#include <cmath>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    long double a,b,c,S;
    cout << "¬ведите a(катет)" << endl;
    cin >>a;
    cout << "¬ведите с(гипотенуза)" << endl;
    cin >>c;
    b=sqrt(c*c - a*a);
    S=(a*b)/2;
    cout <<"ѕлощадь треугольника = "<<S<< endl;
    return 0;
}

