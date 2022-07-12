#include "sort.h"

void BubbleSort_runtime(int a[], int n)
{
    bool check = true;
    while (check)
    {
        check = false;
        for (int i = 0; i < n - 1; i++)
            if (a[i] > a[i + 1])
            {
                swap(a[i], a[i + 1]);
                check = true;
            }
    }
}