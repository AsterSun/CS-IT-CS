#include <iostream>
#include <fstream>

using namespace std;

int main() {
  setlocale(LC_ALL, "russian");
  double x, y, dif;
  ifstream inp("F7-1-7.txt");
  if(!inp) {
    cout << "Файл не найден" << endl;
    return 0;
  }
  inp >> x >> y;
  if(!inp) {
    cout << "Ошибка" << endl;
    return 0;
  }
  do inp >> y;
  while(inp);
  dif = x - y;
  cout << "Разность первого и последнего числа в файле - " << dif << endl;
  return 0;
}
