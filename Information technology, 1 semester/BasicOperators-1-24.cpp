#include <iostream>

using namespace std;

int main()
{
    setlocale(LC_ALL,"russian");
    float Ax, Ay, Bx, By, Cx, Cy, Dx, Dy, kAB, kBC, kCD, kDA;
    cout << "¬ведите координаты точки A" << endl;
    cin>>Ax>>Ay;
    cout << "¬ведите координаты точки B" << endl;
    cin>>Bx>>By;
    cout << "¬ведите координаты точки C" << endl;
    cin>>Cx>>Cy;
    cout << "¬ведите координаты точки D" << endl;
    cin>>Dx>>Dy;
    kAB=(By-Ay)/(Bx-Ax);
    kBC=(Cy-By)/(Cx-Bx);
    kCD=(Dy-Cy)/(Dx-Cx);
    kDA=(Ay-Dy)/(Ax-Dx);
    if ((kAB==kCD)&&(kBC!=kDA))
        cout<<"ABCD - трапеци€ c основани€ми AB и CD"<<endl;
    if ((kBC==kDA)&&(kAB!=kCD))
            cout<<"ABCD - трапеци€ с основани€ми BC и AD"<<endl;
    if ((kAB==kCD)&&(kBC==kDA))
        cout<<"ABCD - параллелограмм"<<endl;
    if ((kAB!=kCD)&&(kBC!=kDA))
        cout<<"ABCD не €вл€етс€ трапецией"<<endl;
    return 0;
}
