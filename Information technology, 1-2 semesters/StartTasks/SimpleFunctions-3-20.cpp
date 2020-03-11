#include <iostream>
#include <cmath>

using namespace std;
double RootK(double X, int K, int N, double y);
int main()
{
    setlocale(LC_ALL, "russian");
    double X;
    int K, N;
    cout << "¬ведите X, K, N - " ;
    cin >> X >> K >> N;
    double y = 1;
    y = RootK(X, K, N, y);
    cout << "Y = " << y;
    return 0;
}
double RootK(double X, int K, int N, double y){
    if (y == 0)
        return 1;
    else
    return RootK(X, K, N, y - 1) - (RootK(X, K, N, y - 1) - X / pow(RootK(X, K, N, y - 1), K - 1)) / (K * 1.0);
}
