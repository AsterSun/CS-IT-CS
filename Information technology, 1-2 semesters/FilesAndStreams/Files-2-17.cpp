#include <iostream>
#include <fstream>

using namespace std;

struct Building
{
    string street;
    int buildingNumber;
    string type;
    string floorsNumber;
    string flatsNumber;
    int lifeTime;
    int overhaulTime;
};

int main()
{
    setlocale(LC_ALL, "russian");
    ifstream inp("F7-2-17.txt");
    Building bd;
    while(inp.peek()!=EOF)
    {
        inp >> bd.street >> bd.buildingNumber >> bd.type >> bd.floorsNumber >> bd.flatsNumber >> bd.lifeTime >> bd.overhaulTime;
        if(bd.lifeTime >= 50)
            cout << bd.street << " " << bd.buildingNumber << " " << bd.type << " " << bd.floorsNumber << " " << bd.flatsNumber << " " << bd.lifeTime << " " << bd.overhaulTime;
    }
    return 0;
}
