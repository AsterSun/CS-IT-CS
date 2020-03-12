#include <iostream>
#include <fstream>

using namespace std;

int main()
{
    setlocale(LC_ALL, "russian");
    ifstream inp("F7-1-17.txt");
    ofstream outp("G7-1-17.txt");
    int x;
    while(inp.peek()!=EOF)
        {
        inp >> x;
        if ((x % 3 == 0) && (x % 7 != 0))
            outp << x << " ";
        }
    return 0;
}
