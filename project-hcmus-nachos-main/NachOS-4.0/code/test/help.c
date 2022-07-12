#include "syscall.h"
#include "test.h"

int main()
{
    PrintString("NachOS 4.0 Beta for x86_64\n");
    PrintString("Copyright (c) 1992-1993 University of California.\n");
    PrintString("Copyright (c) 2022 Ho Chi Minh University of Science.\n");
    PrintString("Modified by Team 8 of 20CLC01 at FIT-HCMUS.\n");
    PrintString("\n");
    PrintString("shell        Open NachOS shell\n");
    PrintString("ascii        Print all character in ASCII table\n");
    PrintString("bubblesort   Sort a list using Bubble Sort algorithm\n");
    PrintString("readchar     Read a character\n");
    PrintString("printchar    Print a character\n");
    PrintString("readnum      Read a number\n");
    PrintString("printnum     Print a number\n");
    PrintString("readstring   Read a string of character\n");
    PrintString("printstring  Print a string of character\n");
    PrintString("createfile   Create new file\n");
    PrintString("cat          Print content of a file\n");
    PrintString("write        Write content to a file\n");
    PrintString("copy         Copy content of a file to another\n");
    PrintString("delete       Delete a file\n");
    PrintString("concat       Merge two file into one \n");
    PrintString("add          Test Add system call\n");
    PrintString("halt         Test system executor\n");
    PrintString("matmult      Test program to do matrix multiplication on large arrays\n");
    PrintString("sort         Test program to sort a large number of integers\n");
    PrintString("segments     Simple program to illustrate different segments\n");
    PrintString("help         Display this help\n");
    Halt();
}