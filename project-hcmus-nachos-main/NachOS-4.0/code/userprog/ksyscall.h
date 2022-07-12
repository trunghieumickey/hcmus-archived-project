/**************************************************************
 *
 * userprog/ksyscall.h
 *
 * Kernel interface for systemcalls 
 *
 * by Marcus Voelp  (c) Universitaet Karlsruhe
 *
 **************************************************************/

#ifndef __USERPROG_KSYSCALL_H__ 
#define __USERPROG_KSYSCALL_H__ 

#include "kernel.h"
#include "synchconsole.h"
#include <climits>
#include <ctype.h>
#include <time.h>



void SysHalt()
{
  kernel->interrupt->Halt();
}


int SysAdd(int op1, int op2)
{
  return op1 + op2;
}

int ReadNum()
{
  int num = 0, n = 0;
  bool negative = 0, read = 1;
  char ch;
  ch = kernel->synchConsoleIn->GetChar();
  if(ch == '-')
  {
    negative = 1;
  }
  else if(ch >= '0' && ch <= '9') 
  {
    num = ch - '0';
    n++;
  }
  else return 0;

  ch = kernel->synchConsoleIn->GetChar();
  while(ch != '\n')
  {
    if(ch >= '0' && ch <= '9')
    {
      if(ch != ' ')
      {
        if(read)
        {
          n++;
          if(n > 10)
          {
            read = 0;
          }
          else if(n == 10)
          {
            if((negative == 0 && num > INT_MAX/10) || (negative == 1 && num > INT_MAX/10 + 1))
            {
              read = 0;
            }
            else if((negative == 0 && num == INT_MAX/10 && ch > '7') || (negative == 1 && num == INT_MAX/10 + 1 && ch > '8'))
            {
              read = 0;
            }
            else
            {
              num *= 10;
              num += ch - '0';
            }
          }
          else
          {
            num *= 10;
            num += ch - '0';
          }
        }
      }
      else return 0;
    }
    ch = kernel->synchConsoleIn->GetChar();
  }
  if (negative) num *= -1;
  return num;
}

void PrintNum(int num)
{
  if(num < 0)
  {
    kernel->synchConsoleOut->PutChar('-');
    num *= -1;
  }
  int last = -1;
  if(num - 1000000000 >= 0)
  {
    last = num % 10;
    num /= 10;
  }
  char ch;
  int digit = 0;
  int tigid = 10;
  int temp = num;
  while(num / tigid != 0)
  {
    ++digit;
    tigid *= 10;
  }
  tigid /= 10;
  int i = 0;
  for(i = digit; i >= 0; --i)
  {
    ch = temp / tigid;
    temp %= tigid;
    tigid /= 10;
    kernel->synchConsoleOut->PutChar(ch + '0');
  }
  if(last != -1)
  {
    ch = last;
    kernel->synchConsoleOut->PutChar(ch + '0');
  }
}


int RandomNum()
{
  srand (time(NULL));
  return (rand() % (INT_MAX));
}

void PrintChar(char ch){
  	kernel->synchConsoleOut->PutChar(ch);
}

char ReadChar(){
    char ch = kernel->synchConsoleIn->GetChar();
    return ch;
}

void ReadString (char* buffer, int length){
    int i=0;
    for(;i<=length&&buffer[i-1]!='\n';i++) buffer[i] = kernel->synchConsoleIn->GetChar();
    buffer[i-1] = '\0';
}

void PrintString (char* buffer){
    for(int i=0;buffer[i]!='\0';i++) kernel->synchConsoleOut->PutChar(buffer[i]);
}

#endif /* ! __USERPROG_KSYSCALL_H__ */
