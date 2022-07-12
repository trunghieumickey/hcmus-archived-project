#include "syscall.h"
#include "test.h"
		
void BubbleSort(int* a, int size)
{
    int swapped = 0;
    int temp;
    int i;
    int j;
    for (i = 0; i < (size - 1); i++)
    {
        swapped = 0;
        for (j = 0; j < (size - i) - 1; j++)
        {
            if(a[j] > a[j + 1])
            {
                temp = a[j];
                a[j] = a[j + 1];
                a[j + 1] = temp;
                swapped = 1;
            }
        }
        if (swapped == 0) break;
    }
}

void RevBubbleSort(int* a, int size)
{
    int swapped = 0;
    int temp;
    int i;
    int j;
    for (i = 0; i < (size - 1); i++)
    {
        swapped = 0;
        for (j = 0; j < (size - i) - 1; j++)
        {
            if(a[j] < a[j + 1])
            {
                temp = a[j];
                a[j] = a[j + 1];
                a[j + 1] = temp;
                swapped = 1;
            }
        }
        if (swapped == 0) break;
    }
}

int main()
{   
    int n;
    int array[100];
    int i;
    int rev;
    PrintString("Enter array size\n");
	n = ReadNum();
	while(n <= 0 && n > 100) 
	{
		PrintString("Array size need to be lower than 100, please choose another size\n");
		n = ReadNum();
	}
    
	PrintString("Enter array elements\n");
	for(i = 0; i < n; i++){
		array[i] = ReadNum();
    }
	PrintString("Asc: 1 ; Desc: 0\n");
	rev =  ReadNum();
	if(rev) BubbleSort(array, n);
	else RevBubbleSort(array, n);

	PrintString("Result: \n");
	for(i = 0; i < n; i++){
		PrintNum(array[i]);
        PrintChar(' ');
	}
    PrintChar('\n');
    Halt();
}
