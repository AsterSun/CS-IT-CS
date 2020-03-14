#include <iostream>
#include <stdio.h>

using namespace std;

struct list {
	int inf;
	list *next;
	list *prev;
};

void push(list *&h, list*&t, int x) {
	list *r = new list;
	r->inf = x;
	r->next = NULL;
	if (!h && !t) {
		r->prev = NULL;
		h = r;
	}
	else {
		t->next = r;
		r->prev = t;
	}
	t = r;
}

void push_start(list *&h, list*&t, int x) {
	list *r = new list;
	r->inf = x;
	r->prev = NULL;
	if (!h && !t) {
		r->next = NULL;
		t = r;
	}
	else {
		h->prev = r;
		r->next = h;
	}
	h = r;
}

void print(list *h, list *t) {
	list *p = h;
	while (p) {
		cout << p->inf << " ";
		p = p->next;
	}
}

list *find(list *h, list *t, int x) {
	list *p = h;
	while (p) {;
		if (p->inf == x) break;
		p = p->next;
	}
	return p;
}

void insert_after(list *&h, list *&t, list *r, int y) {
	list *p = new list;
	p->inf = y;
	if (r == t) {
		p->next = NULL;
		p->prev = r;
		r->next = p;
		t = p;
	}
	else {
		r->next->prev = p;
		p->next = r->next;
		p->prev = r;
		r->next = p;
	}
}

void del_node(list *&h, list *&t, list *r) {
	if (r == h && r == t)
		h = t = NULL;
	else if (r == h) {
		h = h->next;
		h->prev = NULL;
	}
	else if (r == t) {
		t = t->prev;
		t->next = NULL;
	}
	else {
		r->next->prev = r->prev;
		r->prev->next = r->next;
	}
	delete r;
}

void del_list(list *&h, list *&t) {
	while (h) {
		list *p = h;
		h = h->next;
		if (h == NULL)
			t = NULL;
		else
			h->prev = NULL;
		delete p;
	}
}

int main()
{
	list *head = NULL;
	list *tail = NULL;
	int n;
	cout << "n = ";
	cin >> n;
	cout << "Enter numbers:" << endl;
	int x;
	cin >> x;
	int min = x;
	push(head, tail, x);
	for (int i = 1; i < n; i++) {
		cin >> x;
		if (x < min)
			min = x;
		push(head, tail, x);
	}
	int vrs;
	cout << "Enter variable:" << endl;
	cin >> vrs;
	list *rcl = find(head, tail, min);
	if (rcl->prev != nullptr)
		insert_after(head, tail, rcl->prev, vrs);
	else
		push_start(head, tail, vrs);
	while (rcl != NULL) {
		if (rcl->next != nullptr) {
			rcl = find(rcl->next, tail, min);
			if (rcl != NULL)
				insert_after(head, tail, rcl->prev, vrs);
		}
		else
			break;
	}
	print(head, tail);
	del_list(head, tail);
	return 0;
}