#include <iostream>

using namespace std;
long DoubleFactorial(long n);
int main()
{
    setlocale(LC_ALL, "russian");
    long n;
    cout << "¬ведите n: ";
    cin >> n;
    cout << "n!!=" <<  DoubleFactorial(n);
    return 0;
}
long DoubleFactorial(long n){
if((n == 1)||(n == 0)) return 1;
else
   return n * DoubleFactorial(n - 2);
}
