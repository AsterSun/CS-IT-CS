#include<iostream>
#include<fstream>
#include<string>
#include<vector>
#include<iomanip>
#include<cstdlib>
using namespace std;

ifstream in("in.txt");
ofstream out("out.txt");


struct date {
	int dd, mm, yy;};
struct people {
	string Surname;
	string Work;
	date DateOfBirth;
	int AgeOfWork;
	int Salary;
};

date Str_to_Date(string str) {
	 date x;
	 string temp = str.substr(0, 2);
	 x.dd = atoi(temp.c_str());
	 temp = str.substr(3, 2);
	 x.mm = atoi(temp.c_str());
	 temp = str.substr(6, 4);
	 x.yy = atoi(temp.c_str());
	 return x;

}

void ViborSort(people*p, int n) {
	for (int i=0; i < n ; i++) {
		int imin=i;
		for (int j = i + 1; j < n ; j++) {
			if ((p[j].Salary < p[imin].Salary)||(p[j].Salary== p[imin].Salary&& ((p[j].DateOfBirth.yy > p[imin].DateOfBirth.yy) || (p[j].DateOfBirth.yy == p[imin].DateOfBirth.yy&&p[j].DateOfBirth.mm > p[imin].DateOfBirth.mm) || (p[j].DateOfBirth.yy == p[imin].DateOfBirth.yy&&p[j].DateOfBirth.mm == p[imin].DateOfBirth.mm&&p[j].DateOfBirth.dd > p[imin].DateOfBirth.dd)))||(p[j].Salary == p[imin].Salary && (p[j].DateOfBirth.yy == p[imin].DateOfBirth.yy&&p[j].DateOfBirth.mm == p[imin].DateOfBirth.mm&&p[j].DateOfBirth.dd == p[imin].DateOfBirth.dd) &&p[j].AgeOfWork < p[imin].AgeOfWork))
				imin = j;
		}
		swap(p[i], p[imin]);
	}
}

void Read(people *p, int n) {
	for (int i = 0; i < n; i++) {
		string tmp;
		in >> p[i].Surname >> p[i].Work >> tmp >> p[i].AgeOfWork >> p[i].Salary;
		p[i].DateOfBirth = Str_to_Date(tmp);
	}
}

void Print(people *p, int n) {
	for (int i = 0; i < n; i++) {
		out << setw(10) << left << p[i].Surname;
		out << setw(10) << left << p[i].Work;
		if (p[i].DateOfBirth.dd < 10) out << left << '0' << p[i].DateOfBirth.dd << '.';
		else out << left << p[i].DateOfBirth.dd << '.';
		if (p[i].DateOfBirth.mm < 10) out << '0' << p[i].DateOfBirth.mm << '.';
		else out << p[i].DateOfBirth.mm << '.';
	    out << left << setw(6) << p[i].DateOfBirth.yy;
		out << setw(10) << left << p[i].AgeOfWork;
		out << left << setw(10) << p[i].Salary << endl;
	}
}

int main() {
	setlocale(LC_ALL, "Russian");
	int n;
	in >> n;
	people *p = new people[n];
	Read(p,n);
	in.close();
	ViborSort(p,n);
	Print(p, n);
	out.close();
	return 0;}
