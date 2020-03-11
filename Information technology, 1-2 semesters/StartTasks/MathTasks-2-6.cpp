#include <iostream> //3-2-6

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    cout << "¬ведите n" << endl;
    int n;
    cin >> n;
    double S = 0;
    for (int i = 1; i <= n; i++){
        S+= 1.0 / (i * i);
    }
    cout << "S = " << S;
    return 0;
}
