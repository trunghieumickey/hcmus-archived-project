#include <iostream>
#include <fstream>
#include <cmath>
#include <ctime>
#include <cstring>
#include <cstdlib>
using namespace std;

void GenerateData(int *&a, int n, int dataType);
long double SortData_runtime(int a[], int n, int sortType);
unsigned long long int SortData_comparison(int a[], int n, int sortType);
void printArray(int a[], int n, ostream &foutput = cout);
void readArray(int *&a, int &n, istream &finput = cin);
void printFile(int a[], int n, char *filename);