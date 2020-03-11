#include <iostream>
#include <cmath>

using namespace std;

int main()
{
    double x, y, a, b, h;
    int e;
    cout<<"e  x;y"<<endl;
    a=1.5; b=5; e=0; x=a; h=0.5;
    while(x<=b){
        if(x<3.5){
            if(((x-2)/(x-3)>0)&&(x!=3)){
                e++;
                y=log((x-2)/(x-3));
                cout<<e<<" "<<x<<";"<<y<<endl;
                x+=h;
            }else{
             e++;
            cout<<e<<" "<<x<<" Function not defined"<<endl;
            x+=h;}
        }
        if(x>=3.5){
            if(x>=4){
                e++;
                y=sqrt(2*x-8);
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
