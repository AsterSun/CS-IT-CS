#include <iostream>

using namespace std;

int main()
{
    setlocale(LC_ALL,"russian");
    float Ax, Ay, Bx, By, Cx, Cy, Dx, Dy, kAB, kBC, kCD, kDA;
    cout << "������� ���������� ����� A" << endl;
    cin>>Ax>>Ay;
    cout << "������� ���������� ����� B" << endl;
    cin>>Bx>>By;
    cout << "������� ���������� ����� C" << endl;
    cin>>Cx>>Cy;
    cout << "������� ���������� ����� D" << endl;
    cin>>Dx>>Dy;
    kAB=(By-Ay)/(Bx-Ax);
    kBC=(Cy-By)/(Cx-Bx);
    kCD=(Dy-Cy)/(Dx-Cx);
    kDA=(Ay-Dy)/(Ax-Dx);
    if ((kAB==kCD)&&(kBC!=kDA))
        cout<<"ABCD - �������� c ����������� AB � CD"<<endl;
    if ((kBC==kDA)&&(kAB!=kCD))
            cout<<"ABCD - �������� � ����������� BC � AD"<<endl;
    if ((kAB==kCD)&&(kBC==kDA))
        cout<<"ABCD - ��������������"<<endl;
    if ((kAB!=kCD)&&(kBC!=kDA))
        cout<<"ABCD �� �������� ���������"<<endl;
    return 0;
}
