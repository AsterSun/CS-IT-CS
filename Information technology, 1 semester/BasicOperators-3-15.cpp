#include <iostream>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    int x=0,y;
    char loop;
    cout<<"¬ыберите цикл, которым будет решена задача:"<<endl<<"w-while"<<endl<<"d-do while"<<endl<<"f-for"<<endl;
    cin>>loop;
    switch(loop){
    case 'w':{while(x<9){
    x++;
    if (x<5){y=x+5;}else y=x-5;
    if(y%2==0)cout<<x<<y<<" ";
    }
    break;}
    case 'd':{do{
    x++;
    if (x<5){y=x+5;}else y=x-5;
    if(y%2==0)cout<<x<<y<<" ";
    }while(x<9);
    break;}
    case 'f':{for(x;x<10; x++){
         if (x<5){y=x+5;}else y=x-5;
    if(y%2==0)cout<<x<<y<<" ";
    }
    break;}
    return 0;
}
}
