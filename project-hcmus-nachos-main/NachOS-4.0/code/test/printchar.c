#include "syscall.h"
#include "test.h"

int main(){
	char x = ReadChar();
	PrintChar(x);
	Halt();
}
	