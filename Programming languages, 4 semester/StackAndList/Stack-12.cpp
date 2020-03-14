#include "pch.h"
#include<iostream>
#include<string>

using namespace std;

struct queue {
	string inf;
	queue *next;
};

void push(queue *&h, queue *&t, string x) {
	queue *r = new queue; 
	r -> inf = x;
	r -> next = NULL;
	if (!h && !t) {
		h = t = r;
	}
	else {
		t -> next = r;
		t = r;
	}
}

string pop(queue *&h, queue *&t) {
	queue *r = h;
	string i = h -> inf;
	h = h -> next;
	if (!h)
	t = NULL;
	delete r;
		return i;
}

int main() {
	int n;
	cout << " n = ";
	cin >> n;
	queue *head = NULL;
	queue *tail = NULL;
	string x;
	for (int i = 0; i < n; i++) {
		getline(cin, x);
		push(head, tail, x);
	}
	getline(cin, x);
	string lastWord;
	push(head, tail, x);
	lastWord = x;
	queue *headResult = NULL;
	queue *tailResult = NULL;
	string buf;
	for (int i = 0; i < n + 1; i++) {
		buf = pop(head, tail);
		if (buf.compare(lastWord))
			push(headResult, tailResult, buf);
	}
	while (headResult)
		cout << pop(headResult, tailResult) << " ";
	cout << endl;
	return 0;
}