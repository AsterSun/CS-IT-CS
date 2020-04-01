#include <iostream>
#include <cmath>
#include <queue>
using namespace std;

struct tree {
	int inf;
	tree *right;
	tree *left;
};

tree *node(int x) {
	tree *n = new tree;
	n->inf = x;
	n->left = n->right = NULL;
	return n;
}

void create(tree *&tr, int n) {
	int x;
	if (n > 0) {
		cin >> x;
		tr = node(x);
		int nl = n / 2;
		int nr = n - nl - 1;
		create(tr->left, nl);
		create(tr->right, nr);
	}
}

void preorder(tree *tr) {
	if (tr) {
		cout << tr->inf << " ";
		preorder(tr->left);
		preorder(tr->right);
	}
}

int lefth(tree *tr) {
	int k = 0;
	tree *x = tr;
	while (x) {
		k++;
		x = x->left;
	}
	return k - 1;
}

int righth(tree *tr) {
	int k = 0;
	tree *x = tr;
	while (x) {
		k++;
		x = x->right;
	}
	return k - 1;
}

void add(tree *&tr, int x) {
	tree *n = node(x);
	tree *y = tr;
	if (lefth(tr) == righth(tr)) {
		do {
			y = y->left;
		}
		while (y->left);
		if (!y->left) y->left = n;
		else y->right = n;
	}
	else {
		do {
			y = y->right;
		}
		while (y->right);
		if (!y->left) y->left = n;
		else y->right = n;
	}
}

void find(tree *tr, int x, tree *&res) {
	if (tr) {
		if (tr->inf == x) {
			res = tr;
		}
		else {
			find(tr->left, x, res);
			find(tr->right, x, res);
		}
	}
}

void del_n(tree *tr, int val) {
	tree *y;
	find(tr, val, y);
	if (y) {
		if (lefth(tr) == 0) tr = NULL;
			else if (lefth(tr) != righth(tr)) {
			tree *x = tr->left;
			do {
				x = x->left;
			}
			while (x->left->left);
			if (x->right) {
				if (x->right->inf == val) {
					x->right = NULL;
				}
				else {
					y->inf = x->right->inf;
					x->right = NULL;
				}
				delete x->right;
			}
			else {
				if (x->left->inf == val) {
					x->left = NULL;
				}
				else {
					y->inf = x->left->inf;
					x-> left = NULL;
				}
				delete x->left;
			}
		}
		else {
			tree *x = tr->right;
			do {
				x = x->right;
			}
			while (x->right->right);
			if (x->right) {
				if (x->right->inf == val) {
					x->right = NULL;
				}
				else {
					y->inf = x->right->inf;
					x-> right = NULL;
				}
				delete x->right;
			}
			else {
				if (x->left->inf == val) {
					x->left = NULL;
				}
				else {
					y->inf = x->left->inf;
					x->left = NULL;
				}
				delete x->left;
			}
		}
	}
}

void print(tree *tr, int k) {
	if (!tr) cout << "Empty tree\n";
	else {
		queue<tree*> cur, next;
		tree *r = tr;
		cur.push(r);
		int j = 0;
		while (cur.size()) {
			if (j == 0) {
				for (int i = 0; i < (int)pow(2.0, k) - 1; i++)
					cout << " ";
			}
			tree *buf = cur.front();
			cur.pop();
			j++;
			if (buf) {
				cout << buf->inf;
				next.push(buf->left);
				next.push(buf->right);
				for (int i = 0; i < (int)pow(2.0, k + 1) - 1; i++)
					cout << " ";
			}
				if (!buf) {
				for (int i = 0; i < (int)pow(2.0, k + 1) - 1; i++)
					cout << " ";
					cout << " ";
			}
			if (cur.empty()) {
				cout << endl;
				swap(cur, next);
				j = 0;
				k--;
			}
		}
	}
}

void printLevel(tree *tr, int lvl, int buf) { // Функция печати определённого уровня
	if (tr) {                                 // lvl - необходимый уровень, buf - уровень, на котором
		buf++;                                // находится текущая функция. Если текущий уровень
		if (lvl == buf) {                     // равен нужному - выводим значение. Иначе
			cout << tr->inf << " ";           // идём ниже.
		}
		printLevel(tr->left, lvl, buf);
		printLevel(tr->right, lvl, buf);
	}
}

void printAllLevels(tree *tr, int n) {					// Функция вывода всех уровней.
	int lvls = int(log((float)n) / log((float)2.0));    // lvls - количество уровней
	for (int i = 0; i <= lvls; i++) {                   // поочерёдно выводим каждый уровень
		cout << endl <<  "Level " << i << ": ";
		printLevel(tr, i, -1);
	}
}

int main() {
	tree *tr = NULL;
	int n;
	cin >> n;
	int k = int(log((float)n) / log((float)2.0));
	create(tr, n);
	cout << endl << "Full tree:" << endl << endl; // Выводим полное дерево
	print(tr, k);
	printAllLevels(tr, n); // Выводим дерево по уровням
	cout << endl;
	return 0;
}