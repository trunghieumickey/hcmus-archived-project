#include "syscall.h"
#include "test.h"

int main(){
    int src, des, filesize, t;
    char source[MaxFileLength];
    char dest[MaxFileLength];
    char buffer[BufferSize];

    PrintString("- Source file name: ");
    ReadString(source, MaxFileLength);

    PrintString("- Destination file name: ");
    ReadString(dest, MaxFileLength);
    src = Open(source);

    if(src != -1){
        des = Create(dest);
        des = Open(dest);

        if(des != -1)
        {
            while((t=Read(buffer, BufferSize, src))%BufferSize != 0 && t>0)
            {
                Write(buffer, t, des);
            }
            PrintString("File copied\n");
            Close(src);
        }
        else
        {
            PrintString("Can't create file\n");
        }
        Close(des);
    }
    else
    {
        PrintString("Can't open file\n");
    }
    Halt();
}