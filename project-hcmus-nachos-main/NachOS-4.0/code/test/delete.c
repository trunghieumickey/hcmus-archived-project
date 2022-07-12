#include "syscall.h"
#include "test.h"

int main(){
    int temp;
    char buffer[MaxFileLength];
    PrintString("Enter a file name\n");
    ReadString(buffer, MaxFileLength);
    temp = Open(buffer);
    if(temp != -1){
        if(!Remove(buffer)){
            PrintString("File deleted\n");
        }
        else{
            PrintString("File deletion failed\n");
        }
    }
    else if(temp == -1){
        PrintString("File deletion failed\n");
    }
    Halt();
}