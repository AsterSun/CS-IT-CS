#include <iostream>
#include <string>
#include <fstream>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    cout << "������� ������:" << endl;
    string str;
    getline(cin, str);

    cout << "������� �����, ������� ���������� ��������:" << endl;
    string sli;
    getline(cin, sli);
    int slenght = sli.length();

    cout << "������� �����, ������� ���������� �������� � �����:" << endl;
    string sle;
    getline(cin, sle);

    int pos = str.find(sli);

    if (pos == -1)
        cout << "���������� ����� ��� � ������." << endl;
    else
    {
        str.erase(pos, slenght);
        str.insert(pos, sle);
        cout << str;
    }
    return 0;
}
