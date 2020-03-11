#include <iostream>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    int Day, Month, Year;
    cout<< "¬ведите дату" << endl;
    cin>>Day>>Month>>Year;
    switch (Month){
    case 1: cout<<Day<<" €нвар€ "<<Year<<" года"; break;
    case 2: cout<<Day<<" феврал€ "<<Year<<" года"; break;
    case 3: cout<<Day<<" марта "<<Year<<" года"; break;
    case 4: cout<<Day<<" апрел€ "<<Year<<" года"; break;
    case 5: cout<<Day<<" ма€ "<<Year<<" года"; break;
    case 6: cout<<Day<<" июн€ "<<Year<<" года"; break;
    case 7: cout<<Day<<" июл€ "<<Year<<" года"; break;
    case 8: cout<<Day<<" августа "<<Year<<" года"; break;
    case 9: cout<<Day<<" сент€бр€ "<<Year<<" года"; break;
    case 10: cout<<Day<<" окт€бр€ "<<Year<<" года"; break;
    case 11: cout<<Day<<" но€бр€ "<<Year<<" года"; break;
    case 12: cout<<Day<<" декабр€ "<<Year<<" года"; break;
    default: cout<<"ќшибка в дате";
    }
    return 0;
}
