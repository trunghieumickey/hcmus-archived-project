#include "syscall.h"
#include "test.h"

int main(){
    int src, des, filesize, t;
    char source[MaxFileLength];
    char dest[MaxFileLength];
    char buffer[BufferSize];

    PrintString("- Base file name: ");
    ReadString(dest, MaxFileLength);

    PrintString("- Additional file name: ");
    ReadString(source, MaxFileLength);
    
    src = Open(source);
    des = Open(dest);
    if(src != -1 && des != -1 && Read(buffer, BufferSize, des) > 0)
    {
        Seek(-1, des);
        while((t = Read(buffer, BufferSize, src)) > 0) Write(buffer, t, des);
        PrintString("File Appended\n");
        Close(src);
        Close(des);
    }
    else
    {
        PrintString("Can't open file\n");
    }
    Halt();
}