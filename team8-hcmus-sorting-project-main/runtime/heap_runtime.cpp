#include "sort.h"

void HeapShift(int a[], int n, int i)
{
    int largest = i;
    int l = 2 * i + 1;
    if (l < n && a[l] > a[largest])
        largest = l;
    if (l + 1 < n && a[l + 1] > a[largest])
        largest = l + 1;
    if (largest != i)
    {
        swap(a[i], a[largest]);
        HeapShift(a, n, largest);
    }
}

void HeapSort_runtime(int a[], int n)
{
    for (int i = n / 2 - 1; i >= 0; i--)
        HeapShift(a, n, i);
    for (int i = n - 1; i > 0; i--)
    {
        swap(a[0], a[i]);
        HeapShift(a, i, 0);
    }
}