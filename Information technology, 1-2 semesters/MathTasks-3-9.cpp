#include <iostream> //9
#include <cmath>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");

    int k;
    double x;

    cout << "¬ведите k и x" << endl;
    cin >> k >> x;

    double a = x * x / 8;
    double S = a;


    int i;

   for (i = 2; i <= k; i++){

        a *= - ( 1.0 / (16 * i - 8));
        S += a;

  }
    cout << "a\tS\n";
    cout << a << "\t| " << S << endl;

 return 0;
 }
