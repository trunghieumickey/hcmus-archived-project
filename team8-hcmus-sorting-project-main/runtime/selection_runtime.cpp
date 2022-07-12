#include "sort.h"
void SelectionSort_runtime(int a[], int n)
{
    int i, j, min_of_arr;
    for (i = 0; i < n - 1; i++)
    {
        min_of_arr = i;
        for (j = i + 1; j < n; j++)
            if (a[j] < a[min_of_arr])
                min_of_arr = j;
        swap(a[min_of_arr], a[i]);
    }
}
