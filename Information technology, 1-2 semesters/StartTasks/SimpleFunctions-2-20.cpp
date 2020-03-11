#include <iostream>

using namespace std;

void pyramide(int n);

int main()
{
    setlocale(LC_ALL, "russian");

    int n;
    cout << "¬ведите n - ";
    cin >> n;

    pyramide(n);
    return 0;
}

void pyramide(int n){
    for (int i = 1; i <= n; i += 2){
        for(int j = 0; j < (n-i+1)/2; j++)
            cout << " ";
        for(int j = (n+1-i) / 2; j < (n+1+i)/2; j++)
            cout << "*";
        cout << endl;
    }
}
