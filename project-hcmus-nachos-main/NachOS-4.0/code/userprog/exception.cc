// exception.cc
//	Entry point into the Nachos kernel from user programs.
//	There are two kinds of things that can cause control to
//	transfer back to here from user code:
//
//	syscall -- The user code explicitly requests to call a procedure
//	in the Nachos kernel.  Right now, the only function we support is
//	"Halt".
//
//	exceptions -- The user code does something that the CPU can't handle.
//	For instance, accessing memory that doesn't exist, arithmetic errors,
//	etc.
//
//	Interrupts (which can also cause control to transfer from user
//	code into the Nachos kernel) are handled elsewhere.
//
// For now, this only handles the Halt() system call.
// Everything else core dumps.
//
// Copyright (c) 1992-1996 The Regents of the University of California.
// All rights reserved.  See copyright.h for copyright notice and limitation
// of liability and disclaimer of warranty provisions.

#include "copyright.h"
#include "main.h"
#include "syscall.h"
#include "ksyscall.h"

#define MaxFileLength 255
#define SlotSize 128
//----------------------------------------------------------------------
// ExceptionHandler
// 	Entry point into the Nachos kernel.  Called when a user program
//	is executing, and either does a syscall, or generates an addressing
//	or arithmetic exception.
//
// 	For system calls, the following is the calling convention:
//
// 	system call code -- r2
//		arg1 -- r4
//		arg2 -- r5
//		arg3 -- r6
//		arg4 -- r7
//
//	The result of the system call, if any, must be put back into r2.
//
// If you are handling a system call, don't forget to increment the pc
// before returning. (Or else you'll loop making the same system call forever!)
//
//	"which" is the kind of exception.  The list of possible exceptions
//	is in machine.h.
//----------------------------------------------------------------------

char *User2System(int virtAddr, int limit)
{
	int i;
	int oneChar;
	char *kernelBuf = NULL;
	kernelBuf = new char[limit + 1];
	if (kernelBuf == NULL)
		return kernelBuf;

	memset(kernelBuf, 0, limit + 1);

	for (i = 0; i < limit; i++)
	{
		kernel->machine->ReadMem(virtAddr + i, 1, &oneChar);
		kernelBuf[i] = (char)oneChar;
		if (oneChar == 0)
			break;
	}
	return kernelBuf;
}

int System2User(int virtAddr, int len, char *buffer)
{
	if (len < 0)
		return -1;
	if (len == 0)
		return len;
	int i = 0;
	int oneChar = 0;
	do
	{
		oneChar = (int)buffer[i];
		kernel->machine->WriteMem(virtAddr + i, 1, oneChar);
		i++;
	} while (i < len && oneChar != 0);
	return i;
}

void IncreasePC()
{
	kernel->machine->WriteRegister(PrevPCReg, kernel->machine->ReadRegister(PCReg));
	kernel->machine->WriteRegister(PCReg, kernel->machine->ReadRegister(PCReg) + 4);
	kernel->machine->WriteRegister(NextPCReg, kernel->machine->ReadRegister(PCReg) + 4);
}

