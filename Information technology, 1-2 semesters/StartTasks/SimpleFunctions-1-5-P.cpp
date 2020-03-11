#include <iostream>

using namespace std;
long DoubleFactorial(long &n);
long DoubleFactorial(long n, int r);
int main()
{
    setlocale(LC_ALL,"russian");
    long n;
    int r;
    cout << "¬ведите n: ";
    cin >> n;
    cout << "–ешить рекурсивно или циклом?(цикл - 1, рекурси€ - 2)" << endl;
    cin >> r;
    if (r == 1)
    cout << "n!! = "  << DoubleFactorial(n);
    else cout << "n!! = "  << DoubleFactorial(n, r);
    return 0;
}

long DoubleFactorial(long &n){
for (int i = n - 2; i > 1; i-= 2){
    n = i * n;
}
return n;
}

long DoubleFactorial(long n, int r){
if((n == 1)||(n == 0)) return 1;
else
   return n * DoubleFactorial(n - 2, r);
}
