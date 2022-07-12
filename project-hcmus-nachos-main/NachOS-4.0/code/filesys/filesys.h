// filesys.h
//	Data structures to represent the Nachos file system.
//
//	A file system is a set of files stored on disk, organized
//	into directories.  Operations on the file system have to
//	do with "naming" -- creating, opening, and deleting files,
//	given a textual file name.  Operations on an individual
//	"open" file (read, write, close) are to be found in the OpenFile
//	class (openfile.h).
//
//	We define two separate implementations of the file system.
//	The "STUB" version just re-defines the Nachos file system
//	operations as operations on the native UNIX file system on the machine
//	running the Nachos simulation.
//
//	The other version is a "real" file system, built on top of
//	a disk simulator.  The disk is simulated using the native UNIX
//	file system (in a file named "DISK").
//
//	In the "real" implementation, there are two key data structures used
//	in the file system.  There is a single "root" directory, listing
//	all of the files in the file system; unlike UNIX, the baseline
//	system does not provide a hierarchical directory structure.
//	In addition, there is a bitmap for allocating
//	disk sectors.  Both the root directory and the bitmap are themselves
//	stored as files in the Nachos file system -- this causes an interesting
//	bootstrap problem when the simulated disk is initialized.
//
// Copyright (c) 1992-1993 The Regents of the University of California.
// All rights reserved.  See copyright.h for copyright notice and limitation
// of liability and disclaimer of warranty provisions.

#ifndef FS_H
#define FS_H
#define SlotSize 128

#include "copyright.h"
#include "sysdep.h"
#include "openfile.h"

#ifdef FILESYS_STUB


class FileSystem
{
public:
	OpenFile **openf;
	int index;
	FileSystem()
	{
		openf = new OpenFile *[SlotSize];
		index = 0;
		for (int i = 2; i < SlotSize; ++i)
		{
			openf[i] = NULL;
		}
		this->Create("stdin", 0);
		this->Create("stdout", 0);
		openf[index++] = this->Open("stdin", 2);
		openf[index++] = this->Open("stdout", 3);
	}
	~FileSystem()
	{
		for (int i = 2; i < SlotSize; ++i)
		{
			if (openf[i] != NULL)
				delete openf[i];
		}
		delete[] openf;
	}
	bool Create(char *name, int initialSize)
	{
		int fileDescriptor = OpenForWrite(name);

		if (fileDescriptor == -1)
			return FALSE;
		Close(fileDescriptor);
		return TRUE;
	}
	OpenFile *Open(char *name)
	{
		int fileDescriptor = OpenForReadWrite(name, FALSE);

		if (fileDescriptor == -1)
			return NULL;
		return new OpenFile(fileDescriptor);
	}
	OpenFile *Open(char *name, int type)
	{
		int fileDescriptor = OpenForReadWrite(name, FALSE);
		if (fileDescriptor == -1)
			return NULL;
		return new OpenFile(fileDescriptor, type);
	}
	int FindFreeSlot()
	{
		for (int i = 2; i < SlotSize; i++)
		{
			if (openf[i] == NULL)
				return i;
		}
		return -1;
	}
	bool Remove(char *name)
	{
		return Unlink(name) == 0;
	}
};

#else
class FileSystem
{
public:
	OpenFile **openf;
	int index;
	FileSystem();
	bool Create(char *name, int initialSize);
	OpenFile *Open(char *name);
	OpenFile *Open(char *name, int type);
	int FindFreeSlot();
	bool Remove(char *name);
	void List();
	void Print();

private:
	OpenFile *freeMapFile;
	OpenFile *directoryFile;
};

#endif // FILESYS

#endif // FS_H