void ExceptionHandler(ExceptionType which)
{
	int type = kernel->machine->ReadRegister(2);

	DEBUG(dbgSys, "Received Exception " << which << " type: " << type << "\n");

	switch (which)
	{
	case NoException:
		break;

	case PageFaultException:
	case ReadOnlyException:
	case BusErrorException:
	case AddressErrorException:
	case OverflowException:
	case IllegalInstrException:
	case NumExceptionTypes:
		DEBUG(dbgSys, "Runtime Error\n");
		SysHalt();
		ASSERTNOTREACHED();
		break;

	case SyscallException:
		switch (type)
		{
		case SC_Halt:
			DEBUG(dbgSys, "Shutdown, initiated by user program.\n");

			SysHalt();

			ASSERTNOTREACHED();
			break;

		case SC_Add:
			DEBUG(dbgSys, "Add " << kernel->machine->ReadRegister(4) << " + " << kernel->machine->ReadRegister(5) << "\n");

			/* Process SysAdd Systemcall*/
			int result_SC_Add;
			result_SC_Add = SysAdd(/* int op1 */ (int)kernel->machine->ReadRegister(4),
								   /* int op2 */ (int)kernel->machine->ReadRegister(5));

			DEBUG(dbgSys, "Add returning with " << result_SC_Add << "\n");
			/* Prepare Result */
			kernel->machine->WriteRegister(2, (int)result_SC_Add);

			/* Modify return point */
			{
				/* set previous programm counter (debugging only)*/
				kernel->machine->WriteRegister(PrevPCReg, kernel->machine->ReadRegister(PCReg));

				/* set programm counter to next instruction (all Instructions are 4 byte wide)*/
				kernel->machine->WriteRegister(PCReg, kernel->machine->ReadRegister(PCReg) + 4);

				/* set next programm counter for brach execution */
				kernel->machine->WriteRegister(NextPCReg, kernel->machine->ReadRegister(PCReg) + 4);
			}

			return;

			ASSERTNOTREACHED();

			break;

		case SC_PrintChar:
			DEBUG(dbgSys, "Print a char:\n");
			PrintChar((char)kernel->machine->ReadRegister(4));
			DEBUG(dbgSys, "Print a complete\n");
			IncreasePC();
			return;
			ASSERTNOTREACHED();
			break;

		case SC_RandomNum:
			kernel->machine->WriteRegister(2, RandomNum());
			IncreasePC();
			return;
			ASSERTNOTREACHED();
			break;

		case SC_ReadNum:
			DEBUG(dbgSys, "Enter:\n");
			kernel->machine->WriteRegister(2, ReadNum());
			IncreasePC();
			return;
			ASSERTNOTREACHED();
			break;

		case SC_PrintNum:
			PrintNum(kernel->machine->ReadRegister(4));
			IncreasePC();
			return;
			ASSERTNOTREACHED();
			break;

		case SC_ReadChar:
			DEBUG(dbgSys, "Read a char:\n");
			char result_SC_ReadChar;
			result_SC_ReadChar = ReadChar();
			DEBUG(dbgSys, "The character is:" << result_SC_ReadChar << "\n");
			kernel->machine->WriteRegister(2, result_SC_ReadChar);
			IncreasePC();
			return;
			ASSERTNOTREACHED();
			break;

		case SC_ReadString:
		{
			int virtAddr, length;
			char *buffer;
			virtAddr = kernel->machine->ReadRegister(4);
			length = kernel->machine->ReadRegister(5);
			buffer = User2System(virtAddr, length);
			ReadString(buffer, length);
			System2User(virtAddr, length, buffer);
			delete buffer;
			IncreasePC();
			return;
			break;
		}

		case SC_PrintString:
		{
			int virtAddr;
			char *buffer;
			virtAddr = kernel->machine->ReadRegister(4);
			buffer = User2System(virtAddr, 255);
			int length = 0;
			while (buffer[length] != 0)
				length++;
			PrintString(buffer);
			delete buffer;
			IncreasePC();
			return;
			break;
		}

		case SC_Create:
		{
			int virtAddr;
			char *filename;
			virtAddr = kernel->machine->ReadRegister(4);
			filename = User2System(virtAddr, MaxFileLength + 1);
			if (strlen(filename) == 0 || filename == NULL || !kernel->fileSystem->Create(filename, 0))
			{
				DEBUG(dbgSys, "Error\n");
				kernel->machine->WriteRegister(2, -1);
				delete[] filename;
				IncreasePC();
				return;
				break;
			}
			kernel->machine->WriteRegister(2, 0);
			delete filename;
			IncreasePC();
			return;
			break;
		}

		case SC_Open:
		{
			int virtAddr = kernel->machine->ReadRegister(4);
			char *filename;
			filename = User2System(virtAddr, MaxFileLength);
			int freeSlot = kernel->fileSystem->FindFreeSlot();
			if (freeSlot != -1){
				kernel->machine->WriteRegister(2, freeSlot);
				kernel->fileSystem->openf[freeSlot] = kernel->fileSystem->Open(filename);
				delete[] filename;
				IncreasePC();
				return;
				break;
			}
			else
			{	
				kernel->machine->WriteRegister(2, -1);
				delete[] filename;
				IncreasePC();
				return;
				break;
			}
		}

		case SC_Close:
		{
			int fid = kernel->machine->ReadRegister(4);
			if (fid >= 2 && fid <= SlotSize)
			{
				if (kernel->fileSystem->openf[fid])
				{
					delete kernel->fileSystem->openf[fid];
					kernel->fileSystem->openf[fid] = NULL;
					kernel->machine->WriteRegister(2, 0);
					IncreasePC();
					return;
					break;
				}
			}
			kernel->machine->WriteRegister(2, -1);
			IncreasePC();
			return;
			break;
		}

		case SC_Read:
		{
			int virtAddr = kernel->machine->ReadRegister(4);
			int charcount = kernel->machine->ReadRegister(5);
			int id = kernel->machine->ReadRegister(6);
			int OldPos;
			int NewPos;
			char *buf;
			if (id < 2 || id > SlotSize || kernel->fileSystem->openf[id] == NULL || kernel->fileSystem->openf[id]->type == 3) 
			{
				DEBUG(dbgSys, "Error\n");
				kernel->machine->WriteRegister(2, -1);
				IncreasePC();
				return;
				break;
			}
			OldPos = kernel->fileSystem->openf[id]->GetCurrentPos();
			buf = User2System(virtAddr, charcount); 
			if (kernel->fileSystem->openf[id]->type == 2)
			{				
				int size = 0;
				for (int i = 0; i < charcount; i++)
				{
					if (kernel->synchConsoleIn->GetChar() != '\0')
						size++;
					else
						break;
				}
				System2User(virtAddr, size, buf); 
				kernel->machine->WriteRegister(2, size);
				delete buf;
				IncreasePC();
				return;
			}
			if ((kernel->fileSystem->openf[id]->Read(buf, charcount)) > 0)
			{
				NewPos = kernel->fileSystem->openf[id]->GetCurrentPos();
				System2User(virtAddr, NewPos - OldPos, buf); 
				kernel->machine->WriteRegister(2, NewPos - OldPos);
			}
			else
			{
				kernel->machine->WriteRegister(2, -2);
			}
			delete buf;
			IncreasePC();
			return;
			break;
		}

		case SC_Write:
		{
			int virtAddr = kernel->machine->ReadRegister(4);
			int charcount = kernel->machine->ReadRegister(5);
			int id = kernel->machine->ReadRegister(6);
			int OldPos, NewPos;
			char *buf;
			if (id < 2 || id > SlotSize || kernel->fileSystem->openf[id] == NULL || kernel->fileSystem->openf[id]->type == 1 || kernel->fileSystem->openf[id]->type == 2)
			{
				kernel->machine->WriteRegister(2, -1);
				IncreasePC();
				return;
			}
			OldPos = kernel->fileSystem->openf[id]->GetCurrentPos(); 
			buf = User2System(virtAddr, charcount);
			if (kernel->fileSystem->openf[id]->type == 0)
			{
				if ((kernel->fileSystem->openf[id]->Write(buf, charcount)) > 0)
				{
					NewPos = kernel->fileSystem->openf[id]->GetCurrentPos();
					kernel->machine->WriteRegister(2, NewPos - OldPos);
					delete buf;
					IncreasePC();
					return;
				}
			}
			if (kernel->fileSystem->openf[id]->type == 3)
			{
				int i = 0;
				while (buf[i] != 0 && buf[i] != '\n')
				{
					kernel->synchConsoleOut->PutChar(buf[i]);
					i++;
				}
				buf[i] = '\n';
				kernel->synchConsoleOut->PutChar(buf[i]);
				kernel->machine->WriteRegister(2, i - 1);
				delete buf;
				IncreasePC();
				return;
			}
			IncreasePC();
			return;
			break;
		}

		case SC_Seek:
		{
			int pos = kernel->machine->ReadRegister(4);
			int id = kernel->machine->ReadRegister(5);
			if (id <= 1 || id > SlotSize || kernel->fileSystem->openf[id] == NULL)
			{
				kernel->machine->WriteRegister(2, -1);
				IncreasePC();
				return;
			}
			pos = (pos == -1) ? kernel->fileSystem->openf[id]->Length() : pos;
			if (pos > kernel->fileSystem->openf[id]->Length() || pos < 0) 
			{
				kernel->machine->WriteRegister(2, -1);
			}
			else
			{
				kernel->fileSystem->openf[id]->Seek(pos);
				kernel->machine->WriteRegister(2, pos);
			}
			IncreasePC();
			return;
			break;
		}
		
		case SC_Remove:
		{
			int virtAddr = kernel->machine->ReadRegister(4);
			char *filename = User2System(virtAddr, MaxFileLength);
			if (kernel->fileSystem->Remove(filename) == -1)
			{
				kernel->machine->WriteRegister(2, -1);
				IncreasePC();
				return;
			}
			else
			{
				kernel->machine->WriteRegister(2, 0);
				IncreasePC();
				return;
			}
			delete filename;
			break;	
		}
		default:
			cerr << "Unexpected system call " << type << "\n";
			break;
		}
		break;
		
	default:
		cerr << "Unexpected user mode exception" << (int)which << "\n";
		break;
	}
	ASSERTNOTREACHED();
}
