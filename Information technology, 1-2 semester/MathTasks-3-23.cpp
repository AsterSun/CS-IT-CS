#include <iostream> //23
#include <cmath>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");

    int k;
    double x;

    cout << "¬ведите k и x" << endl;
    cin >> k >> x;

    double a = - x * x / 2;
    double S = a;


    int i;

   for (i = 2; i <= k; i++){

        a *= - ( x / (i - 1));
        S += a;

  }
    cout << "a\tS\n";
    cout << a << "\t| " << S << endl;

 return 0;
 }
