#include "main.h"

int convertCode(char *text)
{
    if (!strcmp("selection-sort", text) || !strcmp("-rand", text))
        return 1;
    else if (!strcmp("insertion-sort", text) || !strcmp("-sorted", text))
        return 2;
    else if (!strcmp("bubble-sort", text) || !strcmp("-rev", text))
        return 3;
    else if (!strcmp("shaker-sort", text) || !strcmp("-nsorted", text))
        return 4;
    else if (!strcmp("shell-sort", text))
        return 5;
    else if (!strcmp("heap-sort", text))
        return 6;
    else if (!strcmp("merge-sort", text))
        return 7;
    else if (!strcmp("quick-sort", text))
        return 8;
    else if (!strcmp("counting-sort", text))
        return 9;
    else if (!strcmp("radix-sort", text))
        return 10;
    else if (!strcmp("flash-sort", text))
        return 11;
    else
        return 0;
}

int main(int argc, char *argv[])
{
    int Algorithm1, *a = NULL, *b = NULL, n;
    char ModeList[4][14] = {"Randomize", "Sorted", "Reversed", "Nearly Sorted"};
    Algorithm1 = convertCode(argv[2]);
    if (!strcmp(argv[1], "-a"))
    {
        cout << "ALGORITMH MODE" << endl;
        cout << "Algorithm: " << argv[2] << endl;
        ifstream inputf(argv[3]);
        if (inputf)
        {
            readArray(a, n, inputf);
            b = new int[n];
            copy(a, a + n, b);
            cout << "Input file: " << argv[3] << endl;
            cout << "Input size: " << n << endl;
            cout << "-------------------------" << endl;
            if (!strcmp(argv[4], "-time") || !strcmp(argv[4], "-both"))
                cout << "Running time: " << SortData_runtime(a, n, Algorithm1) << endl;
            if (!strcmp(argv[4], "-comp") || !strcmp(argv[4], "-both"))
                cout << "Comparisons: " << SortData_comparison(b, n, Algorithm1) << endl;
            printFile(b, n, (char *)"output.txt");
            delete[] a;
            delete[] b;
            return 0;
        }
        n = atoi(argv[3]);
        cout << "Input size: " << n << endl;
        int mode = convertCode(argv[4]);
        if (mode)
        {
            GenerateData(a, n, mode);
            printFile(a, n, (char *)"input.txt");
            b = new int[n];
            copy(a, a + n, b);
            cout << "Input order: " << ModeList[mode - 1] << endl;
            cout << "-------------------------" << endl;
            if (!strcmp(argv[5], "-time") || !strcmp(argv[5], "-both"))
                cout << "Running time: " << SortData_runtime(a, n, Algorithm1) << endl;
            if (!strcmp(argv[5], "-comp") || !strcmp(argv[5], "-both"))
                cout << "Comparisons: " << SortData_comparison(b, n, Algorithm1) << endl;
            printFile(b, n, (char *)"output.txt");
            delete[] a;
            delete[] b;
            return 0;
        }
        for (int i = 1; i <= 4; i++)
        {
            GenerateData(a, n, i);
            char Filename[12] = "input_", numchar = '0' + i, *c = &numchar;
            c[1] = '\0';
            strcat(Filename, c);
            strcat(Filename, ".txt");
            printFile(a, n, Filename);
            b = new int[n];
            copy(a, a + n, b);
            cout << endl;
            cout << "Input order: " << ModeList[i] << endl;
            cout << "-------------------------" << endl;
            if (!strcmp(argv[4], "-time") || !strcmp(argv[4], "-both"))
                cout << "Running time: " << SortData_runtime(a, n, Algorithm1) << endl;
            if (!strcmp(argv[4], "-comp") || !strcmp(argv[4], "-both"))
                cout << "Comparisons: " << SortData_comparison(b, n, Algorithm1) << endl;
            delete[] a;
            delete[] b;
        }
        return 0;
    }
    if (!strcmp(argv[1], "-c"))
    {
        cout << "COMPARE MODE" << endl;
        int Algorithm2 = convertCode(argv[3]);
        cout << "Algorithm: " << argv[2] << " | " << argv[3] << endl;
        ifstream inputf(argv[4]);
        if (inputf)
        {
            readArray(a, n, inputf);
            cout << "Input file: " << argv[4] << endl;
            cout << "Input size: " << n << endl;
        }
        else
        {
            n = atoi(argv[4]);
            cout << "Input size: " << n << endl;
            int mode = convertCode(argv[4]);
            if (mode)
            {
                GenerateData(a, n, mode);
                printFile(a, n, (char *)"input.txt");
            }
            cout << "Input order: " << ModeList[mode - 1] << endl;
        }
        cout << "-------------------------" << endl;
        cout << "Running time: ";
        b = new int[n];
        copy(a, a + n, b);
        cout << SortData_runtime(b, n, Algorithm1) << " | ";
        delete[] b;
        b = new int[n];
        copy(a, a + n, b);
        cout << SortData_runtime(b, n, Algorithm2) << endl;
        delete[] b;
        cout << "Comparisons: ";
        b = new int[n];
        copy(a, a + n, b);
        cout << SortData_comparison(b, n, Algorithm1) << " | ";
        delete[] b;
        b = new int[n];
        copy(a, a + n, b);
        cout << SortData_comparison(b, n, Algorithm2) << endl;
        delete[] b;
        delete[] a;
        return 0;
    }
    cerr << "Invaild Input";
    return 0;
}
