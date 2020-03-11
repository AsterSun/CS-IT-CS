#include <iostream>
#include <cmath>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    double a, b, h, x, y, e;
    cout << "Отрезок - [-1,5;3], шаг h = 0,5" << endl;
    a=-1.5; b=3; h=0.5; e=0, x=a;
    cout<<"e  x;y"<<endl;
    while(x<=b){
    if ((x<1.5)&&(x>1)||(x>=1.5)){
            if ((x<1.5)&&(x>1)){
                e++;
                y=sqrt(x-1)/sqrt(x*x-1);
                cout<<e<<") "<<x<<";"<<y<<endl;
                x+=0.5;
            }else{
                e++;
                y=x+1;
                cout<<e<<") "<<x<<";"<<y<<endl;
                x+=0.5;}

    }else {
        e++;
        cout<<e<<") "<<x<<"-Функция не определена"<<endl;
        x+=0.5;}
    }
    return 0;
}
