#include "sort.h"

void RadixSort_runtime(int a[], int n)
{
	int maxval = a[0];
	int *b = new int[n];
	for (int i = 1; i < n; i++)
	{
		maxval = max(maxval, a[i]);
	}
	for (int i = 1; maxval / i > 0; i *= 10)
	{
		int subcount[10] = {0};
		for (int j = 0; j < n; j++)
		{
			subcount[(a[j] / i) % 10]++;
		}
		for (int j = 1; j < 10; j++)
		{
			subcount[j] += subcount[j - 1];
		}
		for (int j = n - 1; j >= 0; j--)
		{
			b[subcount[(a[j] / i) % 10] - 1] = a[j];
			subcount[(a[j] / i) % 10]--;
		}
		for (int j = 0; j < n; j++)
			a[j] = b[j];
	}
	delete[] b;
}