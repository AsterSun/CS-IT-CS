#include <iostream>
#include <string>
using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    cout << "¬ведите строку:" << endl;
    string str;
    getline(cin, str);
    cout << "¬ведите длину:" << endl;
    int length;
    cin >> length;
    int slen = str.length();
    int delimpos = -1, nl = 0;
    for(int j = 0; j < slen; j++)
    {
        nl++;
        if(str.at(j) == ' ')
        {
            nl--;
            if(nl > length)
            {
                str.erase(delimpos + 1, nl);
                slen = str.length();
                j = delimpos + 1;
            }
            nl = 0;
            delimpos = j;
        }
        if(j == slen - 1)
        {
            if(nl > length)
            {
                str.erase(delimpos + 1, nl);
            }
        }
    }
    cout << str << endl;
    return 0;
}
