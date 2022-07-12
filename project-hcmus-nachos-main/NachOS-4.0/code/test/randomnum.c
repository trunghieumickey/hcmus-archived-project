#include "syscall.h"
#include "test.h"

int main(){
	int x = RandomNum();
	PrintNum(x);
	Halt();
}