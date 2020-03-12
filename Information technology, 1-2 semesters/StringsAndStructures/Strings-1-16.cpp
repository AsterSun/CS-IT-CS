#include <iostream>
#include <string>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    cout << "¬ведите строку:" << endl;
    string str;
    getline(cin, str);
    for (int i = 0; str[i + 1]!='\0'; i++)
        if((str[i] == ' ')&&(str[i + 1] == ' '))
        {
            str.erase(i, 1);
            i--;
        }
    string :: size_type n = str.length();
    int b = -1, e = -1;
    for (int i = n; (i > -1)&&(b == -1); i--)
        if(str[i]==' ')
            if (e == -1)
                e = i;
            else
                b = i;
    for (int i = b + 1; i < e ; i++)
        cout << str[i];
    return 0;
}
