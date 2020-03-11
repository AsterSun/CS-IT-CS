#include <iostream>
#include <cmath>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    float x,y;
    cout << "¬ведите х" << endl;
    cin >>x;
    y = sqrt(6*pow(x,6)+10)/(6+pow(x,2));
    cout <<"y="<<y;
    return 0;
}
