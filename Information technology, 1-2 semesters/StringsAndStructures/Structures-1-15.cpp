#include <iostream>
#include <fstream>
#include <string>
#include <stdlib.h>

using namespace std;

struct time{
    int hour;
    int minute;
    int second;
};

int ElapsedTime(time a, time b){
    return (abs(a.hour - b.hour) * 3600 + abs(a.minute - b.minute) * 60 + abs(a.second - b.second));
}

int main()
{
    ifstream in("in.txt");
    time x, y;
    string in1, in2;
    in >> in1 >> in2;
    int razd1 = -1, razd2 = -1;
        for(int i = 0; i < in1.length(); i++)
        {
            if ((razd1 == -1)&&(in1[i] == ':'))
            razd1 = i;
            if ((razd1 != -1)&&(in1[i] == ':'))
            razd2 = i;
        }
    x.hour = atoi((in1.substr(0,razd1)).c_str());
    x.minute = atoi((in1.substr(razd1 + 1, razd2 - razd1)).c_str());
    x.second = atoi((in1.substr(razd2 + 1, in1.length() - razd2)).c_str());
    razd1 = -1, razd2 = -1;
            for(int i = 0; i < in2.length(); i++)
        {
            if ((razd1 == -1)&&(in2[i] == ':'))
            razd1 = i;
            if ((razd1 != -1)&&(in2[i] == ':'))
            razd2 = i;
        }
    y.hour = atoi((in2.substr(0,razd1)).c_str());
    y.minute = atoi((in2.substr(razd1 + 1, razd2 - razd1)).c_str());
    y.second = atoi((in2.substr(razd2 + 1, in2.length() - razd2)).c_str());
    int answer = ElapsedTime(x, y);
    cout << "Elapsed seconds = " << answer << endl;
    return 0;
}
