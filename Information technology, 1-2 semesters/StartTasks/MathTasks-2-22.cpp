#include <iostream>//3-2-22
#include <cmath>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    cout << "¬ведите n" << endl;
    int n;
    cin >> n;
    double S = 1;
    for (int i = 2; i <= n; i++){
        S += sin(3 * i);
    }
    cout << "S = " << S;
    return 0;
}
