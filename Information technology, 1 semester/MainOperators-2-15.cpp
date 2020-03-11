#include <iostream>
#include <cmath>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    double a,b,c,p,S;
    cout << "¬ведите сторону a" << endl;
    cin >>a;
    cout << "¬ведите сторону b" << endl;
    cin >>b;
    cout << "¬ведите сторону c" << endl;
    cin >>c;
    p=(a+b+c)/2;
    S=sqrt(p*(p-a)*(p-b)*(p-c));
    cout <<"ѕлощадь треугольника = "<<S<< endl;
    return 0;
}
