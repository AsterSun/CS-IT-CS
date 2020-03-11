#include <iostream>
#include <cmath>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    float x,y;
    cout << "¬ведите х" << endl;
    cin >>x;
    y = log(25 + pow(x,4));
    cout <<"y="<<y;
    return 0;
}
