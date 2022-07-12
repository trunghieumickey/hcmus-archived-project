#include "../main.h"
#include "sort.h"
unsigned long long int SortData_comparison(int a[], int n, int sortType){
    unsigned long long int count=0;
    switch (sortType)
	{
        case 1: SelectionSort_comparison(a,n,count); break;
        case 2: InsertionSort_comparison(a,n,count); break;
        case 3: BubbleSort_comparison(a,n,count); break;
        case 4: ShakerSort_comparison(a,n,count); break;
        case 5: ShellSort_comparison(a,n,count); break;
        case 6: HeapSort_comparison(a,n,count); break;
        case 7: MergeSort_comparison(a,n,count); break;
        case 8: QuickSort_comparison(a,n,count); break;
        case 9: CountingSort_comparison(a,n,count); break;
        case 10: RadixSort_comparison(a,n,count); break;
        case 11: FlashSort_comparison(a,n,count); break;
	}
    return count;
}