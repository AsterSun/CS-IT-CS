#include <iostream>
#include <fstream>

using namespace std;

struct point {
	int x;
	int y;
};

int point_line(point p1, point p2, int n, point *p) {
	int count = 0;
	for (int i = 0; i < n; i++)
	    {
		if ((p1.y - p2.y)*p[i].x + (p2.x - p1.x)*p[i].y + (p1.x * p2.y - p2.x*p1.y) == 0)
			count++;
	    }
	return count;
}

int main() {
    ifstream in("in.txt");
    ofstream out("out.txt");
	int n;
	in >> n;
	int max_c = 1;
	point *a = new point[n];
	for (int i = 0; i < n; i++)
	    {
		in >> a[i].x >> a[i].y;
	    }
	int k = 1;
	for (int i = 0; i < n - 1; i++)
		for (int j = i + 1; j < n; j++)
		    {
			int c = point_line(a[i], a[j], n, a);
			if (c > max_c) max_c = c;
		    }

	cout << "Maximum of points on the line - " << max_c << endl;

	in.close();
	out.close();
	delete[]a;
	return 0;
}
