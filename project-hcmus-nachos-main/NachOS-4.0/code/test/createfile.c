#include "syscall.h"
#include "test.h"

int main(){
    int temp;
    char buffer[MaxFileLength];
    PrintString("Enter a file name\n");
    ReadString(buffer, MaxFileLength);
    temp = Open(buffer);
    if(temp != -1){
        if(!Create(buffer)){
            PrintString("File created\n");
        }
        else{
            PrintString("File creation failed\n");
        }
    }
    else if(temp == -1){
        PrintString("No space\n");
    }
    Halt();
}