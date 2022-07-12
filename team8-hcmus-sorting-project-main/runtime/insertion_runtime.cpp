#include "sort.h"

void InsertionSort_runtime(int a[], int n)
{
	for (int i = 1; i < n; i++)
	{
		int temp = a[i], j;
		for (j = i - 1; j >= 0; j--)
		{
			if (a[j] > temp)
				swap(a[j], a[j + 1]);
			else
				break;
		}
		a[j + 1] = temp;
	}
}