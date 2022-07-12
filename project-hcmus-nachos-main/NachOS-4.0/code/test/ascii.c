#include "syscall.h"
#include "test.h"

int main(){
    int i = 33;
    char asii = '!';
    while (asii <= '~'){
        PrintNum(i);
        PrintChar(':');
        PrintChar(' ');
        PrintChar(asii);
        PrintChar(' ');
        PrintChar('\n');
        asii++;
        i++;
    }
    Halt();
}
