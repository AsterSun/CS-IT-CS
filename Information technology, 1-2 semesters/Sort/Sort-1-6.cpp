#include<iostream>
#include<fstream>
#include<string>
#include<iomanip>

using namespace std;

ifstream in("in.txt");
ofstream out("out.txt");



struct people {
	string surname;
	string work;
	string dateOfBirth;
	int ageOfWork;
	int moneyPay;
};

void ShellaSort(people*p, int n) {
	int d = n / 2;
	while (d > 0) {
		for (int i = 0; i < (n - d); i++) {
			int j = i;
			while ((j >= 0) && (p[j].surname > p[j+d].surname || (p[j].surname == p[j + d].surname && p[j].work > p[j + d].work))) {
				swap(p[j], p[j + d]);
				j--;
			}
		}
		d = d/2;

	}
}

void Read(people *p,int n) {
	for (int i = 0; i < n; i++) {
		in >> p[i].surname >> p[i].work >> p[i].dateOfBirth >> p[i].ageOfWork >> p[i].moneyPay;
	}
}

void Print(people *p, int n) {
	for (int i = 0; i < n; i++) {
		out << setw(10) << left << p[i].surname;
		out << setw(10) << left << p[i].work;
		out << setw(11) << left << p[i].dateOfBirth;
		out << setw(10) << left << p[i].ageOfWork;
		out << setw(10) << left << p[i].moneyPay <<endl;
	}
}

int main() {
	setlocale(LC_ALL, "russian");
	int n;
	in >> n;
	people *p = new people[n];
	Read(p,n);
	in.close();
	ShellaSort(p,n);
	Print(p, n);
	out.close();

	return 0;
}
