#include <iostream>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    int N,a=0;
    long long S=0;
    char T;
    cout<<"Выберите тип цикла, которым должна быть решена задача:"<<endl<<"w-while"<<endl<<"d-do while"<<endl<<"f-for"<<endl;
    cin>>T;
    cout<< "Введите N" << endl;
    cin>>N;
    switch(T){
    case 'w':while(a<=N){S+=a*a*a;   a+=2;};           break;
    case 'd':         do{S+=a*a*a;   a+=2;}while(a<=N);break;
    case 'f':for  (a; a<=N; a+=2)    S+=a*a*a;         break;
    default: cout<<"Некорректно указан тип цикла"<<endl;}
        cout<<"Сумма кубов чётных чисел от 0 до N - "<<S<<endl;
    return 0;
}
