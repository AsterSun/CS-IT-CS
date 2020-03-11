#include <iostream>
#include <cstring>
using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    int d, m;
    cout << "Введите номер карты и номер масти" << endl;
    cin >>d>>m;
    switch (d){
    case 6: cout<<"Шестёрка "; break;
    case 7: cout<<"Семёрка "; break;
    case 8: cout<<"Восьмёрка "; break;
    case 9: cout<<"Девятка "; break;
    case 10: cout<<"Десятка  "; break;
    case 11: cout<<"Валет "; break;
    case 12: cout<<"Дама "; break;
    case 13: cout<<"Король "; break;
    case 14: cout<<"Туз "; break;
    default: cout<<"Ошибка ";}
    switch (m){
    case 1: cout<<"пики "; break;
    case 2: cout<<"треф"; break;
    case 3: cout<<"бубей"; break;
    case 4: cout<<"червы"; break;
    default: cout<<"Ошибка";
    }
    return 0;
}
