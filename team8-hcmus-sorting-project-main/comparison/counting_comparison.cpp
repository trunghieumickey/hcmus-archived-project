#include "sort.h"

void CountingSort_comparison(int a[], int n, unsigned long long int &count)
{
	int max = a[0];
	for (int i = 1; ++count && i < n; i++)
		if (++count && a[i] > max)
			max = a[i];
	int *subcount = new int[max + 1];
	for (int i = 0; ++count && i <= max; i++)
		subcount[i] = 0;
	for (int i = 0; ++count && i < n; i++)
		subcount[a[i]]++;
	for (int i = 1; ++count && i <= max; i++)
		subcount[i] += subcount[i - 1];
	int *temp = new int[n];
	for (int i = 0; ++count && i < n; i++)
	{
		temp[subcount[a[i]] - 1] = a[i];
		subcount[a[i]]--;
	}
	for (int i = 0; ++count && i < n; i++)
		a[i] = temp[i];
	delete[] subcount;
	delete[] temp;
}