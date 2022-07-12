#include "sort.h"
void ShakerSort_runtime(int a[], int n)
{
	int l = 0;
	int r = n - 1;
	int k = 0, i;
	while (l < r)
	{
		for (i = l; i < r; i++)
		{
			if (a[i] > a[i + 1])
			{
				swap(a[i], a[i + 1]);
				k = i;
			}
		}
		r = k;
		for (i = r; i > l; i--)
		{
			if (a[i] < a[i - 1])
			{
				swap(a[i], a[i - 1]);
				k = i;
			}
		}
		l = k;
	}
}