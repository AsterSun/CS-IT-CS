#include <iostream>

using namespace std;

int main() {
   setlocale (LC_ALL, "russian");

   int n; cout << "¬ведите максимальную степень многочлена:" << endl;
   cin >> n;
   n++;
   float a;
   cout << "¬ведите а:" << endl;
   cin >> a;

   float *arr = new float[n];

   cout << "¬ведите коэффициенты х, начина€ со старшего:" << endl;

   for (int i = n - 1; i >= 0; i--)
      cin >> arr[i];

   int t = n + 2;
   float *b = new float[t];
   for (int i = 0; i < t; i++)
      b[i] = 0;

   for (int i = 0; i < n; i++){
      b[i + 2] += arr[i];
      b[i + 1] += 2 * a * arr[i];
      b[i] += a * a * arr[i];
   }

   delete [] arr;

   for (int i = t - 1; i >= 0; i--)
      cout << b[i] << " ";

   delete [] b;

   return 0;
}
