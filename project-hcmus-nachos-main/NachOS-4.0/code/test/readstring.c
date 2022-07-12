#include "syscall.h"
#include "test.h"

int main(){
	char buffer[BufferSize];
	ReadString(buffer,BufferSize);
	PrintString(buffer);	
	Halt();
}