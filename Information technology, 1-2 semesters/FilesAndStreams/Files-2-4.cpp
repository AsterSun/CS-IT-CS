#include <iostream>
#include <fstream>

using namespace std;

struct Buyer
{
    string firstName;
    string lastName;
    string secondName;
    string sex;
    string nationality;
    double height;
    double weight;
    string birthDate;
    string telNumber;
    string city;
    string street;
    string houseNumber;
    string cardNumber;
    string billNumber;
};
int main()
{
    setlocale(LC_ALL, "russian");
    ifstream inp("F7-2-4.txt");
    Buyer br;
    while(inp.peek()!=EOF)
    {
        inp >> br.firstName >> br.lastName >> br.secondName >> br.sex >> br.nationality >>
        br.height >> br.weight >> br.birthDate >> br.city >> br.city >> br.street >> br.houseNumber >>
        br.cardNumber >> br.billNumber;
        if(br.city == "г.ќдесса")
            cout << br.firstName << " " << br.lastName << " " << br.secondName << " " << br.sex << " " <<
            br.nationality << " " << br.height << " " << br.weight << " " << br.birthDate << " " <<
            br.city << " " << br.city << " " << br.street << " " << br.houseNumber << " " <<
            br.cardNumber << " " << br.billNumber;
    }
    return 0;
}
