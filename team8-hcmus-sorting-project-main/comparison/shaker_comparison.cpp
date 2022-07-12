#include "sort.h"
void ShakerSort_comparison(int a[], int n, unsigned long long int &count)
{
	count = 0;
	int l = 0;
	int r = n - 1;
	int k = 0, i;
	while (count++ && l < r)
	{
		for (i = l; count++ && i < r; i++)
		{
			if (count++ && a[i] > a[i + 1])
			{
				swap(a[i], a[i + 1]);
				k = i;
			}
		}
		r = k;
		for (i = r; count++ && i > l; i--)
		{
			if (count++ && a[i] < a[i - 1])
			{
				swap(a[i], a[i - 1]);
				k = i;
			}
		}
		l = k;
	}
}
