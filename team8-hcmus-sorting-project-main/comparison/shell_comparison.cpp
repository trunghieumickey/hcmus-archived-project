#include "sort.h"
void ShellSort_comparison(int arr[], int n, unsigned long long int &count)
{
	count = 0;
	for (int gap = n / 2; count++ && gap > 0; gap /= 2)
		for (int j = gap; count++ && j < n; j += 1)
		{
			int temp = arr[j];
			int i = 0;
			for (i = j; count++ && (i >= gap) && (arr[i - gap] > temp); i -= gap)
				arr[i] = arr[i - gap];
			arr[i] = temp;
		}
}