#include "syscall.h"
#include "test.h"

int main(){
    int temp, temp2;
    char buffer[MaxFileLength];
    char buffer2[MaxFileLength];
    PrintString("Enter a file name\n");
    ReadString(buffer, MaxFileLength);
    temp = Open(buffer);
    if(temp != -1){
        PrintString("File word count:\n");
        temp2 = ReadNum();
        PrintString("Enter file content\n");
        ReadString(buffer2, temp2);
        if(Write(buffer2, temp2, temp) == -1){
            PrintString("Can't write file\n");
            Close(temp);
        }
        else{
            PrintString("File writen\n");
            Close(temp);
        }
    }
    else if(temp == -1){
        PrintString("No space\n");
    }
    Halt();
}
