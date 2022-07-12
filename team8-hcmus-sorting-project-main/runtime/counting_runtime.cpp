#include "sort.h"
void CountingSort_runtime(int a[], int n)
{
	int max = a[0];
	for (int i = 1; i < n; i++)
		if (a[i] > max)
			max = a[i];
	int *count = new int[max + 1];
	for (int i = 0; i <= max; i++)
		count[i] = 0;
	for (int i = 0; i < n; i++)
		count[a[i]]++;
	for (int i = 1; i <= max; i++)
		count[i] += count[i - 1];
	int *temp = new int[n];
	for (int i = 0; i < n; i++)
	{
		temp[count[a[i]] - 1] = a[i];
		count[a[i]]--;
	}
	for (int i = 0; i < n; i++)
		a[i] = temp[i];
	delete[] count;
	delete[] temp;
}