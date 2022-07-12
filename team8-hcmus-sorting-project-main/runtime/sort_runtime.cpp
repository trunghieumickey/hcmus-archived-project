#include "../main.h"
#include "sort.h"
long double SortData_runtime(int a[], int n, int sortType){
    clock_t start, end;
    start = clock();
    switch (sortType)
	{
        case 1: SelectionSort_runtime(a,n); break;
        case 2: InsertionSort_runtime(a,n); break;
        case 3: BubbleSort_runtime(a,n); break;
        case 4: ShakerSort_runtime(a,n); break;
        case 5: ShellSort_runtime(a,n); break;
        case 6: HeapSort_runtime(a,n); break;
        case 7: MergeSort_runtime(a,n); break;
        case 8: QuickSort_runtime(a,n); break;
        case 9: CountingSort_runtime(a,n); break;
        case 10: RadixSort_runtime(a,n); break;
        case 11: FlashSort_runtime(a,n); break;
	}
    end = clock();
    return (long double)(end-start)*1000 / CLOCKS_PER_SEC;
}