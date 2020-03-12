#include <iostream>
#include <fstream>

using namespace std;

struct Workman
{
    string lastName;
    string firstName;
    string secondName;
    string city;
    string street;
    string houseNumber;
    string nationality;
    string birthDate;
    string group;
    int tabelNumber;
    string education;
    int accessYear;
};
int main()
{
    setlocale(LC_ALL, "russian");
    ifstream inp("F7-2-8.txt");
    Workman wm;
    while(inp.peek()!=EOF)
    {
        inp >> wm.lastName >> wm.firstName >> wm.secondName >> wm.city >> wm.street >> wm.houseNumber >> wm.nationality >>
        wm.birthDate >> wm.group >> wm.tabelNumber >> wm.education >> wm.accessYear;
        if(wm.accessYear == 2010)
            cout << wm.lastName << " " << wm.firstName << " " << wm.secondName << " " << wm.city << " " << wm.street << " " << wm.houseNumber << " " << wm.nationality << " " <<
            wm.birthDate << " " << wm.group << " " << wm.tabelNumber << " " << wm.education << " " << wm.accessYear << endl;
    }
    return 0;
}
