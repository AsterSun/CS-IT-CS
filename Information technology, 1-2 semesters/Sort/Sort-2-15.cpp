#include <iostream>
#include <iomanip>
#include <fstream>
#include <vector>
#include <cmath>

using namespace std;

ifstream in("in.txt");
ofstream out("out.txt");

void VstavkaSort(vector<int> &A) {
	for (int i = 1; i < A.size(); i++) {
		int j = i;
		while ((j > 0) && (A[j] > A[j - 1])) {
			swap(A[j], A[j - 1]);
			j--;
		}
	}
}

int main() {
	setlocale(LC_ALL, "russian");
	int n;
	in >> n;
	int K = 2;
	int** array = new int*[n];

	for (int i = 0; i < n; i++)
		array[i] = new int[n];
	for (int i = 0; i < n; i++)
		for (int j = 0; j < n; j++)
			in >> array[i][j];

	for (int k = 1; k < 2 * n - 2; k++) {
		vector <int> vec;
		for (int i = 0; i < n; i++)
			if ((k - i < n) && (k - i >= 0))
				vec.push_back(array[i][k - i]);
		VstavkaSort(vec);
		int l = 0;
		for (int i = 0; i < n; i++)
			if ((k - i < n) && (k - i >= 0)) {
				array[i][k - i] = vec[l];
				l++;
			}
		vec.clear();
	}

	for (int i = 0; i < n; i++) {
		out << endl;
		for (int j = 0; j < n; j++)
			out << setw(5) << array[i][j];
	}

	for (int i = 0; i < n; i++)
		delete[] array[i];
	delete[]array;
	return 0;
}
