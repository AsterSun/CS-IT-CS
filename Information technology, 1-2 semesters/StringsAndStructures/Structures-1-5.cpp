#include <iostream>
#include <string>
#include <cstdlib>
#include <fstream>
#include <sstream>

using namespace std;

template <typename T>
string toString(T val)
{
    ostringstream oss;
    oss << val;
    return oss.str();
}


struct Train
{
    string departPoint;
    string arrivalPoint;
    string departTime;
    string departDate;
    string travelTime;
    string ArriveTime(){
        string Date = departDate;
        string Time = departTime;
        string Travel = travelTime;
        int seconds;
        int minutes;
        int hours;
        int tseconds;
        int tminutes;
        int thours;
        int day;
        int month;
        int year;
        int razd1 = -1, razd2 = -1;
        for(int i = 0; i < Date.length(); i++)
        {
            if ((razd1 == -1)&&(Date[i] == '.'))
            razd1 = i;
            if ((razd1 != -1)&&(Date[i] == '.'))
            razd2 = i;
        }
        day = atoi((Date.substr(0,razd1)).c_str());
        month = atoi((Date.substr(razd1 + 1, razd2 - razd1)).c_str());
        year = atoi((Date.substr(razd2 + 1, Date.length() - razd2)).c_str());
        razd1 = -1, razd2 = -1;
        for(int i = 0; i < Time.length(); i++)
        {
            if ((razd1 == -1)&&(Time[i] == ':'))
            razd1 = i;
            if ((razd1 != -1)&&(Time[i] == ':'))
            razd2 = i;
        }
        hours = atoi((Time.substr(0,razd1)).c_str());
        minutes = atoi((Time.substr(razd1 + 1, razd2 - razd1)).c_str());
        seconds = atoi((Time.substr(razd2 + 1, Time.length() - razd2)).c_str());
        razd1 = -1, razd2 = -1;
        for(int i = 0; i < Travel.length(); i++)
        {
            if ((razd1 == -1)&&(Travel[i] == ':'))
            razd1 = i;
            if ((razd1 != -1)&&(Travel[i] == ':'))
            razd2 = i;
        }
        thours = atoi((Travel.substr(0,razd1)).c_str());
        tminutes = atoi((Travel.substr(razd1 + 1, razd2 - razd1)).c_str());
        tseconds = atoi((Travel.substr(razd2 + 1, Travel.length() - razd2)).c_str());
        unsigned long int insec = 0;
        int *years = new int[year - 2000];
        for (int i = 0; i < year - 2000; i++)
        {
        if(((i + 2000) % 4 == 0) && ((i + 2000) % 100 != 0) || ((i + 2000) % 400 == 0))
            years[i] = 366;
        else
            years[i] = 365;
        }
        int months[12];
        for (int i = 1; i < 13; i++)
        {
            if((i == 1)||(i == 3)||(i == 5)||(i == 7)||(i == 8)||(i == 10)||(i == 12))
                months[i - 1] = 31;
            if((i == 4)||(i == 6)||(i == 9)||(i == 11))
                months[i - 1] = 30;
            if(i == 2)
                if (years[year - 2001] == 366)
                     months[i - 1] = 29;
                else
                     months[i - 1] = 28;
        }
        for(int i = 0; i < year - 2000; i++)
            {
            if(((i + 2000) % 4 == 0) && ((i + 2000) % 100 != 0) || ((i + 2000) % 400 == 0))
                insec += 366 * 24 * 60 * 60;
            else
                insec += 365 * 24 * 60 * 60;
            }
        for(int i = 0; i < month - 1; i++)
                insec += months[i] * 24 * 60 * 60;
        insec += (day - 1) * 24 * 60 * 60;
        insec += hours * 60 * 60;
        insec += minutes * 60;
        insec += seconds;
        unsigned long int tinsec = 0;
        tinsec += thours * 60 * 60;
        tinsec += tminutes * 60;
        tinsec += tseconds;
        unsigned long int ainsec = 0;
        ainsec = insec + tinsec;
        cout << insec << endl;
        cout << tinsec << endl;
        int ayear = 0;
        int amonth = 0;
        int aday = 0;
        int ahour = 0;
        int aminute = 0;
        int asecond = 0;
        for(int i = 0; ainsec >= years[i] * 24 * 60 * 60; i++)
            {
            ainsec -= years[i] * 24 * 60 * 60;
            ayear++;
            }
        for(int i = 0; ainsec >= months[i] * 24 * 60 * 60; i++)
            {
            ainsec -= months[i] * 24 * 60 * 60;
            amonth++;
            }
        for(int i = 0; ainsec >= 24 * 60 * 60; i++)
            {
            ainsec -= 24 * 60 * 60;
            aday++;
            }
        for(int i = 0; ainsec >= 60 * 60; i++)
            {
            ainsec -= 60 * 60;
            ahour++;
            }
        for(int i = 0; ainsec >= 60; i++)
            {
            ainsec -= 60;
            aminute++;
            }
        for(int i = 0; ainsec >= 1; i++)
            {
            ainsec -= 1;
            asecond++;
            }
        aday++;
        amonth++;
        ayear += 2000;
        string answer = toString(ahour) + ":" + toString(aminute) + ":" + toString(asecond) + " " + toString(aday) + "." + toString(amonth) + "." + toString(ayear);
        return answer;
    }
};

int main()
{
    ifstream in("in.txt");
    ofstream out("out.txt");
    int n;
    in >> n;
    Train *tr = new Train[n];
    for (int i = 0; i < n; i++)
        {
        in >> tr[i].departPoint;
        in >> tr[i].arrivalPoint;
        in >> tr[i].departDate;
        in >> tr[i].departTime;
        in >> tr[i].travelTime;
        out << i + 1<< ")" << tr[i].ArriveTime() << endl;
        }
    in.close();
    out.close();
    return 0;
}
