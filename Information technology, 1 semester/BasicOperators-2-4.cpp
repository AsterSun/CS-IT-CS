#include <iostream>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    int Day, Month, Year;
    cout<< "������� ����" << endl;
    cin>>Day>>Month>>Year;
    switch (Month){
    case 1: cout<<Day<<" ������ "<<Year<<" ����"; break;
    case 2: cout<<Day<<" ������� "<<Year<<" ����"; break;
    case 3: cout<<Day<<" ����� "<<Year<<" ����"; break;
    case 4: cout<<Day<<" ������ "<<Year<<" ����"; break;
    case 5: cout<<Day<<" ��� "<<Year<<" ����"; break;
    case 6: cout<<Day<<" ���� "<<Year<<" ����"; break;
    case 7: cout<<Day<<" ���� "<<Year<<" ����"; break;
    case 8: cout<<Day<<" ������� "<<Year<<" ����"; break;
    case 9: cout<<Day<<" �������� "<<Year<<" ����"; break;
    case 10: cout<<Day<<" ������� "<<Year<<" ����"; break;
    case 11: cout<<Day<<" ������ "<<Year<<" ����"; break;
    case 12: cout<<Day<<" ������� "<<Year<<" ����"; break;
    default: cout<<"������ � ����";
    }
    return 0;
}
