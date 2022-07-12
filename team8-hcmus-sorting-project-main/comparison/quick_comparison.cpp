#include "sort.h"

int Partition(int a[], int left, int right, unsigned long long int &count)
{

	int pivot = a[right];
	int i, j;
	i = (left - 1);
	for (j = left; ++count && j <= right - 1; j++)
	{
		if (++count && a[j] < pivot)
		{
			i++;
			swap(a[i], a[j]);
		}
	}
	swap(a[i + 1], a[right]);
	return (i + 1);
}

void QuickSort_comparisonSub(int a[], int left, int right, unsigned long long int &count)
{
	if (++count && left < right)
	{
		int pi = Partition(a, left, right, count);

		QuickSort_comparisonSub(a, left, pi - 1, count);  // Before pi
		QuickSort_comparisonSub(a, pi + 1, right, count); // After pi
	}
}

void QuickSort_comparison(int a[], int n, unsigned long long int &count)
{
	return QuickSort_comparisonSub(a, 0, n, count);
}