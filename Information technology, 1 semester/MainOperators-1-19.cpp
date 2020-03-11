#include <iostream>
#include <cmath>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    float x,y;
    cout << "¬ведите х" << endl;
    cin >>x;
    y = 5*pow(x,5)-2*pow(x,3)/15;
    cout <<"y="<<y;
    return 0;
}
