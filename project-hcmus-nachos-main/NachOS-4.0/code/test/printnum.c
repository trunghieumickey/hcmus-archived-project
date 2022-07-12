#include "syscall.h"
#include "test.h"

int main(){
	int x;
	PrintString("Num: ");
	x = ReadNum();
	PrintNum(x);
	Halt();
}
	