#include <iostream>
#include <cstring>
using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    int d, m;
    cout << "������� ����� ����� � ����� �����" << endl;
    cin >>d>>m;
    switch (d){
    case 6: cout<<"������� "; break;
    case 7: cout<<"������ "; break;
    case 8: cout<<"�������� "; break;
    case 9: cout<<"������� "; break;
    case 10: cout<<"�������  "; break;
    case 11: cout<<"����� "; break;
    case 12: cout<<"���� "; break;
    case 13: cout<<"������ "; break;
    case 14: cout<<"��� "; break;
    default: cout<<"������ ";}
    switch (m){
    case 1: cout<<"���� "; break;
    case 2: cout<<"����"; break;
    case 3: cout<<"�����"; break;
    case 4: cout<<"�����"; break;
    default: cout<<"������";
    }
    return 0;
}
