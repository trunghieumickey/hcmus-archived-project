#include "sort.h"

void merge(int *a, int left, int mid, int right, unsigned long long int &count)
{
	int n_firstArray = (mid - left) + 1, n_secondArray = right - mid;
	int *firstArray = new int[n_firstArray];
	int *secondArray = new int[n_secondArray];
	for (int i = 0; ++count && i < n_firstArray; i++)
	{
		firstArray[i] = a[left + i];
	}
	for (int i = 0; ++count && i < n_secondArray; i++)
	{
		secondArray[i] = a[mid + 1 + i];
	}

	int i = 0, j = 0, k = left;
	while (++count && i < n_firstArray && j < n_secondArray)
	{
		if (++count && firstArray[i] < secondArray[j])
		{
			a[k++] = firstArray[i++];
		}
		else
		{
			a[k++] = secondArray[j++];
		}
	}
	while (++count && i < n_firstArray)
	{
		a[k++] = firstArray[i++];
	}
	while (++count && i < n_secondArray)
	{
		a[k++] = secondArray[i++];
	}
}

void split(int a[], int left, int right, unsigned long long int &count)
{
	if (++count && left < right)
	{
		int mid = (left + right) / 2;
		split(a, left, mid, count);
		split(a, mid + 1, right, count);
		merge(a, left, mid, right, count);
	}
}

void MergeSort_comparison(int a[], int n, unsigned long long int &count)
{
	count = 0;
	int left = 0, right = n - 1;
	split(a, left, right, count);
}