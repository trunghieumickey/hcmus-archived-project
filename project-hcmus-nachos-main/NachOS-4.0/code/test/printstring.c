#include "syscall.h"
#include "test.h"

int main(){
	char buffer[6] = {'h','e','l','l','o','\0'};
	PrintString(buffer);
	Halt();
}
