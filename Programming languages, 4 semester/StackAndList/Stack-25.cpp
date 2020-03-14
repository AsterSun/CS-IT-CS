#include "pch.h"
#include<iostream>
#include<string>

using namespace std;

struct stack {
	int inf;
	stack *next;
};

void push(stack *&h, int x) {
	stack *r = new stack;
	r->inf = x;
	r->next = h;
	h = r;
}

int pop(stack *&h) {
	int i = h->inf;
	stack *r = h;
	h = h->next;
	delete r;
	return i;
}

int doEx(string inputEx) {
	stack *buf = NULL;
	int a, b;
	for (int i = 0; i < inputEx.length(); i++) {
		if (isdigit(inputEx[i]))
			push(buf, (int)inputEx[i] - 48);
		else {
			b = pop(buf);
			a = pop(buf);
			int res;
			switch (inputEx[i]) {
			case '+':
				res = a + b;
				break;
			case '*':
				res = a * b;
				break;
			case '/':
				res = a / b;
				break;
			case '-':
				res = a - b;
				break;
			}
			push(buf, res);
		}
	}
	return pop(buf);
}


int main() {
	string inputEx;
	getline(cin, inputEx);
	cout << doEx(inputEx);
	return 0;
}
