#include "sort.h"

void merge(int *a, int left, int mid, int right)
{
	int n_firstArray = (mid - left) + 1, n_secondArray = right - mid;
	int *firstArray = new int[n_firstArray];
	int *secondArray = new int[n_secondArray];
	for (int i = 0; i < n_firstArray; i++)
	{
		firstArray[i] = a[left + i];
	}
	for (int i = 0; i < n_secondArray; i++)
	{
		secondArray[i] = a[mid + 1 + i];
	}

	int i = 0, j = 0, k = left;
	while (i < n_firstArray && j < n_secondArray)
	{
		if (firstArray[i] < secondArray[j])
		{
			a[k++] = firstArray[i++];
		}
		else
		{
			a[k++] = secondArray[j++];
		}
	}
	while (i < n_firstArray)
	{
		a[k++] = firstArray[i++];
	}
	while (i < n_secondArray)
	{
		a[k++] = secondArray[i++];
	}
}

void split(int a[], int left, int right)
{
	if (left < right)
	{
		int mid = (left + right) / 2;
		split(a, left, mid);
		split(a, mid + 1, right);
		merge(a, left, mid, right);
	}
}

void MergeSort_runtime(int a[], int n)
{
	int left = 0, right = n - 1;
	split(a, left, right);
}