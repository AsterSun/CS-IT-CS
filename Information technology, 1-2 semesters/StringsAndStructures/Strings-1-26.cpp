#include <iostream>
#include <string>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    cout << "¬ведите строку:" << endl;
    string str;
    getline(cin, str);
    cout << "¬ведите  k и s:" << endl;
    int k, s;
    cin >> k >> s;
    string :: size_type n = str.length();
    for (int i = 0; i < k + 1; i++)
        cout << str[i];
    for (int i = s - 1; i > k; i--)
        cout << str[i];
    for (int i = s; i < n; i++)
        cout << str[i];
    return 0;
}
