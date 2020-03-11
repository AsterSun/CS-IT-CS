#include <iostream>
#include <cmath>

using namespace std;
double RootK(double X, int K, int N);
int main()
{
    setlocale(LC_ALL, "russian");
    double X;
    int K, N;
    cout << "¬ведите X, K, N - " ;
    cin >> X >> K >> N;
    double Y = RootK(X, K, N);
    cout << "Y = " << Y;
    return 0;
}
double RootK(double X, int K, int N){
double y = 1;
for (int i = 1; i < N; i++){
    y = y - (y - X / pow(y, K - 1)) / (K * 1.0);
}
return y;
}
