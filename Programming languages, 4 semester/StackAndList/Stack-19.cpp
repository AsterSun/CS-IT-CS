#include "pch.h"
#include<iostream>
#include<string>

using namespace std;

struct queue {
	int inf;
	queue *next;
};

void push(queue *&h, queue *&t, int x) {
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

int pop(queue *&h, queue *&t) {
	queue *r = h;
	int i = h -> inf;
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
	int x;
	int max = 0;
	for (int i = 0; i < n; i++) {
		cin >> x;
		if (x > max)
			max = x;
		push(head, tail, x);
	}
	queue *headResult = NULL;
	queue *tailResult = NULL;
	queue *headBuf = NULL;
	queue *tailBuf = NULL;
	int buf;
	for (int i = 0; i < n + 1; i++) {
		buf = pop(head, tail);
		if (buf == max)
		{
			push(headResult, tailResult, buf);
			i = n + 1;
		}
		else
			push(headBuf, tailBuf, buf);
	}
	while (head) {
		x = pop(head, tail);
		push(headResult, tailResult, x);
	}
	while (headBuf) {
		x = pop(headBuf, tailBuf);
		push(headResult, tailResult, x);
	}
	while (headResult)
		cout << pop(headResult, tailResult) << " ";
	cout << endl;
	return 0;
}