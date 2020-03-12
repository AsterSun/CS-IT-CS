#include <iostream>
#include <string>

using namespace std;

int main()
{
    setlocale(LC_ALL,"russian");
    string str;
    cout << "¬ведите строку: " << endl;
    getline(cin, str);
    string::size_type n = str.length();
    for (int i = 0; str[i]!='\0'; i++)
    {
        if (str[i] == ' ')
        {
            str.erase(i, 1);
            i--;
        }
    }
    cout << str;
    return 0;
}
