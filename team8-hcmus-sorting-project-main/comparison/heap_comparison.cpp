#include "sort.h"

void HeapShift(int a[], int n, int i, unsigned long long int &count)
{
    int largest = i;
    int l = 2 * i + 1;
    if (++count && l < n && ++count && a[l] > a[largest])
        largest = l;
    if (++count && l + 1 < n && ++count && a[l + 1] > a[largest])
        largest = l + 1;
    if (largest != i)
    {
        swap(a[i], a[largest]);
        HeapShift(a, n, largest, count);
    }
}

void HeapSort_comparison(int a[], int n, unsigned long long int &count)
{
    for (int i = n / 2 - 1; ++count && i >= 0; i--)
        HeapShift(a, n, i, count);
    for (int i = n - 1; ++count && i > 0; i--)
    {
        swap(a[0], a[i]);
        HeapShift(a, i, 0, count);
    }
}
