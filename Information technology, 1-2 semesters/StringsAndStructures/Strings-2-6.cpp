#include <iostream>
#include <string>
#include <fstream>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    cout << "¬ведите строку:" << endl;
    string str;
    getline(cin, str);

    cout << "¬ведите слово, которое необходимо заменить:" << endl;
    string sli;
    getline(cin, sli);
    int slenght = sli.length();

    cout << "¬ведите слово, которое необходимо вставить в текст:" << endl;
    string sle;
    getline(cin, sle);

    int pos = str.find(sli);

    if (pos == -1)
        cout << "”казанного слова нет в строке." << endl;
    else
    {
        str.erase(pos, slenght);
        str.insert(pos, sle);
        cout << str;
    }
    return 0;
}
