#include <iostream>
#include <iomanip>
#include <fstream>
#include <vector>
#include <cmath>

using namespace std;

ifstream in("in.txt");
ofstream out("out.txt");

void ShellSort(int *A, int n, int str) {
    int q;
    for (q = 0; pow(3, q) - 1 < n; q++){}
	int d = pow(3, q) - 1;
	while (d != 0) {
		for (int i = 0; i < (n - d); i++) {
			int j = i;
			if(str % 2 == 0){
			while ((j >= 0) && (A[j] < A[j+d])) {
				swap(A[j], A[j + d]);
				j--;
			}
			}
			else{
			    while ((j >= 0) && A[j] > A[j+d]) {
				swap(A[j], A[j + d]);
				j--;
			} cout << 3;
        }
		}
		q--;
		if (d != 1){
		if(q > 0){
		d = pow(3, q) - 1;}
		else d = 1;
		}
		else
        d = 0;

	}
}

int main() {
	setlocale(LC_ALL, "russian");
	int n;
	in >> n;
	int** arr = new int*[n];

	for (int i = 0; i < n; i++)
		arr[i] = new int[n];
	for (int i = 0; i < n; i++)
		for (int j = 0; j < n; j++)
			in >> arr[i][j];
			cout << "Массив введён" << endl;;

	for (int p = 0; p < n; p++){
    	ShellSort(arr[p], n, p);
    	}
	for (int i = 0; i < n; i++) {
		out << endl;
		for (int j = 0; j < n; j++)
			out << setw(5) << arr[i][j];
	}

	for (int i = 0; i < n; i++)
		delete[] arr[i];
	delete[]arr;
	return 0;
}
