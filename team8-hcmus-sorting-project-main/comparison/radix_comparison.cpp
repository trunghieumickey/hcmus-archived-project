#include "sort.h"

void RadixSort_comparison(int a[], int n, unsigned long long int &count)
{
	int maxval = a[0];
	int *b = new int[n];
	for (int i = 1; ++count && i < n; i++)
	{
		maxval = max(maxval, a[i]);
	}
	for (int i = 1; ++count && maxval / i > 0; i *= 10)
	{
		int subcount[10] = {0};
		for (int j = 0; ++count && j < n; j++)
		{
			subcount[(a[j] / i) % 10]++;
		}
		for (int j = 1; ++count && j < 10; j++)
		{
			subcount[j] += subcount[j - 1];
		}
		for (int j = n - 1; ++count && j >= 0; j--)
		{
			b[subcount[(a[j] / i) % 10] - 1] = a[j];
			subcount[(a[j] / i) % 10]--;
		}
		for (int j = 0; ++count && j < n; j++)
			a[j] = b[j];
	}
	count = count;
	delete[] b;
}