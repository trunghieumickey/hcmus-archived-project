#include "sort.h"

void FlashSort_runtime(int a[], int n)
{
	int minval = a[0], maxi = 0, m = 0.45 * n;
	for (int i = 1; i < n; i++)
	{
		minval = min(minval, a[i]);
		if (a[maxi] < a[i])
			maxi = i;
	}
	double c = 1.0 * (m - 1) / (a[maxi] - minval);
	int *L = new int[m];
	memset(L, 0, m * sizeof(L));
	for (int i = 0; i < n; i++)
	{
		L[int(c * (a[i] - minval))]++;
	}
	for (int i = 1; i < m; i++)
	{
		L[i] += L[i - 1];
	}

	swap(a[maxi], a[0]);
	int i = 0, k = m - 1, nmove = 0, flash;
	while (nmove < n - 1)
	{
		while (i > L[k] - 1)
		{
			i++;
			k = c * (a[i] - minval);
		}
		flash = a[i];
		if (k < 0)
			break;
		while (i != L[k])
		{
			k = c * (flash - minval);
			L[k]--;
			swap(flash, a[L[k]]);
			nmove++;
		}
	}
	InsertionSort_runtime(a, n);
}