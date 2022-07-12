#include "main.h"

void printArray(int a[], int n, ostream &foutput)
{
    foutput << n << " ";
    for (int i = 0; i < n; ++i)
        foutput << a[i] << " ";
    foutput << "\n";
}

void readArray(int *&a, int &n, istream &finput)
{
    finput >> n;
    a = new int[n];
    for (int i = 0; i < n; ++i)
        finput >> a[i];
}

void printFile(int a[], int n, char *filename)
{
    ofstream cfile(filename);
    printArray(a, n, cfile);
}