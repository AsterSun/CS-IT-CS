#include <iostream>
#include <cmath>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    float Ox, Oy, R, P1x, P1y, P2x, P2y, P1P2,OP1,OP2,p,S,h;
    cout<<"������� ���������� ����� O"<<endl;
    cin>>Ox>>Oy;
    cout<<"������� ������"<<endl;
    cin>>R;
    cout<<"������� ���������� ����� P1"<<endl;
    cin>>P1x>>P1y;
    cout<<"������� ���������� ����� P2"<<endl;
    cin>>P2x>>P2y;
    P1P2=sqrt((P2x-P1x)*(P2x-P1x)+(P2y-P1y)*(P2y-P1y));
    OP1=sqrt((P1x-Ox)*(P1x-Ox)+(P1y-Oy)*(P1y-Oy));
    OP2=sqrt((P2x-Ox)*(P2x-Ox)+(P2y-Oy)*(P2y-Oy));
    p=(P1P2+OP1+OP2)/2;
    S=sqrt(p*(p-P1P2)*(p-OP1)*(p-OP2));
    h=2*S/P1P2;
    if (R>h)
        cout<<"������ � ���������� ����� 2 ����� �����"<<endl;
    if(R==h)
        cout<<"������ � ���������� ����� 1 ����� �����"<<endl;
    if(R<h)
        cout<<"������ � ���������� �� ������������"<<endl;
    return 0;
}
