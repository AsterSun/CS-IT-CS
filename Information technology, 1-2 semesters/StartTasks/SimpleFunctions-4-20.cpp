#include <iostream>

using namespace std;

void pyramide(int n, int i);

int main()
{
    setlocale(LC_ALL, "russian");

    int n;
    cout << "¬ведите n - ";
    cin >> n;

    int k = 0;
    if ((n%2)==0) n--;
    pyramide(n,k);
    return 0;
}

void pyramide(int n, int i){
    i += 2;
    cout << endl;
   if(((n+1-i)/2) >= 0){
   for (int j = 0; j <= (n+1-i-2)/2; j++)
    cout << " ";
    for (int j = 0; j <= i-2; j++)
        cout << "*";
    pyramide(n, i);
   }
}

