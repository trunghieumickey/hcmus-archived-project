#include "sort.h"

void SelectionSort_comparison(int a[], int n, unsigned long long int &count)
{
    int i, j, min_of_arr;
    for (i = 0; ++count && i < n - 1; i++)
    {
        min_of_arr = i;
        for (j = i + 1; ++count && j < n; j++)
            if (++count && a[j] < a[min_of_arr])
                min_of_arr = j;
        swap(a[min_of_arr], a[i]);
    }
}