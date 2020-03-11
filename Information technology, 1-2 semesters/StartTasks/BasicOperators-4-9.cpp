#include <iostream>

using namespace std;

int main()
{
    int i,j,a=1;
    for(i=10;i!=0; i-=2){
            a++;
        for(j=1;j!=a;j++)
            cout<<i<<" ";
            cout<<endl;
    }
    return 0;
}
