#include <iostream>

using namespace std;

int main() {
   setlocale (LC_ALL, "russian");

   int n; cout << "¬ведите максимальную степень многочлена:" << endl;
   cin >> n;
   n++;

   float *a = new float[n];

   cout << "¬ведите коэффициенты х, начина€ со старшего:" << endl;

   for (int i = n - 1; i >= 0; i--)
      cin >> a[i];

   float *b = new float[n - 1];
   for (int i = 0; i < n - 1; i++)
            b[i] = 0;

    for (int i = n - 1; i > 0; i--)
        b[i - 1] = a[i] * i;

    float *c = new float[2 * n - 1];
    for ( int i = 0; i < 2 * n - 1; i++)
        c[i] = 0;

    for (int i = n - 1; i > -1; i--)
        for (int j = n - 2; j > -1; j--)
            c[i + j] += a[i] * b[j];
    cout << "ћногочлен P(x)*P'(x) = ";
   for (int i = 2 * n - 3; i > 0; i--)
      cout << c[i] << "x^" << i << " + ";
      cout << c[0];

   delete [] a;
   delete [] b;
   delete [] c;

   return 0;
}
