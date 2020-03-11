#include <iostream>

using namespace std;
long DoubleFactorial(long &n);
int main()
{
    setlocale(LC_ALL,"russian");
    long n;
    cout << "¬ведите n: ";
    cin >> n;
    cout << "n!! = "  << DoubleFactorial(n);
    return 0;
}

long DoubleFactorial(long &n){
for (int i = n - 2; i > 1; i-= 2){
    n = i * n;
}
return n;
}
