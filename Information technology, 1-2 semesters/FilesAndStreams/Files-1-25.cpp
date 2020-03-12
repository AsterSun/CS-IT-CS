#include <iostream>
#include <fstream>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    ifstream inp("F7-1-25.txt");
    ofstream outp("G7-1-25.txt");
    fstream iop("H7-1-25.txt");
    int x;
    while(inp.peek()!=EOF)
        {
            inp >> x;
            if(x % 2 != 0)
                outp << " " << x;
            else
                iop << " " << x;
        }
    iop.clear();
    iop.seekg(0, ios_base::beg);
    while(iop.peek()!=EOF)
        {
            iop >> x;
            outp << " " << x;
        }
    return 0;
}
