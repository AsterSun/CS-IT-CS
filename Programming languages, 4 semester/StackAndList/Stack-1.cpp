#include "pch.h"
#include<iostream>
#include<string>

using namespace std;

struct stack {
	string inf;
	stack *next;
};

void push(stack *&h, string x) {
	stack *r = new stack;
	r -> inf = x;
	r -> next = h;
	h = r;
}

string pop(stack *&h) {
	string i = h -> inf;
	stack *r = h;
	h = h -> next;
	delete r;
	return i;
}

string headout(stack *&h) {
	return h -> inf;
}

stack *result(stack *&h, string letter) {
	stack *res = NULL;
	string s, slast;
	while (headout(h) != "") {
		s = pop(h);
		slast = s[s.length() - 1];
		if (slast.compare(letter))
			push(res, s);
		}
	return res;
}

int main() {
	int n;
	cout << " n = ";
	cin >> n;
	stack *head = NULL;
	string x;
	for (int i = 0; i < n + 1; i++) {
		getline (cin, x);
		push(head, x);
	}
	cout << "char =" << endl;
	string letter;
	getline(cin, letter);
	stack *res = NULL;
	res = result(head, letter);
	while (res)
		cout << pop(res) << " ";
		cout << endl;
	return 0;
}