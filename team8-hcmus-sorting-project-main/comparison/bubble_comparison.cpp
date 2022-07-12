#include "sort.h"

void BubbleSort_comparison(int a[], int n, unsigned long long int &count)
{
    bool check = true;
    while (check)
    {
        check = false;
        for (int i = 0; ++count && i < n - 1; i++)
            if (++count && a[i] > a[i + 1])
            {
                swap(a[i], a[i + 1]);
                check = true;
            }
    }
}