#include <iostream>
#include <cmath>

using namespace std;

int main()
{
    double x, y, h, a, b;
    int e;
    a=-3.5; b=1; h=0.5; x=a; e=0;
    cout << "e  x;y" << endl;
    while(x<=b){
        if(x<-2){
            if(x!=-3){
                e++;
                y=1/abs(2*x+6);
                cout<<e<<" "<<x<<";"<<y<<endl;
                x+=h;
            }else{
                e++;
            cout<<e<<" "<<x<<" Function not defined"<<endl;
            x+=h;}
        }
        if(x>=-2){
            if(x>-1){
                e++;
                y=log(x+1);
                cout<<e<<" "<<x<<";"<<y<<endl;
                x+=h;
            }else{
                 e++;
            cout<<e<<" "<<x<<" Function not defined"<<endl;
            x+=h;}
        }
            }
    return 0;
}
