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
	while (p) {
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
	int inp;
	for (int i = 0; i < n; i++) {
		cin >> inp;
		push(head, tail, inp);
	}
	list* _ipoint = head;
	while (_ipoint) {
		list* _jpoint = _ipoint;
		while (_jpoint->prev) {
			if (_jpoint->prev->inf > _jpoint->inf) {
				int buf = _jpoint->inf;
				_jpoint->inf = _jpoint->prev->inf;
				_jpoint->prev->inf = buf;
			}
			_jpoint = _jpoint->prev;
		}
		_ipoint = _ipoint->next;
	}
	print(head, tail);
	del_list(head, tail);
	cin >> n;
	return 0;
}

/*for(int i = 1; i < n, i++)
	for(int j = i, j > 0 && a[j-1] > a[j]; j--)
		swap(a[j-1], a[j]);*/