#include "sort.h"

void InsertionSort_comparison(int a[], int n, unsigned long long int &count)
{
	for (int i = 1; ++count && i < n; i++)
	{
		int temp = a[i], j;
		for (j = i - 1; ++count && j >= 0; j--)
		{
			if (++count && a[j] > temp)
				swap(a[j], a[j + 1]);
			else
				break;
		}
		a[j + 1] = temp;
	}
}