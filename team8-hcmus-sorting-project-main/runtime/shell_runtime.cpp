#include "sort.h"
void ShellSort_runtime(int arr[], int n)
{
	for (int gap = n / 2; gap > 0; gap /= 2)
		for (int j = gap; j < n; j += 1)
		{
			int temp = arr[j];
			int i = 0;
			for (i = j; (i >= gap) && (arr[i - gap] > temp); i -= gap)
				arr[i] = arr[i - gap];
			arr[i] = temp;
		}
}