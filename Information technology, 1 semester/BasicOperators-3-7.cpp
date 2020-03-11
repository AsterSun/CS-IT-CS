#include <iostream>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    int a=1,b=0;
    char loop;
    cout<<"Выберите цикл, с помощью которого будет выполнено задание:"<<endl<<"w-while"<<endl<<"d-do while"<<endl<<"f-for"<<endl;
    cin>>loop;
    switch(loop){
    case 'w': {while(a<9){
        while(b<10){
            cout<<a<<b<<a<<" ";
            b++;}
                cout<<endl;
                b=0;
                a++;
    }
    break;}
    case 'd':{ do {
            do{cout<<a<<b<<a<<" ";
                b++;}while(b<10);
                    cout<<endl;
                    b=0;
                    a++;
           }while(a<10);
    break;}
    case 'f':{ for(a; a<10; a++){
            for(b; b<10; b++){cout<<a<<b<<a<<" ";}
                cout<<endl;
                b=0;
    }
    break;}
    default: cout<<"Некорректно указан тип цикла"<<endl; break;
    }
    return 0;
}

