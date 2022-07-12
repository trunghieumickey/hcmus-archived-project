#include "syscall.h"
#include "test.h"

int main(){
    char buffer[MaxFileLength];
    char buffer2[MaxFileLength];
    int temp, temp2;
    PrintString("Enter a file name\n");
    ReadString(buffer, MaxFileLength);
    temp = Open(buffer);
    if(temp != -1){
        temp2 = Read(buffer2, MaxFileLength, temp);
        if(temp2 == -1){
            PrintString("File not found\n");
            Close(temp);
        }
        else if(temp2 == -2){
            PrintString("File is empty\n");
            Close(temp);
        }
        else{
            PrintString("File content:\n");
            do{
                PrintString(buffer2);
            }
            while(Read(buffer2, MaxFileLength, temp) > 0);
            PrintChar('\n');
            Close(temp);
        }
    }
    else{
        PrintString("File not found\n");
    }
    Halt();
}